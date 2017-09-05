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

void CallHelloRequest(id param, APIRequestCompletion block);

void CallSessionRequest(id param, APIRequestCompletion block);

void CallAttendanceRequest(id param, APIRequestCompletion block);

void CallScoreRequest(id param, APIRequestCompletion block);

@end
