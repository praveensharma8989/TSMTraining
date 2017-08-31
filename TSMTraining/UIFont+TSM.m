//
//  UIFont+TSM.m
//  TSMTraining
//
//  Created by Praveen Sharma on 31/08/17.
//  Copyright © 2017 Praveen Sharma. All rights reserved.
//

#import "UIFont+TSM.h"

@implementation UIFont (TSM)

+(instancetype)TSM_AppFontWithType:(fontType)type WithSize:(float)size{
    NSString *string = @"Open Sans";
    
    switch (type) {
        case Light:
            string = @"AvenirLTStd-Light";
            break;
        case Medium:
            string = @"AvenirLT-Medium";
            break;
            
            break;
        default:
            break;
    }
    return [UIFont fontWithName:string size:size];
}


@end
