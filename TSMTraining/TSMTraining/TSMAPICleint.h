//
//  TSMAPICleint.h
//  TSMTraining
//
//  Created by Mobikasa on 01/09/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface TSMAPICleint : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
