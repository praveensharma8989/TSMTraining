//
//  MagicButton.m
//  AnimatedSignIn
//
//  Created by Anil Khanna on 30/03/16.
//  Copyright © 2016 Mobikasa. All rights reserved.
//

#import "MagicButton.h"
@interface MagicButton()

@property (nonatomic,strong) Completion block;
@property (nonatomic,retain) CAMediaTimingFunction *expandCurve;

@end
@implementation MagicButton

-(void)startAnimation{
    [[[[UIApplication sharedApplication] delegate] window] setUserInteractionEnabled:NO];
    self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    self.clipsToBounds = true;
    _spiner = [[SpinerLayer alloc] initWithFrame:self.frame];
    [self.layer addSublayer:_spiner];
     [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    _expandCurve = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1 :0.05];
    
    [self startMagic];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self showMagic:completion];
//    });
}

-(void)stopAnimation:(Completion)completion{
    [[[[UIApplication sharedApplication] delegate] window] setUserInteractionEnabled:YES];
    [self showMagic:completion];
}

-(void)startMagic{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];

    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(CGRectGetWidth(self.bounds));
    shrinkAnim.toValue = @(CGRectGetHeight(self.bounds));
    shrinkAnim.duration = 0.1;
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = false;
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    [_spiner animation];
    [self setUserInteractionEnabled:false];
}


-(void)ErrorRevertAnimation
{
//    _block = completion;
    [[[[UIApplication sharedApplication] delegate] window] setUserInteractionEnabled:YES];
    self.layer.cornerRadius = 0;
    self.clipsToBounds = true;
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];

    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(CGRectGetHeight(self.bounds));
    shrinkAnim.toValue = @(CGRectGetWidth(self.bounds));
    shrinkAnim.duration = 0.1;;
    shrinkAnim.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = false;
//    _color = self.backgroundColor;
    
//    CABasicAnimation *backgroundColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    backgroundColor.toValue  = (__bridge id)self.backgroundColor.CGColor;
//    backgroundColor.duration = 0.1f;
//    backgroundColor.timingFunction = _expandCurve;
//    backgroundColor.fillMode = kCAFillModeForwards;
//    backgroundColor.removedOnCompletion = false;
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.layer.position;
    keyFrame.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:point]];
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration = 0.5f;
    keyFrame.delegate = self;
    self.layer.position = point;
    
//    [self.layer addAnimation:backgroundColor forKey:backgroundColor.keyPath];
    [self.layer addAnimation:keyFrame forKey:keyFrame.keyPath];
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    [_spiner stopAnimation];
    [self setUserInteractionEnabled:true];
}


-(void)showMagic:(Completion)completion{
    
    _block = completion;
    
    CABasicAnimation *expandAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnim.fromValue = @(1.0);
    expandAnim.toValue = @(33.0);
    expandAnim.duration = 0.3;
    expandAnim.delegate = self;
    expandAnim.timingFunction = _expandCurve;
    expandAnim.fillMode = kCAFillModeForwards;
    expandAnim.removedOnCompletion = false;
    [self.layer addAnimation:expandAnim forKey:expandAnim.keyPath];
     [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [_spiner stopAnimation];
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    CABasicAnimation *cab = (CABasicAnimation *)anim;
    if ([cab.keyPath isEqualToString:@"transform.scale"]) {
        [self setUserInteractionEnabled:true];
        if (_block) {
            _block();
        }
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(DidStopAnimation) userInfo:nil repeats:nil];
    }
}


-(void)DidStopAnimation{
    
    [self.layer removeAllAnimations];
}


@end
