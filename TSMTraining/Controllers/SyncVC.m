//
//  SyncVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 06/09/17.
//
//

#import "SyncVC.h"

@interface SyncVC ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndigator;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UILabel *TSMName;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;

@end

@implementation SyncVC{

    CRMData *userData;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialScreen];
    
    
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"Synchronize" isBold:YES];
}

-(void)setupInitialScreen{
    
    [self setTitle:@"Synchronize" isBold:YES];

    [self addGrayBackButton];
    [self addGrayLogOutButton];
    [self ShowIndicator:NO];
    CRMDataArray *dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    _appVersion.text = [NSString stringWithFormat:@"APP VERSION %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    _TSMName.text = userData.crm_name;
    
    
}

-(void)ShowIndicator:(BOOL)view{
    
    if(view){
        [self.activityIndigator setHidden:NO];
        [self.activityView setHidden:NO];
        [self.activityIndigator startAnimating];
        [self.view setUserInteractionEnabled:NO];
    }else{
        [self.activityIndigator setHidden:YES];
        [self.activityView setHidden:YES];
        [self.activityIndigator stopAnimating];
        [self.view setUserInteractionEnabled:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registrationDataClick:(id)sender {
    
    [self showAlertView:@"Registration" withBtnType:RegistrationBtn];
    
}
- (IBAction)sessionDataClick:(id)sender {
    
    [self showAlertView:@"Session" withBtnType:SessionBtn];
    
}
- (IBAction)attendanceDataClick:(id)sender {
    
    [self showAlertView:@"Attendance" withBtnType:AttendanceBtn];
    
}
- (IBAction)scoreDataClick:(id)sender {
    
    [self showAlertView:@"Score" withBtnType:ScoreBtn];
    
}


-(void)showAlertView :(NSString *)message withBtnType:(BtnCLickType)type{

    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert" message:[NSString stringWithFormat:@"Do you want to synchronize the %@ data?", message] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if(type == RegistrationBtn){
            [self syncRegisData];
        }else if(type == SessionBtn){
            [self syncSessionData];
        }else if(type == AttendanceBtn){
            [self syncAttenData];
        }else{
            [self syncScoreData];
        }
        
    }];
    
    UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil]
    ;
    
    [alertView addAction:yesButton];
    [alertView addAction:noButton];
    
    [self presentViewController:alertView animated:YES completion:nil];

}


-(void)syncRegisData{
    
    if([APP_DELEGATE connectedToInternet]){
        
        [self ShowIndicator:YES];
        
        NSDictionary *loginDtl = @{
                                   @"crm_id": GET_USER_DEFAULTS(CRMID),
                                   @"crm_password": GET_USER_DEFAULTS(CRMPASSWORD)
                                   };
        NSArray *param = [NSArray arrayWithObject:loginDtl];
        
        CallRegDataRequest(param, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
            
            NSArray *jsoneData = JSON;
            
            if(JSON && jsoneData.count > 0 && !error){
                
                CRMDataArray *dataArray = [[CRMDataArray alloc] initWithDictionary:@{@"data":jsoneData} error:nil];
                
                [MBDataBaseHandler saveCRMdata:dataArray];
                
                [self MB_showSuccessMessageWithText:@"User Data Successfully synchronize."];
                
            }else{
                
                [self MB_showErrorMessageWithText:@"There are some problem with server."];
            
            }
            
            [self ShowIndicator:NO];
            
        });

        
    }else{
        
        [self MB_showErrorMessageWithText:@"Please check your internet connection or try again later."];
        [self ShowIndicator:NO];
    }
}

