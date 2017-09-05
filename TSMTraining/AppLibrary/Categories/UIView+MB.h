//
//  UIView+MB.h
//  Florists
//
//  Created by Anil Khanna on 15/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ViewMoveCompletion)(BOOL iscompleted);

@interface UIView (MB)


IB_DESIGNABLE

//-(void)setGradientLayerWithColor:(UIColor*)color;

-(void)bounceEffect;
//-(void)setAlphaAnimation:(CGFloat)value WithDuration:(CGFloat)duration withDelay:(CGFloat)delay WithCompletion:(ViewMoveCompletion) viewMoveCompletion;
//-(void)setMoveConstraint:(NSLayoutConstraint *)constraint withMovePosition:(CGFloat)value withSpringBounce:(CGFloat)bounciness WithBeginTime:(CGFloat)delay WithCompletion:(ViewMoveCompletion) viewMoveCompletion;
//-(void)setShadowLayerWithColor:(UIColor*)color;
//-(void)setShadowLayerWithColors:(UIColor *)color withCornerRounded:(CGFloat)radius;

//+(UIImage*)setlayerToGradientcolorWithColor:(UIColor*)Color WithHeight:(CGFloat) height;
//-(void)setlayerToVerticalGradientcolorWithColor:(UIColor*)Color;

-(void)setColorChangeAnimation:(UIColor*)color WithDuration:(CGFloat)duration withDelay:(CGFloat)delay WithCompletion:(ViewMoveCompletion) viewMoveCompletion;

-(void)removeLayerToVerticalGradientWithBackGround:(UIColor*)color;

-(void)setShadowLayerWithColors:(UIColor *)color shadowOffset:(CGSize)size radius:(CGFloat)radius withCornerRounded:(CGFloat)cornerradius;
-(void)setShadowLayerWithColors:(UIColor *)color shadowOffset:(CGSize)size radius:(CGFloat)radius withCornerRounded:(CGFloat)cornerradius withShadowOpacity:(CGFloat)shadowOpacity;

@property (nonatomic,strong) IBInspectable UIColor *borderColor;

@property (nonatomic,assign) IBInspectable NSInteger borderWidth;

@property (nonatomic,assign) IBInspectable NSInteger cornerRadius;

@property (nonatomic) IBInspectable UIColor *topBorderColor;

@property (nonatomic) IBInspectable UIColor *bottomBorderColor;

@property (nonatomic, strong) ViewMoveCompletion viewMoveCompletion;

//+(UILabel*)getNoDataContentView;
//
//+(UILabel*)getNoDataContentViewWithText:(NSString*)text;
//
//+(UILabel*)getNoDataContentViewWithTableView:(UITableView *)tableView;
/**
 Make Border of current view.
 
 @param width The Width of the border.
 @param color The Color of the border.
 
 */
-(void)makeBorderWithWidth:(float)width andColor:(UIColor *)color;

/**
 Add Top Border on current view.
 
 @param width The Width of the border.
 @param color The Color of the border.
 
 */
-(void)addTopBorderWithWidth:(float)width andColor:(UIColor *)color;

/**
 Add Top and bottom Border on current view.
 
 @param width The Width of the border.
 @param color The Color of the border.
 
 */

-(void)addTopBottomBorderWithColor:(UIColor *)color andWidth:(float)width;

/**
 Add bottom Border on current view.
 
 @param width The Width of the border.
 @param color The Color of the border.
 
 */

-(void)addBottomBorderWithColor:(UIColor *)color andWidth:(float)width;

/**
 Add Bottom Border on current view.
 
 @param width The Width of the border.
 @param color The Color of the border.
 
 */
-(void)addBottomBorderWithWidth:(float)width andColor:(UIColor *)color;

/**
 Add Left Padding to UITextField.
 @param: padding width
 */
-(void)addLeftPadding:(float)width;

/**
 Add Right Padding to UITextField.
 @param: padding width
 */
-(void)addRightPadding:(float)width;

/**
 Add Left Image on TextField.
 
 @param image Image to put left side on textfield.
 
 */
-(void)addLeftSideImageToTextFieldWithImage:(UIImage *)image;

/**
 Add Left Image on TextField.
 
 @param image Image to put right side on textfield.
 
 */

-(void)addRightSideImageToTextFieldWithImage:(UIImage *)image;




// methods to spin the view containing text


+(UIImage*)setlayerToGradientcolorfromColor: (UIColor*)fColor toColor:(UIColor*)scolor WithHeight:(CGFloat)height;


- (void)spinButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction;
- (void)spinInfinityButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction;
- (void)stopSpinInfinityButton;

 @end
