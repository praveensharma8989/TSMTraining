//
//  AppDelegate.h
//  TSMTraining
//
//  Created by Mobikasa on 05/09/17.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+(instancetype)sharedDelegate;

- (void)saveContext;

-(BOOL)connectedToInternet;

@end

