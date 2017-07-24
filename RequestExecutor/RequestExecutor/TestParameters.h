//
//  TestParameters.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "AHttpRequestParameter.h"

@interface TestGetParameter : AHttpRequestParameter

@property (nonatomic, strong) NSString *property1;

@end


@interface TestPostParameter : AHttpRequestParameter

@property (nonatomic, strong) NSString *property1;

@end