-(void)syncSessionData{
    
    SessionDataArray *sessionDataArray = [MBDataBaseHandler getSessionDataArray];
    
    if(sessionDataArray){
        
//        NSArray *parama1 = [self getDataArray:sessionDataArray.data withType:SESSIONDATAARRAY];
        NSArray *parama = [SessionData arrayOfDictionariesFromModels:sessionDataArray.data];
        
        if([APP_DELEGATE connectedToInternet]){
            
            [self ShowIndicator:YES];
            
            CallSessionRequest(parama, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                if(JSON && !error && [[JSON valueForKey:@"status"] isEqualToString:@"success"]){
                    
                    SessionDataArray *sessionDataArrrayAlways = [MBDataBaseHandler getSessionDataArrayAlways];
                    
                    NSMutableArray *array = [parama copy];
                    
                    if(sessionDataArrrayAlways){
                        [sessionDataArrrayAlways.data addObjectsFromArray:sessionDataArray.data];
                    }else{
                        
//                        sessionDataArrrayAlways = [SessionDataArray new];
                        sessionDataArrrayAlways = [[SessionDataArray alloc] initWithDictionary:@{@"data":array} error:nil];
                    }
                    
                    [MBDataBaseHandler saveSessiondataArrayAlways:sessionDataArrrayAlways];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBDataBaseHandler deleteAllRecordsForType:SESSIONDATAARRAY];
                    });
                    
                    
                    [self MB_showSuccessMessageWithText:@"Seesion Data Successfully synchronize."];
                    
                }else{
                    
                    [self MB_showErrorMessageWithText:@"There are some problem with server."];
                    
                }
                
                [self ShowIndicator:NO];
                
            });
            
        }else{
            
            [self MB_showErrorMessageWithText:@"Please check your internet connection or try again later."];
            
            [self ShowIndicator:NO];
        }
    }else{
        [self MB_showErrorMessageWithText:@"No session data for synchronize."];
    }
    
    
}

-(void)syncAttenData{
    
    AttendanceDataArray *attendanceDataArray = [MBDataBaseHandler getAttendanceDataArray];
    
    if(attendanceDataArray){
        
//        NSArray *parama = [self getDataArray:attendanceDataArray.data withType:ATTENDANCEDATAARRAY];
        NSArray *parama = [AttendanceData arrayOfDictionariesFromModels:attendanceDataArray.data];
        
        if([APP_DELEGATE connectedToInternet]){
            
            [self ShowIndicator:YES];
            
            CallAttendanceRequest(parama, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                if(JSON && !error && [[JSON valueForKey:@"status"] isEqualToString:@"success"]){
                    
                    NSMutableArray *array = [parama copy];
                    
                    AttendanceDataArray *attendanceDataArrayAlways = [MBDataBaseHandler getAttendanceDataArrayAlways];
                    if(attendanceDataArrayAlways){
                        [attendanceDataArrayAlways.data addObjectsFromArray:attendanceDataArray.data];
                    }else{
                        attendanceDataArrayAlways = [[AttendanceDataArray alloc] initWithDictionary:@{@"data":array} error:nil];
                    }
                    
                    [MBDataBaseHandler saveAttendancedataArrayAlways:attendanceDataArrayAlways];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBDataBaseHandler deleteAllRecordsForType:ATTENDANCEDATAARRAY];
                    });
                    
                    [self MB_showSuccessMessageWithText:@"Attendance Data Successfully synchronize."];
                    
                }else{
                    
                    [self MB_showErrorMessageWithText:@"There are some problem with server."];
                    
                }
                
                [self ShowIndicator:NO];
                
            });
            
        }else{
            
            [self MB_showErrorMessageWithText:@"Please check your internet connection or try again later."];
            [self ShowIndicator:NO];
        }
        
    }else{
        
        [self MB_showErrorMessageWithText:@"No attendance data for synchronize."];
        
    }
    
    
}

