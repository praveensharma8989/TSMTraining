//
//  UIImage+MB.m
//  Florists
//
//  Created by Anil Khanna on 20/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "UIImage+MB.h"

@implementation UIImage (MB)

- (NSString*) base64String{
    
    NSData *data = UIImageJPEGRepresentation(self, 0.5);
    return [data base64EncodedStringWithOptions:0];
}

+ (UIImage *)imageForColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)croppImageToRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return cropped;
}

- (UIImage *)imageForRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    return [UIImage imageWithCGImage:imageRef];
}

-(UIImage *)resizeImageForwidth:(int)wdth height:(int)hght
{
    CGSize newSize = CGSizeMake(wdth, hght);
    
    CGFloat widthRatio = newSize.width/self.size.width;
    
    CGFloat heightRatio = newSize.height/self.size.height;
    
    if(widthRatio > heightRatio)
    {
        newSize=CGSizeMake(self.size.width*heightRatio,self.size.height*heightRatio);
    }
    else
    {
        newSize=CGSizeMake(self.size.width*widthRatio,self.size.height*widthRatio);
    }
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIImage *)resizeImageWithscaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


- (UIImage *)imageByCroppingImageToSize:(CGSize)size
{
    // not equivalent to image.size (which depends on the imageOrientation)!
    
    double refWidth = CGImageGetWidth(self.CGImage);
    
    double refHeight = CGImageGetHeight(self.CGImage);
    
    double x = (refWidth - size.width) / 2.0;
    
    double y = (refHeight - size.height) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, size.height, size.width);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:0.0 orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    return cropped;
}

-(NSUInteger)calculatedSize
{
    return CGImageGetHeight(self.CGImage) * CGImageGetBytesPerRow(self.CGImage);
}





@end
