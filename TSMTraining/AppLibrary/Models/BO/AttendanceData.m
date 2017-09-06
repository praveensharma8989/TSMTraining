//
//  AttendanceData.m
//  TSMTraining
//
//  Created by Praveen Sharma on 07/09/17.
//
//

#import "AttendanceData.h"

@implementation AttendanceData

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end

@implementation AttendanceDataArray

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
