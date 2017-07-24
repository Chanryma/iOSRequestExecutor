//
//  DateUtil.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

/**
 *  Get date string of a given date with the given date format.
 *
 *  @param date   source date
 *  @param format date format
 *
 *  @return date string
 */
+(NSString *)formatDate:(NSDate *)date withFormat:(NSString *)format;

@end
