//
//  UpcomingRaceViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "UpcomingRaceViewController.h"
#import "UpcomingCustomCell.h"
#import "RaceDetailsViewController.h"
#import "RaceViewController.h"
#import "Race_master.h"
#import "Boat_master.h"
#import "Race_boat.h"

@interface UpcomingRaceViewController ()
{
    
    int SelectedIndex;
}


@end

@implementation UpcomingRaceViewController
{
   // NSString *strRaceName;
    Race_master *Race_info;
     NSString *strID;
    NSMutableArray *arrRaceDetail;
    
    Boat_master *objBoatMasater;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SelectedIndex = 0;
 
    //_arrUpComingRace =[CoreDataUtils getObjects:[Race_master description] inContext:<#(NSManagedObjectContext *)#> withQueryString:<#(NSString *)#> queryArguments:<#(NSArray *)#> sortBy:<#(NSDictionary *)#>]
}



-(NSString *)convertDateToFullStringformat:(NSDate *)Date
{
    NSDateFormatter *dateformateDate;
    dateformateDate.dateFormat = @"HH:mm";
    NSString *strDate = [NSString stringWithFormat:@"%@",
                         [dateformateDate stringFromDate:Date]];
    
    return strDate;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    CGRect newFrame = self.myCustomAlertView.frame;
    newFrame.origin.y = 1500;
    self.myCustomAlertView.frame = newFrame;
    
    
    [self.imgAlertBackGround.layer setCornerRadius:3.0f];
    [self.imgAlertBackGround.layer setMasksToBounds:YES];
    [self.imgCancelView.layer setCornerRadius:3.0f];
    [self.imgCancelView.layer setMasksToBounds:YES];
    
    _arrUpComingRace =[[NSMutableArray alloc] init];
    arrRaceDetail =[[NSMutableArray alloc] init];
    
    NSDate *currentDate = [NSDate date];
    
//    currentDate=[self toLocalTime:currentDate];
    
    currentDate = [currentDate dateByAddingTimeInterval:60];
 
    //NSLog(@"%@",currentDate);
    
    NSArray *array =[[NSArray alloc]init];
    //array =[CoreDataUtils getObjects:[Race_master description]];
    array = [CoreDataUtils getObjects:[Race_master description] withQueryString:@"(starttime >= %@ AND isboatadded = %@)" queryArguments:@[currentDate,@"Y"] sortBy:nil];
   
    //NSLog(@"%@",array);
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES ];
    array = [array sortedArrayUsingDescriptors:@[sort1]];
    
  
    for (int i=0;i<[array count];i++)
    {
        
        Race_master *obj=[array objectAtIndex:i];
        
        if ([obj.racecomplete isEqualToString:@"Y"])
        {
            
            
        }
        else
        {
            [_arrUpComingRace addObject:[array objectAtIndex:i]];
            
            
        }
        
        
    }
    
    arrRaceDetail=[self convertToArray:_arrUpComingRace];
    
    //****** here get boat class and number of boats in race
    
    
    
    
    if (array.count>0) {
         [_tblUpComingRace reloadData];
    }
    else{
        
        [_tblUpComingRace reloadData];
    
       // UIImageView *img =[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
       // [img setBackgroundColor:[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0]];
        //[self.view addSubview:img];
        
        UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(10,self.view.frame.size.height/2 -100, [UIScreen mainScreen].bounds.size.width-10, 200)];
        lbl.text =@"You don't have any upcoming races.";
        lbl.font =FONT_Regular(24);
        lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
        lbl.numberOfLines=0;
        lbl.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:lbl];
        
        
    }
    
    


    
//    NSArray *arr =[[NSArray alloc] init];
//    
//    arr =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(identifier = %@)" queryArguments:@[strId] sortBy:nil];
//    
//    NSLog(@"%@",[DELEGATE convertToArray:arr]);
//    
//    
//    race_info =[arr objectAtIndex:0];
    

  
    
   

}

-(NSDate *)toLocalTime:(NSDate *)UtcDate
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: UtcDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate: UtcDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrUpComingRace.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UpcomingCell";
    UpcomingCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"UpcomingCustomCell" owner:self options:nil];
        cell = (UpcomingCustomCell *)[arrNib objectAtIndex:0];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    Race_info =[_arrUpComingRace objectAtIndex:indexPath.row];
    
    

    //  NSLog(@"%@",Race_info.typeofrace);
   //  NSLog(@"%@",Race_info.date);
    
    //NSLog(@"%@",[NSString stringWithFormat:@"%@ %@",[DELEGATE convertDateToString:Race_info.date],shortnamedayofweekFromDate(Race_info.date)]);
    
    
    cell.lblDate.text =[NSString stringWithFormat:@"%@ %@",[DELEGATE convertDateToString:Race_info.date],shortnamedayofweekFromDate(Race_info.date)];
    
  
    [cell.lblStartTime setText:[NSString stringWithFormat:@"START %@",[DELEGATE convertDateToFullStringformat:Race_info.starttime]]];
    
    //NSLog(@"%@",Race_info.timelimit);
