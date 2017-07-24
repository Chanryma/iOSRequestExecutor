//
//  RequestProtocol.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestResult.h"

@protocol ResponseDelegate <NSObject>

-(void)processResponse:(HttpRequestResult *)result;

@end
