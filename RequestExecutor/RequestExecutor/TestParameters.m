//
//  TestParameters.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "TestParameters.h"

@implementation TestGetParameter

-(void)fillParameters:(NSMutableDictionary *)dictionary {
    [dictionary setObject:[StringUtil getSafeString:_property1] forKey:@"p1"];
}

@end

@implementation TestPostParameter : AHttpRequestParameter

-(void)fillParameters:(NSMutableDictionary *)dictionary {
    [dictionary setObject:[StringUtil getSafeString:_property1] forKey:@"p1"];
}

@end