-(void)syncScoreData{
    
    ScoreDataArray *scoreDataArray = [MBDataBaseHandler getScoreDataArray];
    
    if(scoreDataArray){
        
//        NSArray *parama = [self getDataArray:scoreDataArray.data withType:SCOREDATAARRAY];
        NSArray *parama = [ScoreData arrayOfDictionariesFromModels:scoreDataArray.data];
        if([APP_DELEGATE connectedToInternet]){
            
            [self ShowIndicator:YES];
            
            CallScoreRequest(parama, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                if(JSON && !error && [[JSON valueForKey:@"status"] isEqualToString:@"success"]){
                    
                    NSMutableArray *array = [parama copy];
                    
                    ScoreDataArray *scoreDataArrayAlways = [MBDataBaseHandler getScoreDataArrayAlways];
                    
                    if(scoreDataArrayAlways){
                        [scoreDataArrayAlways.data addObjectsFromArray:scoreDataArray.data];
                    }else{
                        scoreDataArrayAlways = [[ScoreDataArray alloc] initWithDictionary:@{@"data":array} error:nil];
                    }
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBDataBaseHandler deleteAllRecordsForType:SCOREDATAARRAY];
                    });
                    
                    [self MB_showSuccessMessageWithText:@"Score Data Successfully synchronize."];
                    
                }else{
                    
                    [self MB_showErrorMessageWithText:@"There are some problem with server."];
                    
                }
                
                [self ShowIndicator:NO];
                
            });
            
        }else{
            
            [self MB_showErrorMessageWithText:@"Please check your internet connection or try again later."];
            [self ShowIndicator:NO];
        }
        
    }else{
        
        [self MB_showErrorMessageWithText:@"No score data for synchronize."];
        
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSArray *)getDataArray:(NSMutableArray *)data withType:(OFFLINEMODE)type{
    
    NSMutableArray *retunArray = [NSMutableArray new];
    
    if(type == SESSIONDATAARRAY){
        
        for (SessionData *session in data) {
            
            NSDictionary *dict = @{
                                   
                                   @"session_name":[NSString stringWithFormat:@"%@", session.session_name],
                                   @"trainer_crm_id":[NSString stringWithFormat:@"%@", session.trainer_crm_id],
                                   @"dealer_code":[NSString stringWithFormat:@"%@", session.dealer_code],
                                   @"dealer_name":[NSString stringWithFormat: @"%@", session.dealer_name],
                                   @"training_type":[NSString stringWithFormat:@"%@", session.training_type],
                                   @"product_line":[NSString stringWithFormat:@"%@", session.product_line],
                                   @"LOB_training":[NSString stringWithFormat:@"%@", session.LOB_training],
                                   @"trainees_crm_ids":[NSString stringWithFormat:@"%@", session.trainees_crm_ids],
                                   @"last_session_update":[NSString stringWithFormat:@"%@", session.last_session_update],
                                   @"session_status":[NSString stringWithFormat:@"%@", session.session_status],
                                   @"session_location":[NSString stringWithFormat:@"%@", session.session_location],
                                   @"session_image":[NSString stringWithFormat:@"%@", session.session_image]
                                   };
            
            [retunArray addObject:dict];
        }

    }else if(type == ATTENDANCEDATAARRAY){
        
        for (AttendanceData *attendance in data) {
            
//            NSString *present_crm_ids = [attendance.present_crm_ids componentsJoinedByString:@", "];
            
            NSDictionary *dict = @{
                                   @"trainer_id":[NSString stringWithFormat:@"%@",attendance.trainer_id],
                                   @"trainer_name":[NSString stringWithFormat:@"%@",attendance.trainer_name],
                                   @"session_name":[NSString stringWithFormat:@"%@",attendance.session_name],
                                   @"dealer_code":[NSString stringWithFormat:@"%@",attendance.dealer_code],
                                   @"dealer_name":[NSString stringWithFormat:@"%@",attendance.dealer_name],
                                   @"attendance_date":[NSString stringWithFormat:@"%@",attendance.attendance_date],
                                   @"present_crm_ids":[NSString stringWithFormat:@"%@",attendance.present_crm_ids],
                                   @"last_att_update":[NSString stringWithFormat:@"%@",attendance.last_att_update],
                                   @"att_status":[NSString stringWithFormat:@"%@",attendance.att_status]
                                   
                                   };
            [retunArray addObject:dict];
        }
        
    }else if(type == SCOREDATAARRAY){
        
        for (ScoreData *scoreData in data) {
            
            NSDictionary *dict = @{
                                   
                                   @"crm_id": [NSString stringWithFormat:@"%@", scoreData.crm_id],
                                   @"crm_name":[NSString stringWithFormat:@"%@", scoreData.crm_name],
                                   @"trainer_crm_id":[NSString stringWithFormat:@"%@", scoreData.trainer_crm_id],
                                   @"trainer_name":[NSString stringWithFormat:@"%@", scoreData.trainer_name],
                                   @"date_of_test":[NSString stringWithFormat:@"%@", scoreData.date_of_test],
                                   @"training_LOB":[NSString stringWithFormat:@"%@", scoreData.training_LOB],
                                   @"pre_test_score":[NSString stringWithFormat:@"%@", scoreData.pre_test_score],
                                   @"post_test_score":[NSString stringWithFormat:@"%@", scoreData.post_test_score],
                                   @"last_scroe_update":[NSString stringWithFormat:@"%@", scoreData.last_scroe_update],
                                   @"score_status":[NSString stringWithFormat:@"%@", scoreData.score_status],
                                   @"score_session_name":[NSString stringWithFormat:@"%@", scoreData.score_session_name],
                                   };
            [retunArray addObject:dict];
            
        }
    }
    
        return retunArray;
}

@end
