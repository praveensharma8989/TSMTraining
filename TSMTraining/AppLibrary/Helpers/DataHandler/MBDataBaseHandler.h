//
//  MBDataBaseHandler.h
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfflineObject.h"
#import "MBModels.h"

typedef enum
{
    LoggedInUser = 0,
   
//    JID,
} OFFLINEMODE;


@interface MBDataBaseHandler : NSObject

+ (void)clearAllDataBase;
+(UserModel*)getCurrentLoggedInUser;
//+(UserDetailModel*)getCurrentLoggedInUser;
+(void)saveCurrentLoggedInUser:(UserModel *)currentUser;

@end
