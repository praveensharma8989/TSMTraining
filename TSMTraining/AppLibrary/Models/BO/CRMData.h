//
//  CRMData.h
//  TSMTraining
//
//  Created by Mobikasa on 05/09/17.
//
//

#import <JSONModel/JSONModel.h>

@protocol CRMData <NSObject>
@end

@interface CRMData : JSONModel

@property (nonatomic,strong) NSString *crm_LOB;
@property (nonatomic,strong) NSString *crm_designation;
@property (nonatomic,strong) NSString *crm_id;
@property (nonatomic,strong) NSString *crm_name;
@property (nonatomic,strong) NSString *crm_password;
@property (nonatomic,strong) NSString *crm_product_line;
@property (nonatomic,strong) NSString *crm_status;
@property (nonatomic,strong) NSString *dealer_code;
@property (nonatomic,strong) NSString *dealer_location;
@property (nonatomic,strong) NSString *dealer_name;
@property (nonatomic,strong) NSString *last_reg_update;
@property (nonatomic,strong) NSString *region;
@property (nonatomic,strong) NSString *state_office;

@end

@interface CRMDataArray : JSONModel

@property (nonatomic, strong) NSMutableArray<CRMData> *data;

@end
