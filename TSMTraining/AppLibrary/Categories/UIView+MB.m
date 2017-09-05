//
//  UIView+MB.m
//  Florists
//
//  Created by Anil Khanna on 15/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//
static char initialtimeKeyButton;
static char timeLapKeyButton;
static char directionKeyButton;


#import <objc/runtime.h>
#import "UIView+MB.h"

@implementation UIView (MB)

@dynamic borderColor,borderWidth,cornerRadius,topBorderColor,bottomBorderColor;

-(void)setlayerToVerticalGradientcolorWithColor:(UIColor*)color
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = self.bounds;
    
    gradient.cornerRadius=self.layer.cornerRadius?self.layer.cornerRadius:0;
    
//    gradient.colors = [NSArray arrayWithObjects:(id)[color CGColor],(id)[ACOLOR_GRADIENT_LAST CGColor], nil];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.layer insertSublayer:gradient atIndex:0];
}


-(void)removeLayerToVerticalGradientWithBackGround:(UIColor*)color
{
    for (NSInteger i = 0; i < self.layer.sublayers.count; i++)
    {
        id layer = self.layer.sublayers[i];
        
        if ([layer isKindOfClass:[CAGradientLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    
    [self setBackgroundColor:color];
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}


//+(UIImage*)setlayerToGradientcolorWithColor: (UIColor*)Color WithHeight:(CGFloat)height
//{
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, SCREEN_SIZE.width, height );
//    gradientLayer.colors = [NSArray arrayWithObjects:(id)[Color  CGColor], (id)[ACOLOR_GRADIENT_LAST CGColor], nil];
//    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
//    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
//    
//    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
//    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return gradientImage;
//   // self.backgroundColor = [UIColor colorWithPatternImage:gradientImage];
//}
//
//+(UIImage*)setlayerToGradientcolorfromColor: (UIColor*)fColor toColor:(UIColor*)scolor WithHeight:(CGFloat)height
//{
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, SCREEN_SIZE.width, height );
//    gradientLayer.colors = [NSArray arrayWithObjects:(id)[fColor  CGColor], (id)[scolor CGColor], nil];
//    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
//    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
//    
//    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
//    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return gradientImage;
//    // self.backgroundColor = [UIColor colorWithPatternImage:gradientImage];
//}



-(void)setShadowLayerWithColor:(UIColor*)color
{
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor=color.CGColor;
    self.layer.shadowOffset = CGSizeMake(-2, 3);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 0.2;
}

-(void)setShadowLayerWithColors:(UIColor *)color withCornerRounded:(CGFloat)radius;
{
    //self.layer.masksToBounds = NO;
    
    self.layer.cornerRadius = radius;
 
    self.layer.shadowColor=color.CGColor;
    self.layer.shadowOffset = CGSizeMake(-2, 2);
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 0.5;
}
-(void)setShadowLayerWithColors:(UIColor *)color shadowOffset:(CGSize)size radius:(CGFloat)radius withCornerRounded:(CGFloat)cornerradius{
    
    
    self.layer.cornerRadius = cornerradius;
    self.layer.shadowColor=color.CGColor;
    self.layer.shadowOffset = CGSizeMake(size.width,size.height);
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 0.3;

}

-(void)setShadowLayerWithColors:(UIColor *)color shadowOffset:(CGSize)size radius:(CGFloat)radius withCornerRounded:(CGFloat)cornerradius withShadowOpacity:(CGFloat)shadowOpacity
{
    self.layer.cornerRadius = cornerradius;
    self.layer.shadowColor=color.CGColor;
    self.layer.shadowOffset = CGSizeMake(size.width,size.height);
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = shadowOpacity;
}


//+(UILabel*)getNoDataContentView
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
//    [label setFont:[UIFont ED_AppFontWithType:Regular WithSize:18]];
//    [label setText:@"No Records Found"];
//    [label setTextColor:[UIColor darkGrayColor]];
//    [label setTextAlignment:NSTextAlignmentCenter];
//    
//    return label;
//}
//
//+(UILabel*)getNoDataContentViewWithTableView:(UITableView *)tableView
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.height/2, 80)];
//    [label setFont:[UIFont ED_AppFontWithType:Regular WithSize:18]];
//    [label setText:@"No Records Found"];
//    [label setTextColor:[UIColor darkGrayColor]];
//    [label setTextAlignment:NSTextAlignmentCenter];
//    
//    return label;
//}
//
//+(UILabel*)getNoDataContentViewWithText:(NSString*)text
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
//    
//    [label setFont:[UIFont ED_AppFontWithType:Regular WithSize:18]];
//    
//    [label setText:text];
//    
//    [label setTextColor:[UIColor darkGrayColor]];
//    
//    [label setTextAlignment:NSTextAlignmentCenter];
//    
//    return label;
//}

-(void)makeBorderWithWidth:(float)width andColor:(UIColor *)color
{
    [self.layer setBorderWidth:width];
    
    [self.layer setBorderColor:color.CGColor];
}

