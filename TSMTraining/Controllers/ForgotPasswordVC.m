//
//  ForgotPasswordVC.m
//  TSMTraining
//
//  Created by Praveen Sharma on 09/09/17.
//
//

#import "ForgotPasswordVC.h"

@interface ForgotPasswordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *CRMIDView;
@property (weak, nonatomic) IBOutlet UIView *PasswordView;
@property (weak, nonatomic) IBOutlet UITextField *CRMIDTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UITextField *coPasswordTxt;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTxt;

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInitialScreen];
    // Do any additional setup after loading the view.
}

#pragma mark - set up initial screen
-(void)setupInitialScreen{

    [self addGrayBackButton];
    [self setTitle:@"Reset Password" isBold:YES];
    [self.PasswordView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextBtnClick:(id)sender {
    
    if([self ValidateTextFields]){
    
        NSString *crmID = [_CRMIDTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSDictionary *param = @{
                                   @"CRMID": crmID
                                   };
        
        if([APP_DELEGATE connectedToInternet]){
            
            CallConfirmIDRequest(param, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                NSArray *jsoneData = JSON;
                
                if(JSON && jsoneData.count > 0 && !error && [[jsoneData valueForKey:@"status"] isEqualToString:@"success"]){
                    
                    SAVE_USER_DEFAULTS(crmID, TEMCRMID);
                    
                    [_PasswordView setHidden:NO];
                    [_CRMIDView setHidden:YES];
            
                }else{
                    
                    [self MB_showErrorMessageWithText:@"Please Enter Valid Id and CRM ID."];
                    
                }
                
            });
            
        }else{
            
            [self MB_showErrorMessageWithText:@"Please check your internet connection or try again later."];
            
        }

        
    }
    
}
- (IBAction)submitBtnClick:(id)sender {
    
    if([self ValidateTextFieldsPassword]){
        
        NSString *password = _passwordTxt.text;
        NSString *oldPassword = _oldPasswordTxt.text;
        
        NSDictionary *param = @{
                                @"CRMID": GET_USER_DEFAULTS(TEMCRMID),
                                @"Password": password,
                                @"OldPassword":oldPassword
                                
                                };
        
        if([APP_DELEGATE connectedToInternet]){
            
            CallResetPasswordRequest(param, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                NSArray *jsoneData = JSON;
                
                if(JSON && jsoneData.count > 0 && !error && [[jsoneData valueForKey:@"status"] isEqualToString:@"success"]){
                    
                    REMOVE_USER_DEFAULTSFOR(TEMCRMID);
                    
                    [self MB_showSuccessMessageWithText:@"Your Password Succefully reset. Please login!"];
                    
                    [self action_MoveToBack:nil];
                    
                }else{
                    
                    [self MB_showErrorMessageWithText:@"Old password is incorrect."];
                    
                }
                
            });
            
        }else{
            
            [self MB_showErrorMessageWithText:@"Please check your internet connection or try again later."];
            
        }
        
        
    }
    
}
- (IBAction)backToLogin:(id)sender {
    [self action_MoveToBack:sender];
}

#pragma mark - Field validations

// Validate the textfields function

- (BOOL)ValidateTextFields
{
    if ([MBValidator isTextEmpty:_CRMIDTxt.text] != 0)
    {
        [self MB_showErrorMessageOnWindowWithText:@"Please enter CRM No."];
        return NO;
    }
    
    return YES;
}

- (BOOL)ValidateTextFieldsPassword
{
    if ([MBValidator isTextEmpty:_oldPasswordTxt.text] != 0){
        
        [self MB_showErrorMessageOnWindowWithText:@"Please enter Old Password"];
        return NO;
        
    }else if ([MBValidator isTextEmpty:_passwordTxt.text] != 0)
    {
        [self MB_showErrorMessageOnWindowWithText:@"Please enter New Password"];
        return NO;
        
    }else if(_passwordTxt.text.length < 6){
        
        [self MB_showErrorMessageOnWindowWithText:@"Password lenght should be minmum six letters."];
        return NO;
        
    }else if ([_oldPasswordTxt.text isEqualToString:_passwordTxt.text]){
        
        [self MB_showErrorMessageOnWindowWithText:@"New Password should not same as Old Password"];
        return NO;
        
    }else if([MBValidator isTextEmpty:_coPasswordTxt.text] != 0){
        
        [self MB_showErrorMessageOnWindowWithText:@"Please enter Confirm Password"];
        return NO;
        
    }else if(![_passwordTxt.text isEqualToString:_coPasswordTxt.text]){
        
        [self MB_showErrorMessageOnWindowWithText:@"Please enter Confirm Password same as new Password"];
        return NO;
        
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _CRMIDTxt){
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
