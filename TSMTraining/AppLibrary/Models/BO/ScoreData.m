//
//  ScoreData.m
//  TSMTraining
//
//  Created by Praveen Sharma on 07/09/17.
//
//

#import "ScoreData.h"

@implementation ScoreData

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end

@implementation ScoreDataArray

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
