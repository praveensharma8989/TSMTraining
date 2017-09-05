//
//  NSDateFormatter+UBR.h
//  UrbanRunr
//
//  Created by Vishwas on 05/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (MB)

+(instancetype)MB_defaultDateFormatterWithGMT:(BOOL)gmt;

+(instancetype)MB_defaultDateFormatter;

+(instancetype)MB_defaultFormatter:(NSString*)format;

+(instancetype)MB_defaultTimeFormatterWith12HrFormat:(BOOL)is12Hr;

+(instancetype)MB_defaultDateTimeFormatterWith12HrFormat:(BOOL)is12Hr;


@end
