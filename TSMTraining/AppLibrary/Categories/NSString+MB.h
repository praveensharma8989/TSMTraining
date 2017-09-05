//
//  NSString+MB.h
//  Florists
//
//  Created by Anil Khanna on 13/03/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MB)

- (NSString*)checkIfEmpty;

- (NSString*)splitWith:(NSString*)character atIndex:(NSInteger)index;

- (UIImage*)base64ToImage;

- (NSString*)base64;

- (NSString*)base64ToString;

- (BOOL)hasSpace;

- (NSRange)range;

-(NSString*)getDateStringWithFormat:(NSString*)dateFormat;

-(NSDate*)getDateObjectFromString;
-(NSDate*)getDateWithFormat:(NSString*)dateFormat;

@end
