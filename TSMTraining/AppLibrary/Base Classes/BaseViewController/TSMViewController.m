//
//  TSMViewController.m
//  TSMTraining
//
//  Created by Praveen Sharma on 31/08/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import "TSMViewController.h"

@interface TSMViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation TSMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTitle:(NSString *)title isBold:(BOOL)isBold{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [label setFont:[UIFont TSM_AppFontWithType:(isBold) ? Bold :Regular WithSize:24]];
    [label setText:title];
    [label setShadowColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    if (self.tabBarController) {
        [self.tabBarController.navigationItem setTitleView:label];
    }else{
        [self.navigationItem setTitleView:label];
    }
    
    [self.navigationController.navigationBar setTranslucent:NO];
}


-(void)addGrayBackButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"back") style:UIBarButtonItemStylePlain target:self action:@selector(action_MoveToBack:)];
    [item setTintColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem = item;

}

-(void)addGrayLogOutButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"logout") style:UIBarButtonItemStylePlain target:self action:@selector(action_Logout)];
    [item setTintColor:[UIColor whiteColor]];
    if (self.tabBarController) {
        self.tabBarController.navigationItem.rightBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
    
}

-(IBAction)action_MoveToBack:(id)sender{
    ENDEDITING;
    POP;
}

-(IBAction)action_DismissController:(id)sender{
    DISMISSCONTROLLER;
}

-(void)action_Logout{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Do You Want to Log Out?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        REMOVE_USER_DEFAULTSFOR(CRMID);
        REMOVE_USER_DEFAULTSFOR(CRMPASSWORD);
        [MBDataBaseHandler clearAllDataBase];
        [self moveToSignInScreen];
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:yes completion:nil];
    
    
}

-(void)moveToSignInScreen{

    UIStoryboard * storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController * landingViewController=[storyboard instantiateViewControllerWithIdentifier:@"TSMSignIn"];
    
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
