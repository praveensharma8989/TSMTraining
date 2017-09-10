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

    [self addGrayLogOutButton];
    [self ShowIndicator:NO];
    CRMDataArray *dataArray = [MBDataBaseHandler getCRMData];
    userData = [GlobalFunctionHandler getUserDetail:dataArray withUserId:GET_USER_DEFAULTS(CRMID)];
    
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
                
                [self MB_showSuccessMessageWithText:@"Your User Data Successfully Sync."];
                
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
        
        NSArray *parama = sessionDataArray.data;
        
        if([APP_DELEGATE connectedToInternet]){
            
            [self ShowIndicator:YES];
            
            CallSessionRequest(parama, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                if(JSON && !error){
                    
                    [MBDataBaseHandler deleteAllRecordsForType:SESSIONDATAARRAY];
                    [self MB_showSuccessMessageWithText:@"Your Seesion Data Successfully Sync."];
                    
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
        [self MB_showErrorMessageWithText:@"No session data for sync."];
    }
    
    
}

-(void)syncAttenData{
    
    AttendanceDataArray *attendanceDataArray = [MBDataBaseHandler getAttendanceDataArray];
    
    if(attendanceDataArray){
        NSArray *parama = attendanceDataArray.data;
        
        if([APP_DELEGATE connectedToInternet]){
            
            [self ShowIndicator:YES];
            
            CallAttendanceRequest(parama, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                if(JSON && !error){
                    
                    [MBDataBaseHandler deleteAllRecordsForType:ATTENDANCEDATAARRAY];
                    [self MB_showSuccessMessageWithText:@"Your Attendance Data Successfully Sync."];
                    
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
        
        [self MB_showErrorMessageWithText:@"No attendance data for sync."];
        
    }
    
    
}

-(void)syncScoreData{
    
    ScoreDataArray *scoreDataArray = [MBDataBaseHandler getScoreDataArray];
    
    if(scoreDataArray){
        
        NSArray *parama = scoreDataArray.data;
        
        if([APP_DELEGATE connectedToInternet]){
            
            [self ShowIndicator:YES];
            
            CallScoreRequest(parama, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                if(JSON && !error){
                    
                    [MBDataBaseHandler deleteAllRecordsForType:SCOREDATAARRAY];
                    [self MB_showSuccessMessageWithText:@"Your Score Data Successfully Sync."];
                    
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
        
        [self MB_showErrorMessageWithText:@"No score data for sync."];
        
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

@end
