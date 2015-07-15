//
//  CompleteRaceViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "CompleteRaceViewController.h"
#import "CompleteRaceCustomCell.h"
#import "RaceResultController.h"
#import "ViewController.h"
#import "Race_master.h"
#import "Race_boat.h"
#import "Boat_master.h"


@interface CompleteRaceViewController ()

@end

@implementation CompleteRaceViewController
{

    Race_master *Race_info;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSDate *now = [NSDate date];
//    int daysToAdd = -1;
//    
//    // set up date components
//    NSDateComponents *components = [[NSDateComponents alloc] init] ;
//    [components setDay:daysToAdd];
//    // create a calendar
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *yesterday = [gregorian dateByAddingComponents:components toDate:now options:0];
//    NSLog(@"Yesterday: %@", yesterday);
    
    
    _arrCompleteRace =[[NSMutableArray alloc] init];
  
    
    NSArray *array =[[NSArray alloc]init];
    //array =[CoreDataUtils getObjects:[Race_master description]];
   
    array = [CoreDataUtils getObjects:[Race_master description] withQueryString:@"racecomplete = %@ AND isboatadded = %@" queryArguments:@[@"Y",@"Y"] sortBy:nil];
    
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"starttime" ascending:NO];

    array = [array sortedArrayUsingDescriptors:@[sort1]];
    
    NSLog(@"%@",array);
    NSLog(@"%@",[DELEGATE convertToArray:array]);
    _arrCompleteRace =[[NSMutableArray alloc] initWithArray:array];

    
    if (array.count>0) {
        [_tblCompleteRace reloadData];
    }
    else{
        

        
        UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(10,self.view.frame.size.height/2 -100, [UIScreen mainScreen].bounds.size.width-10, 200)];
        lbl.text =@"You don't have any completed races yet.";
        lbl.font =FONT_Regular(24);
        lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
        lbl.numberOfLines=0;
        lbl.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:lbl];
        
        
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _arrCompleteRace.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CompleteRaceCustomCell";
    CompleteRaceCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"CompleteRaceCustomCell" owner:self options:nil];
        cell = (CompleteRaceCustomCell *)[arrNib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    Race_info =[_arrCompleteRace objectAtIndex:indexPath.row];
    
    
    cell.lblDate.text =[NSString stringWithFormat:@"%@",[DELEGATE convertDateToStringformat:Race_info.date]];
    cell.lblCity.text =[NSString stringWithFormat:@"%@",Race_info.location];
    cell.lblRaceName.text =[NSString stringWithFormat:@"%@",Race_info.name];
    
    
    
    [cell.lblStarted setText:[NSString stringWithFormat:@"STARTED %@",[DELEGATE convertDateToFullStringformat:Race_info.starttime]]];
    
    //NSLog(@"%@",Race_info.timelimit);
    
//    NSString *timeLimit=[NSString stringWithFormat:@"%@",Race_info.timelimit];
//    timeLimit=[timeLimit stringByReplacingOccurrencesOfString:@"minutes" withString:@""];
    
    int checktag  =[Race_info.expiretime intValue];
 
    NSDate *startDate=[[NSDate alloc]init];
    startDate=Race_info.starttime;
    
    int startTimeinterval=[startDate timeIntervalSince1970];
    startTimeinterval=startTimeinterval+checktag;
    
    NSDate *newDate=[[NSDate alloc]init];
    
    newDate=[NSDate dateWithTimeIntervalSince1970:startTimeinterval];
    
    NSLog(@"%@",newDate);
    
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"HH:mm"];
    
    NSString *str=[df stringFromDate:newDate];
    
    [cell.lblTimeLimit setText:[NSString stringWithFormat:@"%@",str]];
    
    
    // array = [CoreDataUtils getObjects:[Race_master description] withQueryString:@"(starttime >= %@)" queryArguments:@[currentDate] sortBy:nil];
    
    // NSLog(@"%@",Race_info.identifier);
    
    
    NSArray *ary=[CoreDataUtils RelationgetObject:[Race_boat description] withQueryString:@"race_id = %d" queryArguments:@[Race_info.identifier] sortBy:nil];
    
    NSLog(@"%@",ary);
    
    
    [cell.lblBoats setText:[NSString stringWithFormat:@"%d",(int)[ary count]]];
   
    [cell.lblClass setText:[NSString stringWithFormat:@"%@",Race_info.typeofrace]];
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DELEGATE.camefrmcompleterace =YES;
    Race_info =[_arrCompleteRace objectAtIndex:indexPath.row];
    NSLog(@"%@",[_arrCompleteRace objectAtIndex:indexPath.row]);
    RaceResultController *raceResult=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceResultController"];
    [raceResult setRaceId:[NSString stringWithFormat:@"%@",Race_info.identifier]];
    [raceResult setStrRacename:[NSString stringWithFormat:@"%@",Race_info.name]];
    [raceResult setStrRacetime:[NSString stringWithFormat:@"Time Limit:%@",Race_info.timelimit]];
  
    [self.navigationController pushViewController:raceResult animated:YES];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    
    Race_info =[_arrCompleteRace objectAtIndex:indexPath.row];
    
    
     NSLog(@"%@",Race_info.identifier);
    
    ///******** now remove notification
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    if (eventArray.count>0) {
        for (int i=0; i<[eventArray count]; i++)
        {
            UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
            NSDictionary *userInfoCurrent = oneEvent.userInfo;
            NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"raceid"]];
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@",Race_info.identifier]);
            
            if ([uid isEqualToString:[NSString stringWithFormat:@"%@",Race_info.identifier]])
            {
                //Cancelling local notification
                [app cancelLocalNotification:oneEvent];
                
            }
        }
    }
    
    [CoreDataUtils deleteObject:Race_info];
    
    [CoreDataUtils updateDatabase];
 
    
    //******
    
    
    [_arrCompleteRace removeObjectAtIndex:indexPath.row];

    if (_arrCompleteRace.count>0)
    {
        [_tblCompleteRace reloadData];
    }
    else{
        
       [_tblCompleteRace reloadData];
        
        UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(10,self.view.frame.size.height/2 -100, [UIScreen mainScreen].bounds.size.width-10, 200)];
        lbl.text =@"You don't have any completed races yet.";
        lbl.font =FONT_Regular(24);
        lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
        lbl.numberOfLines=0;
        lbl.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:lbl];
        
        
    }

    
    
}




- (IBAction)btnBackClicked:(id)sender
{
    
    BOOL tap = NO;
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[ViewController class]]) {
                    tap=YES;
                    [self.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }
            if (!tap) {
                ViewController *addBoatscontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                [self.navigationController pushViewController:addBoatscontroller animated:YES];
            }
}
@end
