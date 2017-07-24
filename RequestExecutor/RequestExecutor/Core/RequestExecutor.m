//
//  RequestExecutor.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "RequestExecutor.h"
#import "StringUtil.h"
#import "LogUtil.h"

@implementation RequestExecutor

const static NSInteger HTTP_REQUEST_DEFAULT_TIMEOUT = 60;

+(void)executeAsyncGet:(NSString *)url parameter:(AHttpRequestParameter *)parameter responseListener:(AHttpResponseListener *)listener {
    [self execute:url parameter:parameter isPost:NO responseListener:listener isAsync:YES];
}

+(void)executeAsyncPost:(NSString *)url parameter:(AHttpRequestParameter *)parameter responseListener:(AHttpResponseListener *)listener {
    [self execute:url parameter:parameter isPost:YES responseListener:listener isAsync:YES];
}

+(void)executeSyncGet:(NSString *)url parameter:(AHttpRequestParameter *)parameter responseListener:(AHttpResponseListener *)listener {
    [self execute:url parameter:parameter isPost:NO responseListener:listener isAsync:NO];
}

+(void)executeSyncPost:(NSString *)url parameter:(AHttpRequestParameter *)parameter responseListener:(AHttpResponseListener *)listener {
    [self execute:url parameter:parameter isPost:YES responseListener:listener isAsync:NO];
}

+(void)execute:(NSString *)url parameter:(AHttpRequestParameter *)parameter isPost:(BOOL)isPost responseListener:(AHttpResponseListener *)listener {
    [self execute:url parameter:parameter isPost:isPost responseListener:listener isAsync:YES];
}

+(void)execute:(NSString *)url parameter:(AHttpRequestParameter *)parameter isPost:(BOOL)isPost responseListener:(AHttpResponseListener *)listener isAsync:(BOOL)isAsync {
    [self execute:url parameter:parameter isPost:isPost responseListener:listener isAsync:isAsync requestSettings:nil];
}

+(void)execute:(NSString *)url parameter:(AHttpRequestParameter *)parameter isPost:(BOOL)isPost responseListener:(AHttpResponseListener *)listener isAsync:(BOOL)isAsync requestSettings:(HttpRequestSettings *)settings {
    if ([StringUtil isBlank:url]) {
        return;
    }
    
    LogDebug(@"Sending a request to \"%@\", isPost=%d, isAsync=%d", url, isPost, isAsync);
    
    url = [url stringByAppendingFormat:@"?"];
    
    if (isPost) {
        [self sendPostRequest:url parameter:parameter isAsync:isAsync responseListener:listener settings:settings];
    } else {
        [self sendGetRequest:url parameter:parameter isAsync:isAsync listener:listener settings:settings];
    }
}

+(void)sendGetRequest:(NSString *)url parameter:(AHttpRequestParameter *)parameter isAsync:(BOOL)isAsync listener:(AHttpResponseListener *)listener settings:(HttpRequestSettings *)settings {
    url = [self appendParameters:url parameters:parameter];
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSTimeInterval timeout = settings ? settings.timeout : HTTP_REQUEST_DEFAULT_TIMEOUT;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
    [self sendRequest:request isAsync:isAsync listener:listener];
}

+(void)sendPostRequest:(NSString *)url parameter:(AHttpRequestParameter *)parameter isAsync:(BOOL)isAsync responseListener:(AHttpResponseListener *)listener settings:(HttpRequestSettings *)settings {
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    request.HTTPMethod = @"POST";
    NSTimeInterval timeout = settings ? settings.timeout : HTTP_REQUEST_DEFAULT_TIMEOUT;
    request.timeoutInterval = timeout;
    [self fillPostParameters:request parameters:parameter];
    [self sendRequest:request isAsync:isAsync listener:listener];
}

+(void)sendRequest:(NSMutableURLRequest *)request isAsync:(BOOL)isAsync listener:(AHttpResponseListener *)listener {
    [request addValue:@"application/json,*/*" forHTTPHeaderField:@"Accept"];

    if (isAsync) {
        dispatch_queue_t queue = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self sendRequest:request listener:listener];
        });
    } else {
        [self sendRequest:request listener:listener];
    }
}

+(void)sendRequest:(NSMutableURLRequest *)request listener:(AHttpResponseListener *)listener {
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (response.statusCode == 200) {
            if (data == nil) {
                NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:@"Received response from server, but response data is nil.", NSLocalizedDescriptionKey, nil];
                NSError *error1 = [NSError errorWithDomain:@"RequestExecutor" code:0 userInfo:info];
                [listener onError:request response:response error:error1];
            } else {
                [listener onRequestSuccess:request response:response receivedData:data];
            }
        } else {
            [listener onError:request response:response error:error];
        }
    });
}

+(void)fillPostParameters:(NSMutableURLRequest *)request parameters:(AHttpRequestParameter *)parameter {
    NSDictionary *paramDictionary = [parameter toDictionary];
    NSEnumerator *keys = [paramDictionary keyEnumerator];
    NSString *key = [keys nextObject];
    NSString *concatenatedParams = @"";
    while (key) {
        NSString *value = [paramDictionary objectForKey:key];
        value = [StringUtil encodeURLString:value];
        NSString *currentParam = [NSString stringWithFormat:@"%@=%@", key, value];
        concatenatedParams = [StringUtil appendString:currentParam toString:concatenatedParams withDelimeter:@"&"];
        key = [keys nextObject];
    }
    
    [request setHTTPBody:[concatenatedParams dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)appendParameters:(NSString *)url parameters:(AHttpRequestParameter *)parameter {
    NSDictionary *paramDictionary = [parameter toDictionary];
    NSEnumerator *keys = [paramDictionary keyEnumerator];
    NSString *key = [keys nextObject];
    NSString *params = @"";
    while (key) {
        NSString *value = [paramDictionary objectForKey:key];
        if (![StringUtil isBlank:params]) {
            params = [params stringByAppendingFormat:@"&"];
        }
        value = [StringUtil encodeURLString:value];
        params = [params stringByAppendingFormat:@"%@=%@", key, value];
        key = [keys nextObject];
    }
    
    url = [url stringByAppendingString:params];
    
    return url;
}

@end
