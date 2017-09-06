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

#pragma mark - set up initial screen
-(void)setupInitialScreen{
    
    NSString *crmID = GET_USER_DEFAULTS(CRMID);
    NSString *crmPassword = GET_USER_DEFAULTS(CRMPASSWORD);
    
    CRMDataArray *dataArray = [MBDataBaseHandler getCRMData];
    
    if(crmID && crmPassword && dataArray && dataArray.data.count > 0){
        
        [self moveToLandingViewController];
        
    }else{
    
        [self setTitle:@"Login" isBold:YES];
        
    }
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
    
            CallHelloRequest(param, ^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                
                NSArray *jsoneData = JSON;
                
                if(JSON && jsoneData.count > 0 && !error){
                    
                    SAVE_USER_DEFAULTS(crmID, CRMID);
                    SAVE_USER_DEFAULTS(crmPassword, CRMPASSWORD);
                    
                    CRMDataArray *dataArray = [[CRMDataArray alloc] initWithDictionary:@{@"data":jsoneData} error:nil];
                    
                    [MBDataBaseHandler saveCRMdata:dataArray];
                    
                    [GlobalFunctionHandler getUserDetail:dataArray withUserId:crmID];
                    
                    [_loginBtn stopAnimation:^{
                       
                        [self moveToLandingViewController];
                        
                    }];
                    
                }else{
                    
                    [self MB_showErrorMessageWithText:@"Please Enter Valid Id and Password."];
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
    }
    
    return YES;
}

- (void)moveToLandingViewController
{
    UIStoryboard * storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController * landingViewController=[storyboard instantiateViewControllerWithIdentifier:@"TSMLandingTabBar"];
    
    landingViewController.transitioningDelegate = self;
    
    UINavigationController * navigationController=[[UINavigationController alloc]initWithRootViewController:landingViewController];
    
    navigationController.transitioningDelegate = self;
    
    [navigationController setNavigationBarHidden:NO];
    
    [AppDelegate sharedDelegate].window.rootViewController = navigationController;
    
    [[AppDelegate sharedDelegate].window makeKeyAndVisible];
    
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
