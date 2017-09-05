//
//  MBDataHandler.m
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "MBDataHandler.h"


@interface MBDataHandler ()
{
}


@property (nonatomic,strong) Reachability *reachability;

@end

@implementation MBDataHandler
//
//+ (instancetype)sharedHandler{
//    return SHARED_INSTANCE([self new]);
//}
//
//-(void)setup
//{
//    _reachability = [Reachability reachabilityForInternetConnection];
//    [_reachability startNotifier];
//        
//    [_reachability setReachableBlock:^(Reachability *reach){
//        
//        if (reach.isReachable || reach.isReachableViaWiFi || reach.isReachableViaWWAN)
//        {
////            [[MBDataHandler sharedHandler] updateDataBaseFromServer];
//        }
//        NSLog(@"Network available");
//        
////        if(GET_USER_DEFAULTS(K_ACCESSTOKEN))
////        {
//            [[XMPPHandler sharedHandler] setupStream];
//            [[XMPPHandler sharedHandler] connect];
//
////            [[MBAppInitializer sharedInstance] updateXMPP];
////        }
//        
////        [[NSNotificationCenter defaultCenter] postNotificationName:K_NOTIFICATION_CHECKXMPPCONNECTION object:nil userInfo:@{@"isconnected" : @1}];
//
//       // [APP_DELEGATE remove_NoInternetView];
//        
//    }];
//    
//    [_reachability setUnreachableBlock:^(Reachability *reach){
//        NSLog(@"Network unavailable");
//        [[XMPPHandler sharedHandler] disconnect];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:K_NOTIFICATION_CHECKXMPPCONNECTION object:nil userInfo:@{@"isconnected" : @0}];
//        
//       // [APP_DELEGATE show_NoInternetView];
//    }];
//    
////      [[MBDataHandler sharedHandler] updateDataBaseFromServer];
//     [[MBDataHandler sharedHandler] setCurrentUser:[MBDataBaseHandler getCurrentLoggedInUser]];
//}
//
////-(void)updateDataBaseFromServer{
////    
////    if (_reachability.isReachable) {
////        
////        ASCall_SyncDataBase(^(id response, NSString *error) {
////            {
////                if (!error) {
////                    [USER_DEFAULT setValue:[NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]] forKey:K_SYNC_TIME];
////                    [USER_DEFAULT synchronize];
////                    [self updateLocalDatabase:response];
////                }
////                
////            }
////        });
////    }else{
////        NSString *path = [[NSBundle mainBundle] pathForResource:@"masterData" ofType:@"json"];
////        NSData *data = [NSData dataWithContentsOfFile:path];
////        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
////        [self updateLocalDatabase:jsonData[@"data"]];
////    }
////}
//
////-(void)updateLocalDatabase:(NSDictionary*)response
////{
////    
////    UserCategoryModel *categorydata = [[UserCategoryModel alloc] initWithDictionary:response error:nil];
////    
////    if (categorydata)
////    {
////        SAVE_USER_BOOLDEFAULTS(NO, K_MASTER_DATA_REQUIRED);
////       
////        [MBDataBaseHandler saveCategorydata:categorydata];
////    }
////    else
////    {
////        SAVE_USER_BOOLDEFAULTS(YES, K_MASTER_DATA_REQUIRED);
////        
////    }
////    
////}
////-(void)sendUpdatedDataToServer{
////
////    NSArray *objects = [MBDataBaseHandler getAllOfflineUpdatedRecords];
////
////    for (OfflineObject *each in objects) {
////
////        if (each.objType == [NSNumber numberWithInt:CategoryDetail])
////        {
////#warning TODO : Update eventDetail model to server.
////
////        }
////    }
////}
//
//
//
//-(BOOL)isReachableToInternet{
//    return [_reachability isReachable];
//}
//
//
//
////-(MBSchool*)schoolForId:(NSInteger)schoolId{
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.id == %@",[NSNumber numberWithInteger:schoolId]];
////
////    NSArray *filter = [[EDDataHandler sharedHandler].schoolList filteredArrayUsingPredicate:predicate];
////
////    if (filter.count>0) {
////        MBSchool *model = [filter ED_safeObjectAtIndex:0];
////        return model;
////    }
////
////    return nil;
////}
////
////-(MBSchool *)schoolForName:(NSString *)schoolName{
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name == %@",schoolName];
////
////    NSArray *filter = [[MBDataHandler sharedHandler].schoolList filteredArrayUsingPredicate:predicate];
////
////    if (filter.count>0) {
////        MBSchool *model = [filter ED_safeObjectAtIndex:0];
////        return model;
////    }
////
////    return nil;
////}
//
////-(NSArray*)schoolModels:(NSString*)schoolList{
////
////    NSArray *schools = [schoolList componentsSeparatedByString:@","];
////
////    NSMutableArray *newSchoolList = [NSMutableArray new];
////
////    for (NSString *each in schools) {
////        MBSchool *sc = [self schoolForId:each.integerValue];
////        if (sc) {
////            [newSchoolList addObject:sc];
////        }
////    }
////
////    return newSchoolList.copy;
////}



@end
