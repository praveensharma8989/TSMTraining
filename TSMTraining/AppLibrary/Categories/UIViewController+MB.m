//
//  UIViewController+MB.m
//  Florists
//
//  Created by Anil Khanna on 22/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "UIViewController+MB.h"
#import <CSNotificationView.h>
#import <objc/runtime.h>

static char const * const ObjectTagKey = "IsNotificationErrorVisible";

@implementation UIViewController (MB)

-(id)MB_getController:(NSString*)identifier{
    return [self.storyboard instantiateViewControllerWithIdentifier:identifier];
}


-(void)setIsNotificationErrorVisible:(NSNumber*)number{
    objc_setAssociatedObject(self, ObjectTagKey, number, OBJC_ASSOCIATION_ASSIGN);
}
- (NSNumber*)isNotificationErrorVisible {
    return objc_getAssociatedObject(self, ObjectTagKey);
}

// Navigation Error logging

-(void)MB_showErrorMessageWithText:(NSString*)message{
    
    NSNumber *number = [self isNotificationErrorVisible];
    BOOL status = [number boolValue];
    
    if (!status) {
        [self setIsNotificationErrorVisible:[NSNumber numberWithBool:YES]];
        [CSNotificationView showInViewController:self style:CSNotificationViewStyleError message:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kCSNotificationViewDefaultShowDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsNotificationErrorVisible:[NSNumber numberWithBool:NO]];
        });
    }
}

-(void)MB_showSuccessMessageWithText:(NSString*)message{
    
    NSNumber *number = [self isNotificationErrorVisible];
    BOOL status = [number boolValue];
    
    if (!status) {
        [self setIsNotificationErrorVisible:[NSNumber numberWithBool:YES]];
        [CSNotificationView showInViewController:self style:CSNotificationViewStyleSuccess message:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kCSNotificationViewDefaultShowDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsNotificationErrorVisible:[NSNumber numberWithBool:NO]];
        });
    }
    
}

-(void)MB_showErrorMessageOnWindowWithText:(NSString*)message{
    
    NSNumber *number = [self isNotificationErrorVisible];
    BOOL status = [number boolValue];
    
    if (!status) {
        [self setIsNotificationErrorVisible:[NSNumber numberWithBool:YES]];
        [CSNotificationView showInViewController:[[AppDelegate sharedDelegate].window rootViewController] style:CSNotificationViewStyleError message:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kCSNotificationViewDefaultShowDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsNotificationErrorVisible:[NSNumber numberWithBool:NO]];
        });
    }
}

-(void)MB_showSuccessMessageOnWindowWithText:(NSString*)message{
    
    NSNumber *number = [self isNotificationErrorVisible];
    BOOL status = [number boolValue];
    
    if (!status) {
        [self setIsNotificationErrorVisible:[NSNumber numberWithBool:YES]];
        [CSNotificationView showInViewController:[[AppDelegate sharedDelegate].window rootViewController] style:CSNotificationViewStyleSuccess message:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kCSNotificationViewDefaultShowDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsNotificationErrorVisible:[NSNumber numberWithBool:NO]];
        });
    }
}

-(void)MB_showMessageWithAlertView:(NSString *)title Message:(NSString *)message
{
//    UIAlertView *alr = [UIAlertView bk_alertViewWithTitle:title message:message];
//    
//    [alr bk_setCancelButtonWithTitle:@"Ok" handler:^{
        //
//    }];
    
//    [alr bk_setCancelBlock:^{
//        //
//    }];
    
//    [alr show];
}

@end
