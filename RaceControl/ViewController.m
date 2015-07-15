//
//  ViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 06/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "ViewController.h"
#import "CreateNewRacesViewController.h"
#import "NotificationViewController.h"
#import "SettingsViewController.h"
#import "UpcomingRaceViewController.h"
#import "CompleteRaceViewController.h"
#import "Notification_master.h"
#import "CurrentRaceViewController.h"
#import "AccountViewController.h"

#import "Boat_master.h"
#import "Race_master.h"
#import "Race_boat.h"
#import "Race_result.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface ViewController ()

@end

@implementation ViewController
{
    AVAudioPlayer *player;
    NSMutableArray *finalArray;
}

- (void)viewDidLoad
{ 
    [super viewDidLoad];
    

    _scrollview.contentSize =CGSizeMake([UIScreen mainScreen].bounds.size.width,600);
    dictTemp =[[NSMutableDictionary alloc] init];
    Dictmain=[[NSMutableDictionary alloc] init];
    arrUser =[[NSMutableArray alloc] init];
    arrAddFromExisting=[[NSMutableArray alloc] init];
    
    

    
    
//    NSArray *arrracetemp =[[NSArray alloc]init];
//    arrracetemp =[CoreDataUtils RelationgetObject:[Race_boat description] withQueryString:@"(race_id = %@)" queryArguments:@[@"3"] sortBy:nil];
//    NSMutableArray *addracetemp =[[NSMutableArray alloc] initWithArray:[DELEGATE convertToArray:arrracetemp]];
//    NSLog(@"%@",addracetemp);
//    
//    
//    finalArray = [[NSMutableArray alloc] init];
//   // NSString *strboatidlist =[[NSString alloc] init];
//     for (int i=0; i<addracetemp.count; i++)
//     {
//        
//         NSMutableDictionary *dict = [NSMutableDictionary new];
//         NSArray *array2 =[[NSArray alloc]init];
//         array2 =[CoreDataUtils getObjects:[Race_result description]withQueryString:@"(boat_id = %@)" queryArguments:@[[[addracetemp objectAtIndex:i]valueForKey:@"boat_id"]] sortBy:nil];
//         NSLog(@"%@",array2);
//         
//         Race_result *raceResult;
//         int sum = 0;
//         for (int j = 0; j< array2.count ; j++)
//         {
//             raceResult = [array2 objectAtIndex:j];
//             sum = sum+[raceResult.place intValue];
//            
//         }
//         
//        
//         
//         Boat_master *boatMaster = [CoreDataUtils getObject:[Boat_master description]withQueryString:@"(identifier = %@)" queryArguments:@[[[addracetemp objectAtIndex:i]valueForKey:@"boat_id"]] sortBy:nil];
//         if (array2.count>0)
//         {
//              float avg = sum/array2.count;
//             [dict setValue:boatMaster.skipper forKey:@"skipper"];
//             [dict setValue:boatMaster.sailno forKey:@"sailno"];
//             [dict setValue:boatMaster.identifier forKey:@"identifier"];
//             [dict setValue:boatMaster.name forKey:@"name"];
//             [dict setValue:boatMaster.boatno forKey:@"boatno"];
//             [dict setObject:[NSString stringWithFormat:@"%f",avg] forKey:@"avg"];
//             [dict setValue:[NSString stringWithFormat:@"%lu",(unsigned long)array2.count] forKey:@"count"];
//             
//         }
//         else
//         {
//             [dict setValue:boatMaster.skipper forKey:@"skipper"];
//             [dict setValue:boatMaster.sailno forKey:@"sailno"];
//             [dict setValue:boatMaster.identifier forKey:@"identifier"];
//             [dict setValue:boatMaster.name forKey:@"name"];
//             [dict setValue:boatMaster.boatno forKey:@"boatno"];
//             [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"avg"];
//             [dict setValue:[NSString stringWithFormat:@"%lu",(unsigned long)array2.count] forKey:@"count"];
//         }
//         
//         
//         
//         [finalArray addObject:dict];
//        
//         
//     }
//    NSMutableDictionary *dict = [NSMutableDictionary new];
//    
//    [dict setObject:[NSString stringWithFormat:@"1.00000"] forKey:@"avg"];
//    [dict setValue:[NSString stringWithFormat:@"3"] forKey:@"count"];
//    
//    [finalArray addObject:dict];
//    NSLog(@"%@",finalArray);
    
    

//    NSArray *avgArray = [NSArray new];
//    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"avg" ascending:YES ];
//    NSSortDescriptor *sort2= [NSSortDescriptor sortDescriptorWithKey:@"count" ascending:YES ];
//    
//    
//    
//  avgArray =   [finalArray sortedArrayUsingDescriptors:@[sort1, sort2]];
//    
//    //avgArray = [finalArray sortedArrayUsingDescriptors:@[sort1]];
//
//    
//    
//     NSLog(@"%@",avgArray);


}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    _imgnotificationbg.hidden=YES;
    _lblnotification.hidden=YES;
    
    _imgnotificationbg.layer.cornerRadius = _imgnotificationbg.frame.size.height/2;
    _imgnotificationbg.layer.masksToBounds = YES;
    _imgnotificationbg.layer.borderWidth = 0;
    

    NSArray *array =[[NSArray alloc] init];
    
    NSDate *date = [NSDate date];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond
                                                             fromDate:date];
    date = [date dateByAddingTimeInterval:-comp.second+300];
    NSLog(@"%@",date);
    NSLog(@"%@",[NSDate date]);
    array = [CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(notificationStatus = %@)  AND (starttime <= %@) AND (starttime >= %@)" queryArguments:@[@"0",date,[NSDate date]] sortBy:nil];
    
    if (array.count == 0) {
            [_imgnotificationbg setHidden:YES];
            [_lblnotification setHidden:YES];
    }
    else{
            [_imgnotificationbg setHidden:NO];
            [_lblnotification setHidden:NO];
            _lblnotification.text =[NSString stringWithFormat:@"%lu",(unsigned long)array.count];
    }

}



