//
//  OfflineObject.h
//  UrbanRunr
//
//  Created by Anil Khanna on 07/01/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OfflineObject : NSManagedObject

@property (nonatomic, retain) NSNumber  *objId;
@property (nonatomic, retain) NSString  *objName;
@property (nonatomic, retain) NSString  *objData;
@property (nonatomic, retain) NSNumber  *objType;
@property (nonatomic, retain) NSString  *objClass;
@property (nonatomic, retain) NSNumber  *isOfflineUpdated;

@end
