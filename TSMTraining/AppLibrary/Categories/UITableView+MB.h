//
//  UITableView+MB.h
//  Florists
//
//  Created by Anil Khanna on 7/24/15.
//  Copyright (c) 2015 Mobikasa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (MB)

- (NSIndexPath *)MB_IndexPathForCellContainingView:(UIView *)view;

@end
