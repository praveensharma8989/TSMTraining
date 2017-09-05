//
//  UIImage+MB.h
//  Florists
//
//  Created by Anil Khanna on 20/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MB)


- (NSString*) base64String;

+ (UIImage *)imageForColor:(UIColor*)color;

- (UIImage *)imageForRect:(CGRect)rect;

-(UIImage *)resizeImageForwidth:(int)wdth height:(int)hght;

- (UIImage *)croppImageToRect:(CGRect)rect;

- (UIImage *)imageByCroppingImageToSize:(CGSize)size;

-(NSUInteger)calculatedSize;


@end
