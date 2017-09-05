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

+(UserModel*)getCurrentLoggedInUser{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:LoggedInUser]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        UserModel *user = [[UserModel alloc] initWithString:object.objData error:nil];
        return user;
    }
    
    return nil;
}


+ (void)saveCurrentLoggedInUser:(UserModel *)user
{
     [[MBDataHandler sharedHandler] setCurrentUser:user];
    
    [self deleteAllRecordsForType:LoggedInUser];
    
    if (!user) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
        newUser.objData = user.toJSONString;
        newUser.objId =   user.id;
        newUser.objType = [NSNumber numberWithInt:LoggedInUser];
        newUser.objClass = NSStringFromClass([user class]);
    }];    
}

+ (void) deleteAllRecordsForType:(OFFLINEMODE)type{
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:type]];
        [OfflineObject MR_deleteAllMatchingPredicate:predicate inContext:localContext];
    }];
    
}

+ (void)clearAllDataBase{
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
//        [MessageObject MR_truncateAll];
        [OfflineObject MR_truncateAll];
    }];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    RESET_DEFAULTS;
}

@end
