//
//  RequestExecutor.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHttpRequestParameter.h"
#import "AHttpResponseListener.h"
#import "HttpResponseJsonListener.h"
#import "HttpRequestSettings.h"

@interface RequestExecutor : NSObject

/**
 *  Perform an asynchronous GET HttpRequest.
 *
 *  @param url       url of the request
 *  @param parameter required parameter
 *  @param listener  listener to monitor the request process
 */
+(void)executeAsyncGet:(NSString *)url parameter:(AHttpRequestParameter *)parameter responseListener:(AHttpResponseListener *)listener;

/**
 *  Perform an asynchronous POST HttpRequest.
 *
 *  @param url       url of the request
 *  @param parameter required parameter
 *  @param listener  listener to monitor the request process
 */
+(void)executeAsyncPost:(NSString *)url parameter:(AHttpRequestParameter *)parameter responseListener:(AHttpResponseListener *)listener;

/**
 *  Perform a synchronous GET HttpRequest.
 *
 *  @param url       url of the request
 *  @param parameter required parameter
 *  @param listener  listener to monitor the request process
 */
+(void)executeSyncGet:(NSString *)url parameter:(AHttpRequestParameter *)parameter responseListener:(AHttpResponseListener *)listener;

/**
 *  Perform a synchronous POST HttpRequest.
 *
 *  @param url       url of the request
 *  @param parameter required parameter
 *  @param listener  listener to monitor the request process
 */
+(void)executeSyncPost:(NSString *)url parameter:(AHttpRequestParameter *)parameter responseListener:(AHttpResponseListener *)listener;

/**
 *  Perform an HttpRequest.
 *
 *  @param url       url of the request
 *  @param parameter required parameter
 *  @param isPost    YES means the request is a POST request, NO means it is a GET request.
 *  @param listener  listener to monitor the request process
 *  @param isAsync   YES means the request a asynchronous request, NO means it is a synchronous request.
 */
+(void)execute:(NSString *)url parameter:(AHttpRequestParameter *)parameter isPost:(BOOL)isPost responseListener:(AHttpResponseListener *)listener isAsync:(BOOL)isAsync;

/**
 *  Perform an HttpRequest.
 *
 *  @param url       url of the request
 *  @param parameter required parameter
 *  @param isPost    YES means the request is a POST request, NO means it is a GET request.
 *  @param listener  listener to monitor the request process
 *  @param isAsync   YES means the request a asynchronous request, NO means it is a synchronous request.
 *  @param settings  request settings. For example, timeout.
 */
+(void)execute:(NSString *)url parameter:(AHttpRequestParameter *)parameter isPost:(BOOL)isPost responseListener:(AHttpResponseListener *)listener isAsync:(BOOL)isAsync requestSettings:(HttpRequestSettings *)settings;

+(void)sendRequest:(NSMutableURLRequest *)request isAsync:(BOOL)isAsync listener:(AHttpResponseListener *)listener;

@end

