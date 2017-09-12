//
//  TSMAPICleint.m
//  TSMTraining
//
//  Created by Mobikasa on 01/09/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import "TSMAPICleint.h"

@implementation TSMAPICleint

+ (instancetype)sharedClient {
    static TSMAPICleint *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[TSMAPICleint alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedClient setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        
        
        [_sharedClient.requestSerializer setValue:@"application/json;charset=ISO-8859-1" forHTTPHeaderField:@"Content-Type"];

        
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", nil];
    
        _sharedClient.requestSerializer.timeoutInterval = 30;
        
    });
    
    return _sharedClient;
}



@end
