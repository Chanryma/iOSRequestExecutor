//
//  HttpRequestResult.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Response data of a http response. This class contains:<br>
 * id of source http request<br>
 * status of response YES means success, NO means error<br>
 * message of there is one, if a request fails, message is the error message
 */
@interface HttpRequestResult : NSObject

@property (nonatomic, assign) NSInteger requestId;
/**
 *  Status code of http response.
 */
@property (nonatomic, assign) NSInteger httpStatusCode;
@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) id data;

/**
 *  Alloc an instnace for a succssfulhttp request.
 *
 *  @param requestId source request id
 *  @param data      data of a successful request
 *
 *  @return A new instance
 */
+(HttpRequestResult *)newSuccessInstance:(NSInteger)requestId data:(id)data;

/**
 *  Alloc an instnace for a failed http request.
 *
 *  @param requestId source request id
 *  @param message   error message
 *
 *  @return A new instance
 */
+(HttpRequestResult *)newErrorInstance:(NSInteger)requestId message:(NSString *)message;

/**
 *  Alloc an instance initialised with given parameters.
 *
 *  @param requestId source request id
 *  @param isSuccess YES means the request is processed successfully
 *  @param data      data of a successful request
 *  @param message additonal message descripting the result
 *
 *  @return A new instance
 */
+(HttpRequestResult *)newInstance:(NSInteger)requestId isSuccess:(BOOL)isSuccess data:(id)data message:(NSString *)message;

@end

