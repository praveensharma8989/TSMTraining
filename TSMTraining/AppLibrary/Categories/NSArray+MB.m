//
//  NSArray+MB.m
//  Florists
//
//  Created by Anil Khanna on 12/03/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "NSArray+MB.h"

@implementation NSArray (MB)


-(id)MB_safeObjectAtIndex:(NSInteger)index{
    
    if ([self count]>index) {
        return [self objectAtIndex:index];
    }
    
    return nil;
}

@end
