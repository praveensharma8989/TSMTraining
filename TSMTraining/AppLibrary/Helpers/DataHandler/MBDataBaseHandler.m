//
//  MBDataBaseHandler.m
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "MBDataBaseHandler.h"
#import <MagicalRecord/MagicalRecord.h>



@implementation MBDataBaseHandler

#pragma mark ---  Offline data handling GET Methods
/*-------------------------OFFLINE GETTER METHODS------------------------*/

//GET METHODS



+ (void)clearAllDataBase{
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        [OfflineObject MR_truncateAll];
    }];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

}

+ (void)deleteAllRecordsForType:(OFFLINEMODE)type{
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:type]];
        [OfflineObject MR_deleteAllMatchingPredicate:predicate inContext:localContext];
    }];
    
}


+(void)saveCRMdata:(CRMDataArray*)crmDataArray{
    
    [self deleteAllRecordsForType:CRMUserData];
    
    if(!crmDataArray){
        return;
    }
    
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
    
        OfflineObject *object = [OfflineObject MR_createEntityInContext:localContext];
        object.objData = crmDataArray.toJSONString;
        object.objType = [NSNumber numberWithInt:CRMUserData];
        object.objClass = NSStringFromClass([crmDataArray class]);
    }];
    
}

+(void)saveSessiondataArray:(SessionDataArray *)sessionDataArray{
    
    [self deleteAllRecordsForType:SESSIONDATAARRAY];
    
    if(!sessionDataArray){
        return;
    }
    
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        OfflineObject *object = [OfflineObject MR_createEntityInContext:localContext];
        object.objData = sessionDataArray.toJSONString;
        object.objType = [NSNumber numberWithInt:SESSIONDATAARRAY];
        object.objClass = NSStringFromClass([sessionDataArray class]);
    }];
    
}

+(void)saveAttendancedataArray:(AttendanceDataArray *)AttendanceDataArray{
    
    [self deleteAllRecordsForType:ATTENDANCEDATAARRAY];
    
    if(!AttendanceDataArray){
        return;
    }
    
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        OfflineObject *object = [OfflineObject MR_createEntityInContext:localContext];
        object.objData = AttendanceDataArray.toJSONString;
        object.objType = [NSNumber numberWithInt:ATTENDANCEDATAARRAY];
        object.objClass = NSStringFromClass([AttendanceDataArray class]);
    }];
    
}

+(void)saveScoredataArray:(ScoreDataArray *)scoreDataArray{
    
    [self deleteAllRecordsForType:SCOREDATAARRAY];
    
    if(!scoreDataArray){
        return;
    }
    
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        OfflineObject *object = [OfflineObject MR_createEntityInContext:localContext];
        object.objData = scoreDataArray.toJSONString;
        object.objType = [NSNumber numberWithInt:SCOREDATAARRAY];
        object.objClass = NSStringFromClass([scoreDataArray class]);
    }];
    
}

+(void)saveSessiondata:(SessionData *)sessionData{
    
    [self deleteAllRecordsForType:SESSIONDATA];
    
    if(!sessionData){
        return;
    }
    
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        OfflineObject *object = [OfflineObject MR_createEntityInContext:localContext];
        object.objData = sessionData.toJSONString;
        object.objType = [NSNumber numberWithInt:SESSIONDATA];
        object.objClass = NSStringFromClass([sessionData class]);
    }];
    
}

+(void)saveAttendancedata:(AttendanceData *)AttendanceData{
    
    [self deleteAllRecordsForType:ATTENDANCEDATA];
    
    if(!AttendanceData){
        return;
    }
    
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        OfflineObject *object = [OfflineObject MR_createEntityInContext:localContext];
        object.objData = AttendanceData.toJSONString;
        object.objType = [NSNumber numberWithInt:ATTENDANCEDATA];
        object.objClass = NSStringFromClass([AttendanceData class]);
    }];
    
}

+(void)saveScoredata:(ScoreData *)scoreData{
    
    [self deleteAllRecordsForType:SCOREDATA];
    
    if(!scoreData){
        return;
    }
    
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        OfflineObject *object = [OfflineObject MR_createEntityInContext:localContext];
        object.objData = scoreData.toJSONString;
        object.objType = [NSNumber numberWithInt:SCOREDATA];
        object.objClass = NSStringFromClass([scoreData class]);
    }];
    
}




+(CRMDataArray *)getCRMData{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)", [NSNumber numberWithInt:CRMUserData]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if(array.count > 0){
        OfflineObject *object = array[0];
        CRMDataArray *crmDataArray = [[CRMDataArray alloc] initWithString:object.objData error:nil];
        return crmDataArray;
    }
    
    return nil;
    
}

+(SessionDataArray *)getSessionDataArray{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)", [NSNumber numberWithInt:SESSIONDATAARRAY]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if(array.count > 0){
        OfflineObject *object = array[0];
        SessionDataArray *sessionDataArray = [[SessionDataArray alloc] initWithString:object.objData error:nil];
        return sessionDataArray;
    }
    
    return nil;
    
}

+(AttendanceDataArray *)getAttendanceDataArray{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)", [NSNumber numberWithInt:ATTENDANCEDATAARRAY]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if(array.count > 0){
        OfflineObject *object = array[0];
        AttendanceDataArray *attendanceDataArray = [[AttendanceDataArray alloc] initWithString:object.objData error:nil];
        return attendanceDataArray;
    }
    
    return nil;
    
}

+(ScoreDataArray *)getScoreDataArray{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)", [NSNumber numberWithInt:SCOREDATAARRAY]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if(array.count > 0){
        OfflineObject *object = array[0];
        ScoreDataArray *scoreDataArray = [[ScoreDataArray alloc] initWithString:object.objData error:nil];
        return scoreDataArray;
    }
    
    return nil;
    
}

+(SessionData *)getSessionData{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)", [NSNumber numberWithInt:SESSIONDATA]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if(array.count > 0){
        OfflineObject *object = array[0];
        SessionData *sessionData = [[SessionData alloc] initWithString:object.objData error:nil];
        return sessionData;
    }
    
    return nil;
    
}

+(AttendanceData *)getAttendanceData{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)", [NSNumber numberWithInt:ATTENDANCEDATA]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if(array.count > 0){
        OfflineObject *object = array[0];
        AttendanceData *attendanceData = [[AttendanceData alloc] initWithString:object.objData error:nil];
        return attendanceData;
    }
    
    return nil;
    
}

+(ScoreData *)getScoreData{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)", [NSNumber numberWithInt:SCOREDATA]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if(array.count > 0){
        OfflineObject *object = array[0];
        ScoreData *scoreData = [[ScoreData alloc] initWithString:object.objData error:nil];
        return scoreData;
    }
    
    return nil;
    
}




@end
