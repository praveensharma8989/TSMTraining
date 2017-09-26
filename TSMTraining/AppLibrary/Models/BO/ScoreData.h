//
//  ScoreData.h
//  TSMTraining
//
//  Created by Praveen Sharma on 07/09/17.
//
//

#import <JSONModel/JSONModel.h>

@protocol ScoreData <NSObject>
@end

@interface ScoreData : JSONModel

@property (nonatomic,strong) NSString *crm_id;
@property (nonatomic,strong) NSString *crm_name;
@property (nonatomic,strong) NSString *trainer_crm_id;
@property (nonatomic,strong) NSString *trainer_name;
@property (nonatomic,strong) NSString *date_of_test;
@property (nonatomic,strong) NSString *training_LOB;
@property (nonatomic, strong) NSString *training_type;
@property (nonatomic,strong) NSString *pre_test_score;
@property (nonatomic,strong) NSString *post_test_score;
@property (nonatomic,strong) NSString *last_scroe_update;
@property (nonatomic,strong) NSString *score_status;
@property (nonatomic,strong) NSString *training_product_line;
@property (nonatomic,strong) NSString *score_session_name;

@end

@interface ScoreDataArray : JSONModel

@property (nonatomic, strong) NSMutableArray<ScoreData> *data;

@end
