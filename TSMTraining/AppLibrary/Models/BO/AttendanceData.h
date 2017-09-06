//
//  AttendanceData.h
//  TSMTraining
//
//  Created by Praveen Sharma on 07/09/17.
//
//

#import <JSONModel/JSONModel.h>

@protocol AttendanceData <NSObject>

@end

@interface AttendanceData : JSONModel

@property (nonatomic,strong) NSString *trainer_id;
@property (nonatomic,strong) NSString *trainer_name;
@property (nonatomic,strong) NSString *session_name;
@property (nonatomic,strong) NSString *dealer_code;
@property (nonatomic,strong) NSString *dealer_name;
@property (nonatomic,strong) NSString *attendance_date;
@property (nonatomic,strong) NSString *present_crm_ids;
@property (nonatomic,strong) NSString *last_att_update;
@property (nonatomic,strong) NSString *att_status;

@end

@interface AttendanceDataArray : JSONModel

@property (nonatomic, strong) NSMutableArray<AttendanceData> *data;

@end
