//
//  NotificationViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationCustomCell.h"
#import "Race_master.h"
#import "Notification_master.h"
#import "Race_master.h"
#import "PopupView.h"

@interface NotificationViewController ()
{
    PopupView *Popup;
    
    NSString *raceid;
    
    int selectedIndex;
}

@end

@implementation NotificationViewController
{
    Race_master *Race_info;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedIndex =0;
    
    
    raceid=[[NSString alloc]init];
    
    _arrUpComingNotification =[[NSMutableArray alloc] init];
    
    NSArray *array =[[NSArray alloc] init];
  //  array = [CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(starttime <= %@) AND(notificationStatus = %@)" queryArguments:@[[NSDate date],@"0"] sortBy:nil];
    
    NSDate *date = [NSDate date];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond
                                                             fromDate:date];
    date = [date dateByAddingTimeInterval:-comp.second+300];
    NSLog(@"%@",date);
    NSLog(@"%@",[NSDate date]);
    NSLog(@"%@",Race_info.starttime);
    
    
    array = [CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(notificationStatus = %@)  AND (starttime <= %@) AND (starttime >= %@)" queryArguments:@[@"0",date,[NSDate date]] sortBy:nil];
    
   // array =[CoreDataUtils RelationgetObject:<#(NSString *)#> withQueryString:<#(NSString *)#> queryArguments:<#(NSArray *)#> sortBy:<#(NSDictionary *)#>]
    
    [_arrUpComingNotification addObjectsFromArray:array];
    NSLog(@"%@",array);
    
    if (array.count>0) {
         [_tblNotificationView reloadData];
    }
    else{
        
        UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(10,self.view.frame.size.height/2 -100, [UIScreen mainScreen].bounds.size.width-10, 200)];
        lbl.text =@"You don't have any notifications.";
        lbl.font =FONT_Regular(24);
        lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
        lbl.numberOfLines=0;
        lbl.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:lbl];
        
        
    }
    /// local Notification abrez
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark Tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _arrUpComingNotification.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NotificationCell";
    NotificationCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"NotificationCustomCell" owner:self options:nil];
        cell = (NotificationCustomCell *)[arrNib objectAtIndex:0];
    }
    [cell.imgDidSelectView setHidden:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
//    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
//    UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
    
    //cell.lblCity.text=@"Ahmedabad";
    //cell.lblDate.text=[NSString stringWithFormat:@"%@",[NSDate date]];
  //  cell.lblRaceName.text=@"New Race";
    
    
    

    Race_info =[_arrUpComingNotification objectAtIndex:indexPath.row];
    cell.lblDate.text =[NSString stringWithFormat:@"%@ %@",[DELEGATE convertDateToString:Race_info.date],shortnamedayofweekFromDate(Race_info.date)];
    cell.lblCity.text =[NSString stringWithFormat:@"%@",Race_info.location];
    cell.lblRaceName.text =[NSString stringWithFormat:@"%@",Race_info.name];
    
     cell.lblTime.text=[NSString stringWithFormat:@"%@",[DELEGATE convertDateTotime:Race_info.starttime]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedIndex = indexPath.row;
    
    
//    Notification_master *obj =[CoreDataUtils getObject:[Notification_master description]];
//    int number =[obj.badgecount intValue];
//    number=number-1;
//    obj.badgecount=[NSNumber numberWithInt:number];
//    [CoreDataUtils updateDatabase];
    
    
    Race_info =[_arrUpComingNotification objectAtIndex:indexPath.row];
    DELEGATE.COREIDENTIFIER=@"identifier";
    DELEGATE.QUERY_IDENTIFIER =@"identifier = %d";
    NSArray *array_data =[[NSArray alloc] init];
    array_data = [CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"identifier = %@" queryArguments:@[Race_info.identifier] sortBy:nil];
    NSMutableArray *arr =[[NSMutableArray alloc] initWithArray:array_data];
    
    for (int i=0; i<arr.count; i++)
    {
        Race_info =[arr objectAtIndex:i];
        Race_info.notificationStatus=@"1";
    }
    
    [CoreDataUtils updateDatabase];

    NSLog(@"%@",Race_info.date);
    NSLog(@"%@",Race_info.starttime);
    NSLog(@"%@",[NSDate date]);
    
    if ([Race_info.starttime timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"541GO Race Officer" message:@"Race Already Completed" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else{
    
        Popup=[[PopupView alloc] initWithNibName:@"PopupView" bundle:nil];
        
        Popup.view.frame=CGRectMake([UIScreen mainScreen].applicationFrame.origin.x, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+20);
        [Popup.btn_close addTarget:self action:@selector(touchup_close:) forControlEvents:UIControlEventTouchUpInside];
        
        Race_info =[_arrUpComingNotification objectAtIndex:indexPath.row];
        
        [Popup.lblRaceName setText:[NSString stringWithFormat:@"%@",Race_info.name]];
        
        raceid=[NSString stringWithFormat:@"%@",Race_info.identifier];
        
        [Popup.btn_gotorace addTarget:self action:@selector(Clickgotorace:) forControlEvents:UIControlEventTouchUpInside];
        
        [Popup.btn_racedetail addTarget:self action:@selector(Clickgotoracedetail:) forControlEvents:UIControlEventTouchUpInside];
        
        [DELEGATE.window addSubview:Popup.view];
    }

}

- (IBAction)Clickgotorace:(id)sender
{
 
    RaceViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceViewController"];
    
    obj.strId=[NSString stringWithFormat:@"%@",raceid];
    
    
     DELEGATE.backToHome=YES;
    
    
    for (UIView *view in DELEGATE.window.subviews)
    {
        
        if (view.tag == 50) {
            [view removeFromSuperview];
        }
        
    }
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
}




- (IBAction)Clickgotoracedetail:(id)sender
{

    RaceDetailsViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceDetailsViewController"];
    
    obj.strID=[NSString stringWithFormat:@"%@",raceid];
    
   
    DELEGATE.backToHome=YES;
    
    for (UIView *view in DELEGATE.window.subviews)
    {
        
        if (view.tag == 50) {
            [view removeFromSuperview];
        }
        
    }
    
    [self.navigationController pushViewController:obj animated:YES];
    

  
}

-(IBAction)touchup_close:(id)sender
{
  
    for (UIView *view in DELEGATE.window.subviews)
    {
        
        if (view.tag == 50) {
            [view removeFromSuperview];
        }
        
    }
    
    
}



- (void)reloadTable
{
    [self.tblNotificationView reloadData];
}


- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
