//
//  Transition.h
//  AnimatedSignIn
//
//  Created by Anil Khanna on 30/03/16.
//  Copyright © 2016 Mobikasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Transition : NSObject <UIViewControllerAnimatedTransitioning>

-(instancetype) initWithTransitionDuration:(NSTimeInterval)transitionDuration StartingAlpha:(CGFloat)startingAlpha isBOOL:(BOOL)is;

@end
