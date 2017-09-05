//
//  MBDataBaseHandler.h
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfflineObject.h"
//#import "MBModels.h"

typedef enum
{
    CRMUserData = 0,
} OFFLINEMODE;


@interface MBDataBaseHandler : NSObject


+ (void)clearAllDataBase;
+ (void) deleteAllRecordsForType:(OFFLINEMODE)type;
+ (void) saveCRMdata :(CRMDataArray*)crmDataArray;
+ (CRMDataArray *)getCRMData;

@end
