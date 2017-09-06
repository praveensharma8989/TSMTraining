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

+(void)saveSessiondata:(SessionDataArray *)sessionDataArray{
    
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

+(void)saveAttendancedata:(AttendanceDataArray *)AttendanceDataArray{
    
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

+(void)saveScoredata:(ScoreDataArray *)scoreDataArray{
    
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





@end