-(void)addTopBottomBorderWithColor:(UIColor *)color andWidth:(float)width
{
    self.clipsToBounds = YES;
    
    CALayer *rightBorder = [CALayer layer];
    
    rightBorder.borderColor = color.CGColor;
    
    rightBorder.borderWidth = width;
    
    rightBorder.frame = CGRectMake(-1, 0, CGRectGetWidth(self.frame)+2, CGRectGetHeight(self.frame));
    
    [self.layer addSublayer:rightBorder];
}

-(void)addBottomBorderWithColor:(UIColor *)color andWidth:(float)width
{
    self.clipsToBounds = YES;
    
    CALayer *rightBorder = [CALayer layer];
    
    rightBorder.borderColor = color.CGColor;
    
    rightBorder.borderWidth = width;
    
    rightBorder.frame = CGRectMake(-1, -1, CGRectGetWidth(self.frame)+2, CGRectGetHeight(self.frame)+1);
    
    [self.layer addSublayer:rightBorder];
}

-(void)addTopBorderWithWidth:(float)width andColor:(UIColor *)color
{
    CALayer *border = [CALayer layer];
    
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, self.frame.size.width, width);
    
    [self.layer addSublayer:border];
}

-(void)addBottomBorderWithWidth:(float)width andColor:(UIColor *)color
{
    CALayer *border = [CALayer layer];
    
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, self.frame.size.height-width, self.frame.size.width, width);
    
    [self.layer addSublayer:border];
}

-(void)addLeftPadding:(float)width
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    
    UITextField *view=(UITextField *)self;
    
    view.leftView = paddingView;
    
    view.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)addRightPadding:(float)width
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    
    UITextField *view=(UITextField *)self;
    
    view.rightView = paddingView;
    
    view.rightViewMode = UITextFieldViewModeAlways;
    
}

#pragma mark - IBInspectable Items -

-(void)setBorderColor:(UIColor *)borderColor
{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    [self.layer setCornerRadius:cornerRadius];
}

-(void)setTopBorderColor:(UIColor *)topBorderColor
{
    [self addTopBorderWithWidth:1.0f andColor:topBorderColor];
}

-(void)setBottomBorderColor:(UIColor *)bottomBorderColor
{
    [self addBottomBorderWithWidth:1.0f andColor:bottomBorderColor];
}

-(void)addLeftSideImageToTextFieldWithImage:(UIImage *)image
{
    UITextField *textfield=(UITextField *)self;
    
    UIImageView *searchIconView = [[UIImageView alloc]initWithImage:image];
    
    [searchIconView setFrame:CGRectMake(0, 0, CGRectGetHeight(textfield.frame), CGRectGetHeight(textfield.frame))];
    
    [searchIconView setContentMode:UIViewContentModeCenter];
    
    [textfield  setLeftView:searchIconView];
    
    [textfield  setLeftViewMode:UITextFieldViewModeAlways];
}

-(void)addRightSideImageToTextFieldWithImage:(UIImage *)image
{
    UITextField *textfield=(UITextField *)self;
    
    UIImageView *searchIconView = [[UIImageView alloc]initWithImage:image];
    
    [searchIconView setFrame:CGRectMake(0, 0, CGRectGetHeight(textfield.frame), CGRectGetHeight(textfield.frame))];
    
    [searchIconView setContentMode:UIViewContentModeCenter];
    
    [textfield  setRightView:searchIconView];
    
    [textfield  setRightViewMode:UITextFieldViewModeAlways];
}



#pragma mark - VIEW ANIMATION METHODS
//bounce effect

-(void)bounceEffect
{
    CATransform3D twentyOercent = CATransform3DMakeScale(0.95f, 0.9f, 1.00f);
    
    [UIView animateWithDuration:0.15f animations:^
     {
         self.layer.transform=twentyOercent;
     }
                     completion:^(BOOL finished)
     {
         CATransform3D percent= CATransform3DMakeScale(1.02f, 1.02f, 1.00f);
         CATransform3D percent1 = CATransform3DMakeScale(1.00f, 1.00f, 1.00f);
         
         [UIView animateWithDuration:0.2f animations:^
          {
              self.layer.transform = percent;
          }
                          completion:^(BOOL finished)
          {
              [UIView animateWithDuration:0.15f animations:^
               {
                   self.layer.transform=percent1;
               }
                               completion:^(BOOL finished)
               {
               }];
          }];
     }];
}




