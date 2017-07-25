//
//  HttpResponseJsonListener.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "HttpResponseJsonListener.h"
#import "HttpRequestResult.h"
#import "StringUtil.h"
#import "LogUtil.h"
#import "DateUtil.h"

@interface HttpResponseJsonListener()

@property (nonatomic, assign) NSInteger requestId;
@property (nonatomic, assign) NSTimeInterval requestStartTime;
@property (nonatomic, strong) NSString * requestStartTimeStr;
@property (nonatomic, weak) id<ResponseDelegate> delegate;

@end

@implementation HttpResponseJsonListener

+(instancetype)instanceWithRequestId:(NSInteger)requestId observer:(id<ResponseDelegate>)observer {
    HttpResponseJsonListener *instance = [[HttpResponseJsonListener alloc] init];
    instance.delegate = observer;
    instance.requestId = requestId;
    instance.requestStartTime = [NSDate timeIntervalSinceReferenceDate];
    instance.requestStartTimeStr = [DateUtil formatDate:[NSDate dateWithTimeIntervalSinceReferenceDate:instance.requestStartTime] withFormat:@"HH:mm:ss.SSS"];
    LogInfo(@"Sending a request. requestId=%ld. startTime=%@.", requestId, instance.requestStartTimeStr);
    
    return instance;
}

#pragma mark- NSURLRequest Listener
-(void)onRequestSuccess:(NSURLRequest *)request response:(NSHTTPURLResponse *)response receivedData:(NSData *)receivedData {
    [self logRequestTimeCost:YES];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableLeaves error:Nil];
    LogDebug(@"Async request succeeded. ReceivedData:\n%@",dictionary);
    
    if ([self isSuccess:dictionary]) {
        [self postResultNotification:_requestId isSuccess:YES data:dictionary message:nil sourceRequest:request response:response];
    } else {
        NSString *errorMsg = [self getErrorMessage:dictionary];
        [self postResultNotification:_requestId isSuccess:NO data:dictionary message:errorMsg sourceRequest:request response:response];
    }
}

-(void)onError:(NSURLRequest *)request response:(NSHTTPURLResponse *)response error:(NSError *)error {
    [self logRequestTimeCost:NO];
    LogError(@"Request failed. Error:\n%@",error);
    NSString *errorMsg = [NSString stringWithFormat:@"%@", error.localizedDescription];
    [self postResultNotification:_requestId isSuccess:NO data:nil message:errorMsg sourceRequest:request response:response];
}

#pragma mark- Internal Operations

-(void)postResultNotification:(NSInteger)requestId isSuccess:(BOOL)isSuccess data:(id)data message:(NSString *)message sourceRequest:(NSURLRequest *)request response:(NSHTTPURLResponse *)response {
    HttpRequestResult *result = [HttpRequestResult newInstance:requestId isSuccess:isSuccess data:data message:message];
    result.httpStatusCode = response.statusCode;

    if (_delegate == nil) {
        LogInfo(@"No response handler is found. The response will be ignored.");
    } else {
        if ([_delegate respondsToSelector:@selector(processResponse:)]) {
            [_delegate processResponse:result];
        } else {
            LogError(@"You should implement 'processResponse' in your delegate.");
        }
    }

    _delegate = nil;
}

-(BOOL)isSuccess:(NSDictionary *)response {
    if ([response objectForKey:@"isSuccess"] != nil) {
        return [[response objectForKey:@"isSuccess"] boolValue];
    }
    
    if ([response objectForKey:@"success"] != nil) {
        return [[response objectForKey:@"success"] boolValue];
    }
    
    return ([response objectForKey:@"error"] == nil);
}

-(NSString *)getErrorMessage:(NSDictionary *)response {
    NSString *msg = [response objectForKey:@"msg"];
    if (!msg) {
        msg = [response objectForKey:@"message"];
    }
    
    return msg;
}

#pragma mark- Request Log
-(void)logRequestTimeCost:(BOOL)isSuccess {
    NSString *log = isSuccess ? @"Request succeeded on network level." : @"Request failed on network level.";
    NSTimeInterval timeCost = [NSDate timeIntervalSinceReferenceDate] - _requestStartTime;
    LogInfo(@"%@ requestId=%ld. startTime=%@, timeCost=%.0fms", log, _requestId, _requestStartTimeStr, (timeCost * 1000));
}

@end
