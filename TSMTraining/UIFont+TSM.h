//
//  UIFont+TSM.h
//  TSMTraining
//
//  Created by Praveen Sharma on 31/08/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Regular,
    Bold,
    Italic,
    SemiBold,
    Light,
    Medium,
} fontType;

@interface UIFont (TSM)

+(instancetype)TSM_AppFontWithType:(fontType)type WithSize:(float)size;

@end
