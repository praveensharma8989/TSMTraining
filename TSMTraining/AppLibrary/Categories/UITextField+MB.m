//
//  UITextField+MB.m
//  WindFall_World
//
//  Created by mobikasa on 10/6/16.
//  Copyright © 2016 Anil khanna. All rights reserved.
//

#import "UITextField+MB.h"

@implementation UITextField (MB)


- (void)setLayerCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

-(void)setLayerBorderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
}

-(void)setLayerBorderWidth:(CGFloat)width
{
    self.layer.borderWidth = width;
}
-(void)defaultTextfieldstylewithplaceholder:(NSString *)strPlaceHolder
{
    [self setPlaceholder:strPlaceHolder];
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
    [self setTintColor:[UIColor blueColor]];
    [self.layer setBorderWidth:1.0f];
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderColor:[UIColor blueColor].CGColor];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setKeyboardAppearance:UIKeyboardAppearanceDark];
    UIView *userView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
    self.leftView = userView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
