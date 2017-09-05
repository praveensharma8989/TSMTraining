//
//  CRMData.m
//  TSMTraining
//
//  Created by Mobikasa on 05/09/17.
//
//

#import "CRMData.h"

@implementation CRMData

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end

@implementation CRMDataArray

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
