//
//  Race_boat.h
//  RaceControl
//
//  Created by macmini6 on 04/06/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Boat_master, Race_master;

@interface Race_boat : NSManagedObject

@property (nonatomic, retain) NSNumber * boat_id;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * race_id;
@property (nonatomic, retain) Boat_master *addboatmaster;
@property (nonatomic, retain) Race_master *addracemaster;

@end
