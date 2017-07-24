//
//  AHttpResponseListener.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHttpResponseListener : NSObject

-(void)onRequestSuccess:(NSURLRequest *)request response:(NSHTTPURLResponse *)response receivedData:(NSData *)receivedData;
-(void)onError:(NSURLRequest *)request response:(NSHTTPURLResponse *)response error:(NSError *)error;

@end