#pragma mark Create New Race
- (IBAction)btnCreateNewRaceClicked:(id)sender
{
    CreateNewRacesViewController *createNewRace=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewRacesViewController"];
    [self.navigationController pushViewController:createNewRace animated:YES];
    
//    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"sound4"
//                                                              ofType:@"mp3"];
//   // NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
//     NSURL *soundFileURL = [NSURL URLWithString:soundFilePath];
//     player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
//                                                                   error:nil];
//    if ([player prepareToPlay]) {
//        [player play];
//    }
//    else{
//    
//    }
//    
//    
//    dictTemp =[[NSMutableDictionary alloc] init];
//    Dictmain=[[NSMutableDictionary alloc] init];
//    arrUser =[[NSMutableArray alloc] init];
//    arrAddFromExisting=[[NSMutableArray alloc] init];
}

#pragma mark Upcoming Races
- (IBAction)btnUpcomingRacesClicked:(id)sender
{
    UpcomingRaceViewController *UpcomingVC=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRaceViewController"];
    [self.navigationController pushViewController:UpcomingVC animated:YES];
}

#pragma mark Complete Race
- (IBAction)btnCompleteRacesClicked:(id)sender
{
    CompleteRaceViewController *CompleteVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CompleteRaceViewController"];
    [self.navigationController pushViewController:CompleteVC animated:YES];
    
    
}

#pragma mark Settings
- (IBAction)btnSettingsClicked:(id)sender
{
    AccountViewController *accountVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AccountViewController"];
    [self.navigationController pushViewController:accountVC animated:YES];
    
}

#pragma mark Notificaiton
- (IBAction)btnNotificationClicked:(id)sender
{
    NotificationViewController *notify=[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:notify animated:YES];
}

- (IBAction)btncurrentRaceClicked:(id)sender
{
    CurrentRaceViewController *UpcomingVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CurrentRaceViewController"];
    [self.navigationController pushViewController:UpcomingVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
