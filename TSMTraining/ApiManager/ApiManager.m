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

void CallRegDataRequest(id param, APIRequestCompletion block){
    
    if([APP_DELEGATE connectedToInternet]){
        [[TSMAPICleint sharedClient] POST:RegData parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
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

void CallConfirmIDRequest(id param, APIRequestCompletion block){
    
    if([APP_DELEGATE connectedToInternet]){
        [[TSMAPICleint sharedClient] POST:ConfirmID parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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

void CallResetPasswordRequest(id param, APIRequestCompletion block){
    
    if([APP_DELEGATE connectedToInternet]){
        [[TSMAPICleint sharedClient] POST:ResetPassword parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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


void CallSessionRequest(id param, APIRequestCompletion block){
    
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


void CallAttendanceRequest(id param, APIRequestCompletion block){
    
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


void CallScoreRequest(id param, APIRequestCompletion block){
    
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
