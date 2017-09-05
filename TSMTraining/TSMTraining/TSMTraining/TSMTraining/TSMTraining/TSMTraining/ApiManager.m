//
//  ApiManager.m
//  TSMTraining
//
//  Created by Mobikasa on 01/09/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import "ApiManager.h"
#import "TSMAPICleint.h"

@implementation ApiManager

-(void)CallHelloRequest :(NSDictionary *)param andBlock:(APIRequestCompletion)block{
    
    if([APP_DELEGATE connectedToInternet]){
        [[TSMAPICleint sharedClient] POST:HelloServlet parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            if(responseObject){
                block(task, responseObject, nil);
            }else{
                block(task, nil, nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            block(task, nil, error);
            
        }];
    }
    
}


-(void)CallSessionRequest :(NSDictionary *)param andBlock:(APIRequestCompletion)block{
    
    if([APP_DELEGATE connectedToInternet]){
        [[TSMAPICleint sharedClient] POST:Session parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(responseObject){
                block(task, responseObject, nil);
            }else{
                block(task, nil, nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            block(task, nil, error);
            
        }];
    }
    
}


-(void)CallAttendanceRequest :(NSDictionary *)param andBlock:(APIRequestCompletion)block{
    
    if([APP_DELEGATE connectedToInternet]){
        [[TSMAPICleint sharedClient] POST:Attendance parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(responseObject){
                block(task, responseObject, nil);
            }else{
                block(task, nil, nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            block(task, nil, error);
            
        }];
    }
    
}


-(void)CallScoreRequest :(NSDictionary *)param andBlock:(APIRequestCompletion)block{
    
    if([APP_DELEGATE connectedToInternet]){
        [[TSMAPICleint sharedClient] POST:Score parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(responseObject){
                block(task, responseObject, nil);
            }else{
                block(task, nil, nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            block(task, nil, error);
            
        }];
    }
    
}

@end
