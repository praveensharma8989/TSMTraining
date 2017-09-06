//
//  GlobalFunctionHandler.h
//  TSMTraining
//
//  Created by Mobikasa on 06/09/17.
//
//

#import <Foundation/Foundation.h>

@interface GlobalFunctionHandler : NSObject

+(CRMData *)getUserDetail:(CRMDataArray *)data withUserId:(NSString *)ID;

@end
