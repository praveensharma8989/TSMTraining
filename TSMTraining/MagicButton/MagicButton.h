//
//  MagicButton.h
//  AnimatedSignIn
//
//  Created by Anil Khanna on 30/03/16.
//  Copyright © 2016 Mobikasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinerLayer.h"

typedef void(^Completion)();

@interface MagicButton : UIButton

@property (nonatomic,retain) SpinerLayer *spiner;

-(void)startAnimation;

-(void)stopAnimation:(Completion)completion;

-(void)ErrorRevertAnimation;

@end
