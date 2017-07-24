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
 *  Alloc a new instance.
 *
 *  @return A new instance.
 */
+(instancetype)instanceWithRequestId:(NSInteger)requestId observer:(id<ResponseDelegate>)observer;

@end

