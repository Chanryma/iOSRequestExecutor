//
//  StringUtil.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

+(BOOL)isBlank:(NSString *)string {
    if ((string == nil) || (string == NULL)) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    NSString *tmpString = [self getSafeString:string];
    tmpString = [tmpString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    tmpString = [tmpString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    if (tmpString.length == 0) {
        return YES;
    }
    
    return NO;
}

+(BOOL)isEmpty:(NSString *)string {
    return (string == nil) || [@"" isEqualToString:string];
}

+(NSString *)fromInteger:(NSInteger)value {
    return [NSString stringWithFormat:@"%ld", (long)value];
}

+(NSString *)encodeURLString:(NSString *)string {
    string = [self getSafeString:string];
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)string, NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
}

+(NSString *)decodeURLString:(NSString *)string {
    NSMutableString *outputStr = [NSMutableString stringWithString:string];
    [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
    
    return outputStr;
}

+(NSString *)getValueOfParameter:(NSString *)key fromURLQuery:(NSString *)query {
    NSArray *components = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSString *component in components) {
        NSArray *subcomponents = [component componentsSeparatedByString:@"="];
        NSString *value = [[subcomponents objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *key = [[subcomponents objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [parameters setObject:value forKey:key];
    }
    
    return [parameters objectForKey:key];
}

+(BOOL)isString:(NSString *)str1 caselessEqualTo:(NSString *)str2 {
    str1 = [self getSafeString:str1];
    str2 = [self getSafeString:str2];
    
    return [[str1 lowercaseString] isEqualToString:[str2 lowercaseString]];
}

+(BOOL)isString:(NSString *)str1 equalTo:(NSString *)str2 {
    str1 = [self getSafeString:str1];
    str2 = [self getSafeString:str2];
    
    return [str1 isEqualToString:str2];
}

+(NSString *)getSafeString:(NSString *)string {
    string = string ? string : @"";
    return [NSString stringWithFormat:@"%@", string];
}

+(NSString *)getSafeStringOfKey:(NSString *)key fromDictionary:(NSDictionary *)Dictionary {
    NSString *value = [Dictionary objectForKey:key];
    return [self getSafeString:value];
}

+(NSString *)trim:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(NSString *)appendString:(NSString *)newString toString:(NSString *)source withDelimeter:(NSString *)delimeter {
    newString = [self getSafeString:newString];
    source = [self getSafeString:source];
    delimeter = [self getSafeString:delimeter];
    
    if (![self isBlank:source]) {
        source = [source stringByAppendingString:delimeter];
    }
    
    return [source stringByAppendingString:newString];
}

+(NSString *)stringFromDictionary:(NSDictionary *)dictionary {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

+(NSDictionary *)dictionaryFromString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

@end

