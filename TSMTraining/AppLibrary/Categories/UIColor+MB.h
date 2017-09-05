//
//  UIColor+MB.h
//  Florists
//
//  Created by Anil Khanna on 17/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MB)

+(instancetype)defaultBlueColor;

+(instancetype)defaultBackgroundColor;

+(instancetype)defaultDarkBlueColor;

+(instancetype)defaultGreenColor;

+(instancetype)defaultCyanColor;

+(UIColor *) colorFromHexString:(NSString *)hexString;

@end
