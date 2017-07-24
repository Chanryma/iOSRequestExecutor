//
//  AHttpResponseListener.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "AHttpResponseListener.h"

@implementation AHttpResponseListener

-(void)onRequestSuccess:(NSURLRequest *)request response:(NSHTTPURLResponse *)response receivedData:(NSData *)receivedData {
}

-(void)onError:(NSURLRequest *)request response:(NSHTTPURLResponse *)response error:(NSError *)error {
    NSLog(@"Request failed. Error:\n%@",error);
}

@end
