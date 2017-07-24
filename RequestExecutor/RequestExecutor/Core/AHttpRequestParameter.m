//
//  AHttpRequestParameter.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "AHttpRequestParameter.h"

@interface AHttpRequestParameter ()

@property (nonatomic, strong) NSMutableDictionary *additionalParameters;

@end

@implementation AHttpRequestParameter

-(NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    [self fillDefaultParameters:dictionary];
    [self fillParameters:dictionary];
    [dictionary addEntriesFromDictionary:_additionalParameters];
    
    return dictionary;
}

-(void)fillParameters:(NSMutableDictionary *)dictionary {
    // Override in sub classes.
}

-(void)fillDefaultParameters:(NSMutableDictionary *)dictionary {
    // If your server requires some common parameters for all requests, set them here.
}

-(void)setAdditionalParameter:(NSString *)key value:(NSString *)value {
    if (!_additionalParameters) {
        _additionalParameters = [NSMutableDictionary dictionaryWithCapacity:0];
    }

    [_additionalParameters setValue:value forKey:key];
}

@end
