


//  EDAppInitializer.m
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "MBAppInitializer.h"
#import <IQKeyboardManager.h>
#import "TSMSignIn.h"
#import "TSMLandingTabBar.h"

@implementation MBAppInitializer

+ (instancetype)sharedInstance{
    return SHARED_INSTANCE([self new]);
}

+ (void) setup
{
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor defaultBlueColor]];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"TSMTraining"];

    [self keyboardManagerEnabled];
    
    if(GET_USER_DEFAULTS(CRMID))
    {
        [self moveToLandingViewController];
    }else
    {
        [self moveToInitialViewController];
    }
    
    //File Browers path
    
}


+(void)updateRootViewWithController:(UIViewController *)controller animated:(BOOL)animated showAlert:(NSString *)error{
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    
    if (animated) {
        [UIView
         transitionWithView:window
         duration:0.3
         options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent
         animations:^(void) {
             //         BOOL oldState = [UIView areAnimationsEnabled];
             //         [UIView setAnimationsEnabled:NO];
             window.rootViewController = controller;
             //[UIView setAnimationsEnabled:oldState];
         }
         completion:^(BOOL finished)
         {
             //             UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:@"Alert" message:error cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
             //             [alert show];
         }];
    }
    else{
        window.rootViewController=controller;
    }
}

+(void)moveToInitialViewController
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController * navigationController;
    
    TSMSignIn *containerVC = [storyboard instantiateViewControllerWithIdentifier:@"TSMSignIn"];
    navigationController = [[UINavigationController alloc]initWithRootViewController:containerVC];
    [navigationController setNavigationBarHidden:NO];
    
    [AppDelegate sharedDelegate].window.rootViewController = navigationController;
    [[AppDelegate sharedDelegate].window makeKeyAndVisible];
}

+(void)moveToLandingViewController
{
    
    UIStoryboard * storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    TSMLandingTabBar *landingViewController = [storyboard instantiateViewControllerWithIdentifier:@"TSMLandingTabBar"];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:landingViewController];
    
    [navigationController setNavigationBarHidden:NO];
    
    [AppDelegate sharedDelegate].window.rootViewController = navigationController;
    
    [[AppDelegate sharedDelegate].window makeKeyAndVisible];
    
    // Register for Notification
}

+ (void)keyboardManagerEnabled{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    if (!manager.enable) {
        manager.enable = YES;
        manager.enableAutoToolbar = YES;
        manager.shouldShowToolbarPlaceholder = NO;
    }
}

+ (void)keyboardManagerDisabled{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    if (manager.enable) {
        manager.enable = NO;
        manager.enableAutoToolbar = NO;
    }
}
@end
