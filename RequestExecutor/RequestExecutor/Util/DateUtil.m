//
//  DateUtil.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+(NSString *)formatDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}

@end
