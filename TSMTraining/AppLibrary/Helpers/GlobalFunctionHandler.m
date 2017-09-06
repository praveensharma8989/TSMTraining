//
//  GlobalFunctionHandler.m
//  TSMTraining
//
//  Created by Mobikasa on 06/09/17.
//
//

#import "GlobalFunctionHandler.h"

@implementation GlobalFunctionHandler


+(CRMData *)getUserDetail:(CRMDataArray *)data withUserId:(NSString *)ID{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.crm_id == %@)", ID];
    
    NSArray *array = [data.data filteredArrayUsingPredicate:predicate];
    
    if(array.count > 0){
        
        CRMData *returnData = array[0];
        return returnData;
        
    }else{
        
        CRMData *returnData = [[CRMData alloc] initWithDictionary:nil error:nil];
        return returnData;
    }
    
    
}

@end
