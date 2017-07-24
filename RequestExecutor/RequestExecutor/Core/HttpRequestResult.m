//
//  HttpRequestResult.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "HttpRequestResult.h"

@implementation HttpRequestResult

+(HttpRequestResult *)newSuccessInstance:(NSInteger)requestId data:(id)data {
    return [self newInstance:requestId isSuccess:YES data:data message:nil];
}

+(HttpRequestResult *)newErrorInstance:(NSInteger)requestId message:(NSString *)message {
    return [self newInstance:requestId isSuccess:NO data:nil message:message];
}

+(HttpRequestResult *)newInstance:(NSInteger)requestId isSuccess:(BOOL)isSuccess data:(id)data message:(NSString *)message {
    HttpRequestResult * instance = [[HttpRequestResult alloc] init];
    instance.requestId = requestId;
    instance.isSuccess = isSuccess;
    instance.data = data;
    instance.message = message;

    return instance;
}

@end
