//
//  HttpResponseJsonListener.h
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "AHttpResponseListener.h"
#import "RequestProtocol.h"

@interface HttpResponseJsonListener : AHttpResponseListener

/**
 Create a new HTTP response listener that will parse the response data into JSON.

 @param requestId a value to indentify a request.
 @param observer the delegate to receive the result parsed by this response listener.
 @return a new HTTP response listener.
 */
+(instancetype)instanceWithRequestId:(NSInteger)requestId observer:(id<ResponseDelegate>)observer;

@end

