//
//  MBDataBaseHandler.h
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfflineObject.h"

typedef enum
{
    CRMUserData = 0,
    SESSIONDATAARRAY,
    ATTENDANCEDATAARRAY,
    SCOREDATAARRAY
} OFFLINEMODE;


@interface MBDataBaseHandler : NSObject


+ (void)clearAllDataBase;
+ (void)deleteAllRecordsForType:(OFFLINEMODE)type;

+ (void)saveCRMdata:(CRMDataArray*)crmDataArray;
+ (void)saveSessiondata:(SessionDataArray*)sessionDataArray;
+ (void)saveAttendancedata:(AttendanceDataArray*)AttendanceDataArray;
+ (void)saveScoredata:(ScoreDataArray*)scoreDataArray;


+ (CRMDataArray*)getCRMData;
+ (SessionDataArray*)getSessionDataArray;
+ (AttendanceDataArray*)getAttendanceDataArray;
+ (ScoreDataArray*)getScoreDataArray;

@end
