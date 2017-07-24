//
//  AHttpRequestParameter.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringUtil.h"

@interface AHttpRequestParameter : NSObject

/**
 *  Clients call this method to get a dictionary holding request parameters.
 *
 *  @return a dictionary holding request parameters
 */
-(NSDictionary *)toDictionary;

/**
 *  Sub classes override this method to fill parameters.
 *
 *  @param dictionary the dictionary to set parameters
 */
-(void)fillParameters:(NSMutableDictionary *)dictionary;

-(void)setAdditionalParameter:(NSString *)key value:(NSString *)value;

@end
