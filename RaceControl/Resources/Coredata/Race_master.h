//
//  Race_master.h
//  RaceControl
//
//  Created by Peerbits MacMini9 on 20/06/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Race_boat, Race_result;

@interface Race_master : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * isboatadded;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notificationStatus;
@property (nonatomic, retain) NSString * racecomplete;
@property (nonatomic, retain) NSDate * starttime;
@property (nonatomic, retain) NSString * timelimit;
@property (nonatomic, retain) NSString * typeofrace;
@property (nonatomic, retain) NSString * expiretime;
@property (nonatomic, retain) Race_boat *addrace;
@property (nonatomic, retain) NSSet *addraceresult;
@end

@interface Race_master (CoreDataGeneratedAccessors)

- (void)addAddraceresultObject:(Race_result *)value;
- (void)removeAddraceresultObject:(Race_result *)value;
- (void)addAddraceresult:(NSSet *)values;
- (void)removeAddraceresult:(NSSet *)values;

@end
