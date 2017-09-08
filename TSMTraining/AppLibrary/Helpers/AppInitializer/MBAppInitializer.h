//
//  MBAppInitializer.h
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>
#import "TSMViewController.h"


@interface MBAppInitializer : NSObject
@property(strong, nonatomic) Reachability *reachability;

+(instancetype)sharedInstance;

+(void) setup;

+(void)moveToInitialViewController;

+(void)moveToLandingViewController;

+ (void)keyboardManagerEnabled;

+ (void)keyboardManagerDisabled;

@end
