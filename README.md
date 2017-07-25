# RequestExecutor
A simple-to-use HTTP request executor on iOS.

#### How to Use:

1. Copy the [Core](RequestExecutor/RequestExecutor/Core) and [Util](RequestExecutor/RequestExecutor/Util) folders into your project.
    You may need to replace the default log implementation in [LogUtil](RequestExecutor/RequestExecutor/Util/LogUtil.h).
1. Add a request parameter and make it inherit [AHttpRequestParameter](RequestExecutor/RequestExecutor/Core/AHttpRequestParameter.h). Override `fillParameters:` method. Check [TestGetParameter](RequestExecutor/RequestExecutor/TestParameters.h) for example.
1. Make your class where you want to process the response conform to [ResponseDelegate](RequestExecutor/RequestExecutor/Core/RequestProtocol.h), and implement `processResponse:` method.
1. Create a response listener to process the response of the HTTP request.
    
     There is a  default implementation called [HttpResponseJsonListener](RequestExecutor/RequestExecutor/Core/HttpResponseJsonListener.h) which will parse the response data into JSON format. You can create your own response listener by inheriting  [AHttpResponseListener](RequestExecutor/RequestExecutor/Core/AHttpResponseListener.h).
    
1. Send your request.

    To send a `GET` request, for example, all the code you need is:
    
    ```
    -(void)sendGetRequest {
        NSString *url = @"your url here";
        HttpResponseJsonListener *listener = [HttpResponseJsonListener instanceWithRequestId:1001 observer:self]; // 1001 is used to identify a request from another
        [RequestExecutor executeAsyncGet:url parameter:[[TestGetParameter alloc] init] responseListener:listener];
    }
    
    -(void)processResponse:(HttpRequestResult *)result {
        if (result.requestId == 1001) {
            NSLog(@"requestId=%ld, %@", (long)result.requestId, result.data);
        } else if (result.requestId == 1002) {
            NSLog(@"requestId=%ld, %@", (long)result.requestId, result.data);
        } else {
            
        }
    }
    ```

