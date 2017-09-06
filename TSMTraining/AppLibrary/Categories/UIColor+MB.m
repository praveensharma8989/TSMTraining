//
//  UIColor+MB.m
//  Florists
//
//  Created by Anil Khanna on 17/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "UIColor+MB.h"

@implementation UIColor (MB)


+(instancetype)defaultBlueColor{
    return [UIColor colorWithRed:74.0f/255.0f green:104.0f/255.0f blue:172.0f/255.0f alpha:1.0];
}

+(instancetype)defaultBackgroundColor{
    return [UIColor colorWithWhite:0.937 alpha:1.000];
}

+(instancetype)defaultDarkBlueColor{
    return [UIColor colorWithRed:0.043 green:0.369 blue:0.992 alpha:1.000];
}

+(instancetype)defaultGreenColor{
    return [UIColor colorWithRed:0.188 green:0.780 blue:0.827 alpha:1.000];
}

+(instancetype)defaultCyanColor{
    return [UIColor colorWithRed:(0/255.0f) green:(184/255.0f) blue:(201/255.0f) alpha:1.000];
}

+(instancetype)appBlueColor{
    return [UIColor colorWithRed:33.0f/255.0f green:64.0f/255.0f blue:154.0f/255.0f alpha:1.0f];
}

+(UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
