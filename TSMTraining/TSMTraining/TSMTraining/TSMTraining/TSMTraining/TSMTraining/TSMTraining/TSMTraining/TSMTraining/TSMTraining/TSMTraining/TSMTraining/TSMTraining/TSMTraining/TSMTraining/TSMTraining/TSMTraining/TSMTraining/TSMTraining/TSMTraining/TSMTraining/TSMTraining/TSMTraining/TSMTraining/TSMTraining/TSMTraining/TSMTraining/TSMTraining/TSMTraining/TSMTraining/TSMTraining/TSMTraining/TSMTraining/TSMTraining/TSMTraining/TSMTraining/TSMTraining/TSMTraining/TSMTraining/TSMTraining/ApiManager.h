//
//  ApiManager.h
//  TSMTraining
//
//  Created by Mobikasa on 01/09/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^APIRequestCompletion)(NSURLSessionDataTask *task,id JSON,NSError *error);

@interface ApiManager : NSObject

-(void)CallHelloRequest :(NSDictionary *)param andBlock:(APIRequestCompletion)block;

-(void)CallSessionRequest :(NSDictionary *)param andBlock:(APIRequestCompletion)block;

-(void)CallAttendanceRequest :(NSDictionary *)param andBlock:(APIRequestCompletion)block;

-(void)CallScoreRequest :(NSDictionary *)param andBlock:(APIRequestCompletion)block;

@end
