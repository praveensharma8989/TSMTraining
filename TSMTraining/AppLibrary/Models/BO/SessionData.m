//
//  SessionData.m
//  TSMTraining
//
//  Created by Praveen Sharma on 07/09/17.
//
//

#import "SessionData.h"

@implementation SessionData

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end

@implementation SessionDataArray

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

-(id)init{
    self = [super init];
    
    if (self) {
        self.data = (id)[NSMutableArray new];
    }
    
    return self;
}

@end