//-(void)setAlphaAnimation:(CGFloat)value WithDuration:(CGFloat)duration withDelay:(CGFloat)delay WithCompletion:(ViewMoveCompletion) viewMoveCompletion
//{
//    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
//    
//    //anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    // anim.fromValue = @(0.0);
//    anim.toValue = @(value);
//    anim.duration =duration;
//    anim.beginTime =CACurrentMediaTime()+delay;
//    
//    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
//        if (viewMoveCompletion)
//        {
//            viewMoveCompletion(YES);
//        }
//    };
//    
//    [self pop_addAnimation:anim forKey:@"fade"];
//  
//}
//
//
//-(void)setColorChangeAnimation:(UIColor*)color WithDuration:(CGFloat)duration withDelay:(CGFloat)delay WithCompletion:(ViewMoveCompletion) viewMoveCompletion
//{
//    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
//    
//    //anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    // anim.fromValue = @(0.0);
//    anim.toValue =color;
//    anim.duration =duration;
//    anim.beginTime =CACurrentMediaTime()+delay;
//    
//    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
//        if (viewMoveCompletion)
//        {
//            viewMoveCompletion(YES);
//        }
//    };
//    
//    [self pop_addAnimation:anim forKey:@"colorchange"];
//    
//}
//
//
//-(void)setMoveConstraint:(NSLayoutConstraint *)constraint withMovePosition:(CGFloat)value withSpringBounce:(CGFloat)bounciness WithBeginTime:(CGFloat)delay WithCompletion:(ViewMoveCompletion) viewMoveCompletion
//{
//    POPSpringAnimation *lbl_animation =[POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
//    
//    lbl_animation.toValue =[NSNumber numberWithFloat:value];
//    if(bounciness>0)
//    {
//    lbl_animation.springBounciness=bounciness;
//    lbl_animation.springSpeed=2;
//    }
//    lbl_animation.beginTime=CACurrentMediaTime()+delay;
//    lbl_animation.removedOnCompletion=YES;
//    
//    lbl_animation.completionBlock = ^(POPAnimation *anim, BOOL finished){
//        if (viewMoveCompletion)
//        {
//            viewMoveCompletion(YES);
//        }
//    };
//    
//    
//    [constraint  pop_addAnimation:lbl_animation forKey:@"moveanimation"];
//    
//    
//    
//}

//-(void)setMoveConstraint:(NSLayoutConstraint *)constraint withMovePosition:(CGFloat)value withSpringBounce:(CGFloat)bounciness WithBeginTime:(CGFloat)delay WithCompletion:(ViewMoveCompletion) viewMoveCompletion
//{
//    
//
//    
//}
//

-(void)setAnimatefadeInOut{

    [UIView animateWithDuration:0.7 animations:^{
        [self setHidden:NO];
        self.alpha=1;
    }                     completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.alpha=0;
        }];
    }];
}


//methods to spin the view

- (void)spinButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction{
    
    CABasicAnimation* rotationAnimation;
    
    // Rotate about the z axis
    rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // Rotate 360 degress, in direction specified
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * direction];
    
    // Perform the rotation over this many seconds
    rotationAnimation.duration = inDuration;
    
    // Set the pacing of the animation
    rotationAnimation.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Add animation to the layer and make it so
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimationUIButton"];
    
}

- (void)spinInfinityButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction{
    
    CABasicAnimation* rotationAnimation;
    
    rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * direction];
    rotationAnimation.duration = inDuration;
    rotationAnimation.repeatCount=INFINITY;
    rotationAnimation.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    //set associations
    CFTimeInterval aniPause =  CACurrentMediaTime();
    NSString *initialTime = [NSString stringWithFormat:@"%f",aniPause];
    objc_setAssociatedObject (self,&initialtimeKeyButton,initialTime,OBJC_ASSOCIATION_RETAIN);
    
    NSString *timeLap = [NSString stringWithFormat:@"%f",inDuration];
    objc_setAssociatedObject (self,&timeLapKeyButton,timeLap,OBJC_ASSOCIATION_RETAIN);
    
    NSNumber *spinDirection = [NSNumber numberWithInt:direction];
    objc_setAssociatedObject (self,&directionKeyButton,spinDirection,OBJC_ASSOCIATION_RETAIN);
    
}

- (void)stopSpinInfinityButton{
    
    //get associations
    float initialTime = [(NSString*)objc_getAssociatedObject(self, &initialtimeKeyButton) floatValue];
    float timeLap = [(NSString*)objc_getAssociatedObject(self, &timeLapKeyButton) floatValue];
    NSNumber *directionSpin = (NSNumber*)objc_getAssociatedObject(self, &directionKeyButton);
    //remove all associations
    objc_setAssociatedObject(self,&initialtimeKeyButton,nil,OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self,&timeLapKeyButton,nil,OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self,&directionKeyButton,nil,OBJC_ASSOCIATION_RETAIN);
    
    //remove the current rotation
    CALayer *pLayer = [self.layer presentationLayer];
    [self.layer removeAnimationForKey:@"rotationAnimation"];
    
    //calculating time remaining
    CFTimeInterval aniPause =  CACurrentMediaTime();
    float diffTime = aniPause - initialTime;
    int totalLaps = (int)(diffTime/timeLap);
    float restTime = timeLap - (diffTime - (timeLap * totalLaps));
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.fromValue = [pLayer valueForKeyPath:@"transform.rotation.z"];
    NSNumber *currentPositionZ = [pLayer valueForKeyPath:@"transform.rotation.z"];
    
    if ([directionSpin intValue] == -1) {
        if ([currentPositionZ floatValue] >= 0)
            rotationAnimation.toValue = 0;
        else
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * [directionSpin intValue] ];
    }else {
        if ([currentPositionZ floatValue] <= 0)
            rotationAnimation.toValue = 0;
        else
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * [directionSpin intValue]];
    }
    rotationAnimation.duration = restTime;
    rotationAnimation.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}




@end
