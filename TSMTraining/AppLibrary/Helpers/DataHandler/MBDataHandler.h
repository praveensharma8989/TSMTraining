//
//  MBDataHandler.h
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBDataHandler : NSObject

+ (instancetype)sharedHandler;

-(void)setup;

-(BOOL)isReachableToInternet;

//-(void)updateDataBaseFromServer;
//
@property (nonatomic,strong) UserModel *currentUser;
//@property (nonatomic,strong) UserDetailModel *currentUser;

//@property (nonatomic,strong) NSArray *schoolList;



@end
