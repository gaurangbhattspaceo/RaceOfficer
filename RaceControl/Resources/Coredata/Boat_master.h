//
//  Boat_master.h
//  RaceControl
//
//  Created by macmini6 on 04/06/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Race_boat, Race_result;

@interface Boat_master : NSManagedObject

@property (nonatomic, retain) NSString * boatno;
@property (nonatomic, retain) NSString * classname;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sailno;
@property (nonatomic, retain) NSString * skipper;
@property (nonatomic, retain) NSSet *addboat;
@property (nonatomic, retain) Race_result *addboatresult;
@end

@interface Boat_master (CoreDataGeneratedAccessors)

- (void)addAddboatObject:(Race_boat *)value;
- (void)removeAddboatObject:(Race_boat *)value;
- (void)addAddboat:(NSSet *)values;
- (void)removeAddboat:(NSSet *)values;

@end
