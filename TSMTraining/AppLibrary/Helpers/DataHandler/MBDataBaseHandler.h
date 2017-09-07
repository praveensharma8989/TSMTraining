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
    SCOREDATAARRAY,
    SESSIONDATA,
    ATTENDANCEDATA,
    SCOREDATA
} OFFLINEMODE;


@interface MBDataBaseHandler : NSObject


+ (void)clearAllDataBase;
+ (void)deleteAllRecordsForType:(OFFLINEMODE)type;

+ (void)saveCRMdata:(CRMDataArray*)crmDataArray;
+ (void)saveSessiondataArray:(SessionDataArray*)sessionDataArray;
+ (void)saveAttendancedataArray:(AttendanceDataArray*)AttendanceDataArray;
+ (void)saveScoredataArray:(ScoreDataArray*)scoreDataArray;
+ (void)saveSessiondata:(SessionData*)sessionData;
+ (void)saveAttendancedata:(AttendanceData*)AttendanceData;
+ (void)saveScoredata:(ScoreData*)scoreData;



+ (CRMDataArray*)getCRMData;
+ (SessionDataArray*)getSessionDataArray;
+ (AttendanceDataArray*)getAttendanceDataArray;
+ (ScoreDataArray*)getScoreDataArray;
+ (SessionData*)getSessionData;
+ (AttendanceData*)getAttendanceData;
+ (ScoreData*)getScoreData;


@end
