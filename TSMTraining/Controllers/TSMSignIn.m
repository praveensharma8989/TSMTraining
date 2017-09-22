//
//  TSMSignIn.m
//  TSMTraining
//
//  Created by Praveen Sharma on 31/08/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import "TSMSignIn.h"

@interface TSMSignIn ()<UITextFieldDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITextField *CRMId;
@property (weak, nonatomic) IBOutlet UITextField *CRMPassword;
@property (weak, nonatomic) IBOutlet MagicButton *loginBtn;

@end

@implementation TSMSignIn

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialScreen];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MBAppInitializer keyboardManagerEnabled];
    
}



#pragma mark - set up initial screen
-(void)setupInitialScreen{

    [self setTitle:@"Login" isBold:YES];
}


- (IBAction)loginClick:(id)sender {
    
    [_CRMPassword resignFirstResponder];
    TapTap;
    
    if([self ValidateTextFields]){
        
        [_loginBtn startAnimation];
        
        NSString *crmID = [_CRMId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *crmPassword = _CRMPassword.text;
        
        NSDictionary *loginDtl = @{
                                   @"crm_id": crmID,
                                   @"crm_password": crmPassword
                                   };
        NSArray *param = [NSArray arrayWithObject:loginDtl];
        
        if([APP_DELEGATE connectedToInternet]){
    
            CallRegDataRequest(param, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                NSArray *jsoneData = JSON;
                
                if(JSON && jsoneData.count > 0 && !error){
                    
                    SAVE_USER_DEFAULTS(crmID, CRMID);
                    SAVE_USER_DEFAULTS(crmPassword, CRMPASSWORD);
                    
                    CRMDataArray *dataArray = [[CRMDataArray alloc] initWithDictionary:@{@"data":jsoneData} error:nil];
                    
                    [MBDataBaseHandler saveCRMdata:dataArray];
                    
                    [GlobalFunctionHandler getUserDetail:dataArray withUserId:crmID];
                    
                    [_loginBtn stopAnimation:^{
                        
                        [MBAppInitializer moveToLandingViewController];
                        
                    }];
                    
                }else{
                    
                    [self MB_showErrorMessageWithText:@"Please check your CRM Id and Password."];
                    [_loginBtn ErrorRevertAnimation];
                    
                }
                
            });
            
        }else{
            
            [self MB_showErrorMessageWithText:@"Please check your internet connection or try again later."];
            [_loginBtn ErrorRevertAnimation];
            
        }
        
        
        
    }
    
    
}


#pragma mark - Field validations

// Validate the textfields function

- (BOOL)ValidateTextFields
{
    if ([MBValidator isTextEmpty:_CRMId.text] != 0)
    {
        [self MB_showErrorMessageOnWindowWithText:@"Please enter CRM No."];
        return NO;
    }
    else  if ([MBValidator isTextEmpty:_CRMPassword.text] != 0)
    {
        [self MB_showErrorMessageOnWindowWithText:@"Please enter password."];
        return NO;
    }else if(_CRMPassword.text.length < 6 ){
        [self MB_showErrorMessageOnWindowWithText:@"Password lenght should be minmum six letters."];
        return NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _CRMId){
        [_CRMPassword becomeFirstResponder];
        
    }else{
        [textField resignFirstResponder];
    }
    
    return true;
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
