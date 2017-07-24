//
//  ViewController.m
//  RequestExecutor
//
//  Created by jonathan ma on 24/7/2017.
//  Copyright © 2017 jonathan ma. All rights reserved.
//

#import "ViewController.h"
#import "RequestExecutor.h"
#import "RequestExecutor.h"
#import "StringUtil.h"
#import "HttpRequestResult.h"
#import "TestParameters.h"

@interface ViewController () <ResponseDelegate>

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(IBAction)onGetButtonClick:(id)sender {
    NSString *url = @"your url here";
    HttpResponseJsonListener *listener = [HttpResponseJsonListener instanceWithRequestId:1001 observer:self];
    [RequestExecutor executeAsyncGet:url parameter:[[TestGetParameter alloc] init] responseListener:listener];
}

-(IBAction)onPostButtonClick:(id)sender {
    NSString *url = @"your url here";
    HttpResponseJsonListener *listener = [HttpResponseJsonListener instanceWithRequestId:1002 observer:self];
    TestPostParameter *parameter = [[TestPostParameter alloc] init];
    parameter.property1 = @"property1";
    [RequestExecutor executeAsyncGet:url parameter:parameter responseListener:listener];
}

-(void)processResponse:(HttpRequestResult *)result {
    NSLog(@"requestId=%ld, %@", (long)result.requestId, result.data);
}

@end
