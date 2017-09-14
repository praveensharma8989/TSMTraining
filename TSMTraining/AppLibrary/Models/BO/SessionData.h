//
//  SessionData.h
//  TSMTraining
//
//  Created by Praveen Sharma on 07/09/17.
//
//

#import <JSONModel/JSONModel.h>

@protocol SessionData <NSObject>
@end


@interface SessionData : JSONModel

@property (nonatomic,strong) NSString *session_name;
@property (nonatomic,strong) NSString *trainer_crm_id;
@property (nonatomic,strong) NSString *dealer_code;
@property (nonatomic,strong) NSString *dealer_name;
@property (nonatomic,strong) NSString *training_type;
@property (nonatomic,strong) NSString *product_line;
@property (nonatomic,strong) NSString *LOB_training;
@property (nonatomic,strong) NSString *trainees_crm_ids;
@property (nonatomic,strong) NSString *last_session_update;
@property (nonatomic,assign) NSString *session_status;
@property (nonatomic,strong) NSString *session_location;
@property (nonatomic,strong) NSString *session_image;

@end

@interface SessionDataArray : JSONModel

@property (nonatomic, strong) NSMutableArray<SessionData> *data;

@end
