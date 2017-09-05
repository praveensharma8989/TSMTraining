//
//  UITableView+MB.m
//  Florists
//
//  Created by Anil Khanna on 7/24/15.
//  Copyright (c) 2015 Mobikasa. All rights reserved.
//

#import "UITableView+MB.h"

@implementation UITableView (MB)

- (NSIndexPath *)MB_IndexPathForCellContainingView:(UIView *)view {
    while (view != nil) {
        if ([view isKindOfClass:[UITableViewCell class]]) {
            return [self indexPathForCell:(UITableViewCell *)view];
        } else {
            view = [view superview];
        }
    }
    
    return nil;
}

@end
