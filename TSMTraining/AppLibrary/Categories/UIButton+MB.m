//
//  UIButton+MB.m
//  ChatModule
//
//  Created by Jitesh Sharma on 01/06/17.
//  Copyright © 2017 Mobikasa. All rights reserved.
//

#import "UIButton+MB.h"

@implementation UIButton (MB)
-(void)setDefaultButtonStylewithTitle:(NSString *)btnName Withfont:(UIFont *)fontName
{
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderWidth:1.0f];
    [self.titleLabel setFont:fontName];
    [self.layer setBorderColor:[UIColor blueColor].CGColor];
    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self setTitle:btnName forState:UIControlStateNormal];
}

@end
