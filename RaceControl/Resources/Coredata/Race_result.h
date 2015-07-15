//
//  Race_result.h
//  RaceControl
//
//  Created by macmini6 on 04/06/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Boat_master, Race_master;

@interface Race_result : NSManagedObject

@property (nonatomic, retain) NSNumber * boat_id;
@property (nonatomic, retain) NSString * csv_path;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSNumber * race_id;
@property (nonatomic, retain) NSString * sailno;
@property (nonatomic, retain) NSString * skipper;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * video_path;
@property (nonatomic, retain) Boat_master *addboatresultmaster;
@property (nonatomic, retain) Race_master *addraceresultmaster;

@end