//    
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
  
    
    [cell.lblTimeLimit setText:[NSString stringWithFormat:@"Time Limit %@",str]];
    
    
       // array = [CoreDataUtils getObjects:[Race_master description] withQueryString:@"(starttime >= %@)" queryArguments:@[currentDate] sortBy:nil];
        
   // NSLog(@"%@",Race_info.identifier);

    
    NSArray *ary=[CoreDataUtils RelationgetObject:[Race_boat description] withQueryString:@"race_id = %d" queryArguments:@[Race_info.identifier] sortBy:nil];
    
    //NSLog(@"%@",ary);
    
    
    [cell.lblNoOfBoats setText:[NSString stringWithFormat:@"%d",(int)[ary count]]];
    
    [cell.lblClass setText:[NSString stringWithFormat:@"%@",Race_info.typeofrace]];
    
    
    cell.lblCity.text =[NSString stringWithFormat:@"%@",Race_info.location];
    cell.lblRaceName.text =[NSString stringWithFormat:@"%@",Race_info.name];
    
   

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedIndex = (int)indexPath.row;
    
    [self.myCustomAlertView setHidden:NO];
    
    
    strID=[NSString stringWithFormat:@"%@",[[arrRaceDetail valueForKey:@"identifier"] objectAtIndex:indexPath.row]];
    
    
    CGRect newFrame = self.myCustomAlertView.frame;
    newFrame.origin.y = 1500;
    self.myCustomAlertView.frame = newFrame;
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.myCustomAlertView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } completion:^(BOOL finished)
     {
         Race_info =[_arrUpComingRace objectAtIndex:indexPath.row];
         _lblRaceName.text =[NSString stringWithFormat:@"%@",Race_info.name];
     }];

    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    
    Race_info =[_arrUpComingRace objectAtIndex:indexPath.row];
    
    
   // NSLog(@"%@",Race_info.identifier);
    
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
    
    [_arrUpComingRace removeObjectAtIndex:indexPath.row];
    
    if ([_arrUpComingRace count]<=0)
    {
        
        UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(10,self.view.frame.size.height/2 -100, [UIScreen mainScreen].bounds.size.width-10, 200)];
        lbl.text =@"You don't have any upcoming races.";
        lbl.font =FONT_Regular(24);
        lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
        lbl.numberOfLines=0;
        lbl.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:lbl];
      
    }
    
    
    [_tblUpComingRace reloadData];
    
    
    
  
}

#pragma mark Button Actions
- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)btnGotoRaceClicked:(id)sender
{

   // NSLog(@"%@",[_arrUpComingRace objectAtIndex:SelectedIndex]);
    
    NSString *timeLimit = [[_arrUpComingRace objectAtIndex:SelectedIndex]valueForKey:@"timelimit"];
    
    NSString *strTime =[timeLimit stringByReplacingOccurrencesOfString:@"minute" withString:@""];
    
    NSDateComponents *comp1 = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:Race_info.starttime];
    
     NSDate *endTime = [Race_info.starttime dateByAddingTimeInterval:-comp1.second];
    
    double timelimit = [strTime intValue]*60;
    
    endTime = [endTime dateByAddingTimeInterval:timelimit];
    
    
    NSLog(@"%f",[endTime timeIntervalSince1970]);
    
     NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
    
  
    if ([endTime timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"541GO Race Officer" message:@"Race Already Completed" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else
    {
        RaceViewController *raceVC=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceViewController"];
        raceVC.strId=[NSString stringWithFormat:@"%@",strID];
        [self.navigationController pushViewController:raceVC animated:YES];
        
    }
  
    
}

- (IBAction)btnRaceDetailClicked:(id)sender
{
    
    NSString *timeLimit = [[_arrUpComingRace objectAtIndex:SelectedIndex]valueForKey:@"timelimit"];
    
    NSString *strTime =[timeLimit stringByReplacingOccurrencesOfString:@"minute" withString:@""];
    
    
    NSDate *endTime = [Race_info.starttime dateByAddingTimeInterval:[strTime intValue]*60];
    
    
    NSLog(@"%f",[endTime timeIntervalSince1970]);
    
    NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
    
    
    if ([endTime timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"541GO Race Officer" message:@"Race Already Completed" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else
    {

    
    RaceDetailsViewController *raceDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceDetailsViewController"];
    raceDetails.strID=[NSString stringWithFormat:@"%@",strID];
    [self.navigationController pushViewController:raceDetails animated:YES];
        
        
    }
}

- (IBAction)btnCancelClicked:(id)sender
{
    [self.myCustomAlertView setHidden:YES];
}


-(NSMutableArray *)convertToArray:(NSArray *)Data
{
    
    NSMutableArray *ConvertedData;
    
    ConvertedData=[[NSMutableArray alloc]init];
    
    for (int i=0;i<[Data count];i++)
    {
        
        NSArray *keys = [[[[Data objectAtIndex:i] entity] attributesByName] allKeys];
        NSDictionary *dict = [[Data objectAtIndex:i] dictionaryWithValuesForKeys:keys];
        
        [ConvertedData addObject:dict];
  
    }
    
    return ConvertedData;
    
}
@end
