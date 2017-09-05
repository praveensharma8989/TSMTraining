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
    
        OfflineObject *object = [OfflineObject MR_createEntity];
        object.objData = crmDataArray.toJSONString;
        object.objType = [NSNumber numberWithInt:CRMUserData];
        object.objClass = NSStringFromClass([crmDataArray class]);
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


@end
