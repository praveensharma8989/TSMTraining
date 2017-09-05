//
//  Transition.m
//  AnimatedSignIn
//
//  Created by Anil Khanna on 30/03/16.
//  Copyright © 2016 Mobikasa. All rights reserved.
//

#import "Transition.h"

@interface Transition ()

@property (nonatomic,assign) NSTimeInterval transitionDuration;

@property (nonatomic,assign) CGFloat startingAlpha;

@property (nonatomic,assign) BOOL is;

@property (nonatomic,retain) id transitionContext;

@end


@implementation Transition


-(instancetype) initWithTransitionDuration:(NSTimeInterval)transitionDuration StartingAlpha:(CGFloat)startingAlpha isBOOL:(BOOL)is{
    self = [super init];
    if (self) {
        _transitionDuration = transitionDuration;
        _startingAlpha = startingAlpha;
        _is = is;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    return _transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    
    if (_is) {
        toView.alpha = _startingAlpha;
        fromView.alpha = 0.6;
        
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toView.alpha = 1.0f;
            fromView.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            fromView.alpha = 1.0f;
            [transitionContext completeTransition:true];
        }];
    }
}





@end
