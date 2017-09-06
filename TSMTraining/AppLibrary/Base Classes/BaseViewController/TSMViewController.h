//
//  TSMViewController.h
//  TSMTraining
//
//  Created by Praveen Sharma on 31/08/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import "ViewController.h"

@interface TSMViewController : ViewController

-(void)setTitle:(NSString *)title isBold:(BOOL)isBold;
-(void)setNavigation;
-(void)addGrayBackButton;
-(void)addGrayLogOutButton;
-(IBAction)action_MoveToBack:(id)sende;
-(IBAction)action_DismissController:(id)sender;
-(void)action_Logout;
-(void)moveToSignInScreen;
@end
