//
//  AddBoatsViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 06/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "AddBoatsViewController.h"
#import "AddBoatsCustomCell.h"
#import "RaceViewController.h"
#import "ViewController.h"

#import "Boat_master.h"
#import "Race_boat.h"
#import "Race_master.h"


@interface AddBoatsViewController ()
{
    int boatNumber;
}

@end

@implementation AddBoatsViewController
{
    NSMutableArray *copyListBoatArray;
    NSMutableArray *copyListArray;
    NSMutableDictionary *dictTemp;
    NSMutableDictionary *Dictmain;
    NSMutableArray *arrUser;
    BOOL isSearching;
    BOOL isSearchBar;
    Boat_master *boat_info;
    Race_boat *raceboat_info;
    Race_master *race_info;
}
//#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    boatNumber=0;
    
    
    CGRect newFrame = self.viewAlert.frame;
    newFrame.origin.y = 1500;
    self.viewAlert.frame = newFrame;
    
    UITapGestureRecognizer *TapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taprecognized)];
    TapRecognizer.numberOfTapsRequired = 1;
    
    TapRecognizer.delegate=self;
    [TapRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:TapRecognizer];
    
    //// Dummy Data for Expandable tableview //////
    
    _arrAddFromExisting =[[NSMutableArray alloc]init];
    Dictmain=[[NSMutableDictionary alloc]init];
    dictTemp=[[NSMutableDictionary alloc]init];
    arrUser=[[NSMutableArray alloc]init];
    
    _arrBoat =[[NSMutableArray alloc] init];
    _arrBoatList =[[NSMutableArray alloc] init];
    
    ////////// Dummy data for table one ////////////
    
    NSLog(@"%@",_raceid);
    
  //  _arrBoatList=[[NSMutableArray alloc]initWithObjects:@"One",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine",@"ten", nil];
    
    
   // race_info.id = [CoreDataUtils getObjects:[Race_master description] withQueryString:@"(starttime <= %@)" queryArguments:@[[NSDate date]] sortBy:nil];

    
//    DELEGATE.COREIDENTIFIER=@"identifier";
//    DELEGATE.QUERY_IDENTIFIER =@"identifier = %d";
//
//    
//    NSLog(@"%@",_raceid);
//    int jk;
//    jk=2;
//    NSArray *array =[[NSArray alloc]init];
//    _arrBoatList=[[NSMutableArray alloc] init];
//  //  array =[CoreDataUtils getObjects:[Race_boat description]];
// //   array =[CoreDataUtils getObject:[Race_boat description] withQueryString:@"" queryArguments:@[@""] sortBy:nil];
//    
//    array =[CoreDataUtils RelationgetObject:[Race_boat description] withQueryString:@"(race_id = %@)" queryArguments:@[_raceid] sortBy:nil];
//    _arrBoatList =[[NSMutableArray alloc] initWithArray:array];
//    NSLog(@"%@",array);
//   // NSLog(@"%@",[array objectAtIndex:0]);
//    
//    
//    NSLog(@"%@",_arrBoatList);
//    
//    
//   // _arrBoatList =[DELEGATE convertToArray:array];
//    
//     NSLog(@"%@",_arrBoatList);
//    
//    for (raceboat_info in _arrBoatList) {
//        
//         boat_info  = raceboat_info.addboatmaster;
//        NSLog(@"%@",raceboat_info.addboatmaster);
//        NSLog(@"Zip: %@", boat_info.name);
//    }
//    
//    for(raceboat_info in _arrBoatList) {
//
//        race_info =raceboat_info.addracemaster;
//        NSLog(@"%@",race_info);
//        break;
//    }
    
//    NSError *error;
//    NSManagedObjectContext *context = [[CoreDataUtils shared] managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Race_boat" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    for (raceboat_info in fetchedObjects) {
//        NSLog(@"Name: %@", raceboat_info.race_id);
//        
//       boat_info = raceboat_info.addboatmaster;
//      
//    }
    
    

    
    
    [_tblAddRaceView reloadData];

    [_AddNewBoatCustomView setHidden:YES];
    [_AddExistingBoatView setHidden:YES];
    [_scrollAddNewBoatsView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+10)];
    
    [_scrollAddFromExisting setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [_imgSearchBackGround.layer setCornerRadius:5.0f];
    [_imgSearchBackGround.layer setMasksToBounds:YES];
    [_imgSearchBarAddExisting.layer setCornerRadius:5.0f];
    [_imgSearchBarAddExisting.layer setMasksToBounds:YES];
    
    
    isSelect= NO;
    
    
}



#pragma mark UIGestureRecognizerDelegate methods



-(void)taprecognized
{
    
   // [self.view endEditing:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     _tblAddRaceView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tblAddExistingView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    CGRect newFrame = self.AddBoatsView.frame;
    newFrame.origin.y = 1500;
    self.AddBoatsView.frame = newFrame;
}



#pragma mark UIgetsterRecognizer

- (void) handleTapFrom:(UITapGestureRecognizer *)recognizer
{
    if (taptag==recognizer.view.tag) {
        
        if (expand==0) {
            expand=1;
        }
        else
        {
            expand=0;
        }
    }
    else
    {
        expand=1;
    }
    
    taptag=(int)recognizer.view.tag;
    [self.tblAddExistingView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//// Custom Expandable TableView

#pragma mark tableview Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    ///tableview 1
    
    if (tableView.tag==100)
    {
        return 0;
    }
    
    ///tableview 2
    
    else if(tableView.tag==200)
    {
        return 50.0;
    }
    else
    {
        return 44.0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ///tableview 1
    
    if (tableView.tag==100)
    {
        return NO;
    }
    
    ///tableview 2
    
    else if(tableView.tag==200)
    {
        
        
        if (isSearchBar) {
            
            
            UIView *headerView = [[UIView alloc]
                                  initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 50)];
            
            [headerView setBackgroundColor:[UIColor whiteColor]];
            UILabel *title =[[UILabel alloc] init];
            [title setFrame:CGRectMake(20,10,200, 30)];
            [title setTextColor:[UIColor blackColor]];
            title.font=FONT_Regular(14);
            [headerView addSubview:title];
            
            
            //seperator between two header
            
            UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15,49, [UIScreen mainScreen].bounds.size.width, 0.7)];
            separatorLineView.backgroundColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:0.5];
            
            // may be here is clearColor;
            [headerView addSubview:separatorLineView];
            
            [title setText:[[copyListBoatArray objectAtIndex:section] valueForKey:@"Group"]];
            UIImageView *imgAdd=[[UIImageView alloc]init];
            
            
            imgAdd.frame = CGRectMake(self.view.frame.size.width-35, 17,15,15);
            
            [imgAdd setImage:[UIImage imageNamed:@"imgRectangleAddGray"]];
            
            ///// button in header
            
            [headerView addSubview:imgAdd];
            if([copyListBoatArray count]>0)
            {
                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
                tapGestureRecognizer.delegate=self;
                headerView.tag=section;
                [headerView addGestureRecognizer:tapGestureRecognizer];
            }
            
            return headerView;


        }
        else{
        
            UIView *headerView = [[UIView alloc]
                                  initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 50)];
            
            [headerView setBackgroundColor:[UIColor whiteColor]];
            UILabel *title =[[UILabel alloc] init];
            [title setFrame:CGRectMake(20,10,200, 30)];
            [title setTextColor:[UIColor blackColor]];
            title.font=FONT_Regular(14);
            [headerView addSubview:title];
            
            
            //seperator between two header
            
            UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15,49, [UIScreen mainScreen].bounds.size.width, 0.7)];
            separatorLineView.backgroundColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:0.5];
            
            
            // may be here is clearColor;
            [headerView addSubview:separatorLineView];
            
            [title setText:[[_arrAddFromExisting objectAtIndex:section] valueForKey:@"Group"]];
            UIImageView *imgAdd=[[UIImageView alloc]init];
            
            
            imgAdd.frame = CGRectMake(self.view.frame.size.width-35, 17,15,15);
            
            [imgAdd setImage:[UIImage imageNamed:@"imgRectangleAddGray"]];
            
            ///// button in header
            
            [headerView addSubview:imgAdd];
            if([_arrAddFromExisting count]>0)
            {
                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
                tapGestureRecognizer.delegate=self;
                headerView.tag=section;
                [headerView addGestureRecognizer:tapGestureRecognizer];
            }
            
            return headerView;
        
        }
        /// For Expanding the cell
        

    }
    else
    {
        return NO;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if (tableView.tag==100)
    {
        return 1;
    }
    else if(tableView.tag==200)
    {
        if (isSearchBar) {
            return copyListBoatArray.count;
        }
        else{
            return _arrAddFromExisting.count;
        }
    }
    else{
        return 0;
    }
    
}


#pragma mark Tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    ///tableview 1
    
    if (tableView.tag==100)
    {
        if (isSearching)
        {
            return [copyListArray count];
        }
        else
        {
            NSLog(@"%lu",(unsigned long)_arrBoatList.count);
            return [_arrBoatList count];
        }
        
    }
    
    ///tableview 2
    
    else if(tableView.tag==200)
    {
        if (isSearchBar)
        {
            NSLog(@"%@",copyListBoatArray);
            if(taptag>-1)
            {
                if(taptag==section)
                {
                    if (expand==1) {
                        
                        NSLog(@"%lu",(unsigned long)[[[copyListBoatArray objectAtIndex:section] valueForKey:@"User"] count]);
                       // return [[[_arrAddFromExisting objectAtIndex:section] valueForKey:@"User"] count];
                        //return copyListBoatArray.count;
                    }
                    else
                    {
                        return 0;
                    }
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
            
           // return copyListBoatArray.count;
        }
        else
        {
            NSLog(@"%@",_arrAddFromExisting);
            if(taptag>-1)
            {
                if(taptag==section)
                {
                    if (expand==1) {
                        
                        NSLog(@"%lu",(unsigned long)[[[_arrAddFromExisting objectAtIndex:section] valueForKey:@"User"] count]);
                        return [[[_arrAddFromExisting objectAtIndex:section] valueForKey:@"User"] count];
                    }
                    else
                    {
                        return 0;
                    }
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }
    }
    return YES;
}


////////////////////////////////////////////////////////////////////////////////////////



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AddBoatsCustomCell";
    AddBoatsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"AddBoatsCustomCell" owner:self options:nil];
        cell = (AddBoatsCustomCell *)[arrNib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    ///tableview 1
    
    if (tableView.tag==100)
    {
        if (isSearching)
        {
            NSLog(@"%@",copyListArray);
            cell.lblNo.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
            cell.lblBoatName.text=[NSString stringWithFormat:@"%@",[copyListArray objectAtIndex:indexPath.row]];
        }
        else
        {
            //boat_info =[_arrBoatList objectAtIndex:indexPath.row];
            NSLog(@"%@",_arrBoatList);
            cell.lblNo.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
            //cell.lblBoatName.text=[NSString stringWithFormat:@"%@",boat_info.sailno];
            cell.lblBoatName.text=[NSString stringWithFormat:@"%@",[[_arrBoatList objectAtIndex:indexPath.row]valueForKey:@"sailno" ]];
            
        }
    }
    
    ///tableview 2
    
    else if (tableView.tag==200)
    {
        if (isSearchBar)
        {
            //cell.lblBoatName.text=[NSString stringWithFormat:@"%@",[copyListBoatArray objectAtIndex:indexPath.row]];
            
            cell.lblBoatName.text=[NSString stringWithFormat:@"    %@",[[[[copyListBoatArray objectAtIndex:indexPath.section] valueForKey:@"User"] objectAtIndex:indexPath.row]  valueForKey:@"user_name"]];
            
            
            for (UIButton* btn in cell.subviews)
            {
                if ([btn.accessibilityIdentifier isEqualToString:@"btnselect"])
                {
                    [btn removeFromSuperview];
                }
            }
            [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-Button"]];
            
            
            
            NSString *strIsSelected=[NSString stringWithFormat:@"%@",[[[[copyListBoatArray objectAtIndex:indexPath.section] valueForKey:@"User"]objectAtIndex:indexPath.row] valueForKey:@"isSelected"]];
            
            
            
            if([strIsSelected isEqualToString:@"Y"])
            {
                [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-ButtonSelected"]];
                
            }
            else
            {
                [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-Button"]];
                
            }

        }
        else
        {
            
            cell.lblBoatName.text=[NSString stringWithFormat:@"    %@",[[[[_arrAddFromExisting objectAtIndex:indexPath.section] valueForKey:@"User"] objectAtIndex:indexPath.row]  valueForKey:@"user_name"]];
            
            
            for (UIButton* btn in cell.subviews)
            {
                if ([btn.accessibilityIdentifier isEqualToString:@"btnselect"])
                {
                    [btn removeFromSuperview];
                }
            }
            [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-Button"]];
            
            
            
            NSString *strIsSelected=[NSString stringWithFormat:@"%@",[[[[_arrAddFromExisting objectAtIndex:indexPath.section] valueForKey:@"User"]objectAtIndex:indexPath.row] valueForKey:@"isSelected"]];
            
            
            
            if([strIsSelected isEqualToString:@"Y"])
            {
                [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-ButtonSelected"]];
                
            }
            else
            {
                [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-Button"]];
                
            }

                       /// Button in sub section
            //return cell;
            
        }
    }
    
  
    return cell;
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"reaching accessoryButtonTappedForRowWithIndexPath:");
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==200) {
        
        AddBoatsCustomCell *cell = (AddBoatsCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        //// For selecting
        
        NSString *strIsSelected=[NSString stringWithFormat:@"%@",[[[[_arrAddFromExisting objectAtIndex:indexPath.section] valueForKey:@"User"]objectAtIndex:indexPath.row] valueForKey:@"isSelected"]];
        
//        NSLog(@"%@",_arrAddFromExisting);
//        NSLog(@"%ld",(long)indexPath.section);
//        NSLog(@"%@",[[_arrAddFromExisting objectAtIndex:indexPath.section] valueForKey:@"User"]);
//        NSLog(@"%@",[[[[_arrAddFromExisting objectAtIndex:indexPath.section] valueForKey:@"User"]objectAtIndex:indexPath.section] valueForKey:@"isSelected"]);
//        NSLog(@"%@",[[[[_arrAddFromExisting objectAtIndex:indexPath.section] valueForKey:@"User"]objectAtIndex:indexPath.section] valueForKey:@"isSelected"]);
        
        if([strIsSelected isEqualToString:@"N"])
        {
            [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-ButtonSelected"]];
            
            [self changeStatus:@"Y" atIndex:indexPath.section innerIndex:indexPath.row] ;
        }
        else
        {
            [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-Button"]];
            
            [self changeStatus:@"N" atIndex:indexPath.section innerIndex:indexPath.row];
        }

    }
    
 }
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50.0;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AddBoatsCustomCell *cell = (AddBoatsCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
//    
//    
//    //// For Deselecting
//    
//    NSString *strIsSelected=[NSString stringWithFormat:@"%@",[[[[_arrAddFromExisting objectAtIndex:indexPath.section] valueForKey:@"User"]objectAtIndex:indexPath.row] valueForKey:@"isSelected"]];
//    if([strIsSelected isEqualToString:@"Y"])
//    {
//        
//        [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-Button"]];
//        [self changeStatus:@"N" atIndex:indexPath.section innerIndex:indexPath.row];
//    }
//    else
//    {
//        [cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-ButtonSelected"]];
//        [self changeStatus:@"Y" atIndex:indexPath.section innerIndex:indexPath.row];
//    }
//}


#pragma mark Button back
- (IBAction)btnBackClicked:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Button Done
- (IBAction)btnDoneClicked:(id)sender
{
    [self.view endEditing:YES];
    [_txtSearch endEditing:YES];
    [_tblAddRaceView reloadData];

    //// button done event
    if ([_arrBoatList count]==0)
    {
        [CustomAlertsCX ShowAlert:@"Please add boats"];
    }
    else
    {
//        RaceViewController *raceView=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceViewController"];
//        raceView.strId=[NSString stringWithFormat:@"%@",_raceid];
//        [self.navigationController pushViewController:raceView animated:YES];
        
        
        BOOL tap = NO;
        
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[ViewController class]])
            {
                tap=YES;
                //[self.navigationController popToViewController:controller animated:YES];
                
                //UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Race Control" message:@"Where would you like to go?" cancelButtonTitle:@"Back to Home" otherButtonTitles:@"Race Detail", nil];
                
                //******* added boats are greater than 1 schedule notification for race
                
                if (boatNumber>0)
                {
                    
                    NSArray *race=[CoreDataUtils getObjects:[Race_master description] withQueryString:@"identifier = %@" queryArguments:@[_raceid] sortBy:nil];
                    
                    
                    for (int i=0;i<[race count];i++)
                    {
                        race_info=[race objectAtIndex:i];
                        
                        race_info.isboatadded=@"Y";
                        
                        NSDate *dateschedule = [self MergeTwoDates:race_info.date date2:race_info.starttime];
                        NSDateComponents *compschedule = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:dateschedule];
                        dateschedule = [dateschedule dateByAddingTimeInterval:-compschedule.second];
                        NSLog(@"%@",dateschedule);
                        
                        
                        //******* now when first boat is added schedule Notification for race
                        
                        //*********** Schedule notification
                        
                        
                        
                        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                        localNotification.fireDate = [dateschedule dateByAddingTimeInterval:-11];//[NSDate dateWithTimeIntervalSinceNow:60];
                        localNotification.alertAction=@"This is Local";
                        // localNotification.alertBody = [NSString stringWithFormat:@"Today you have new race at %@",[DELEGATE convertDateTotime:Race_info.starttime]];
                        
                        localNotification.alertBody = [NSString stringWithFormat:@"%@ Race start",race_info.name];
                        localNotification.timeZone = [NSTimeZone defaultTimeZone];
                        localNotification.soundName = @"sound1.mp3";
                        // localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
                        
                        NSMutableDictionary *infoDict =[[NSMutableDictionary alloc]init];
                        [infoDict setObject:race_info.identifier forKey:@"raceid"];
                        [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
                        [infoDict setObject:race_info.name forKey:@"racename"];
                        [infoDict setObject:@"10" forKey:@"istime"];
                        localNotification.userInfo = infoDict;
                        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                        
                        
                        
                        NSDate *datetime = race_info.starttime;
                        
                        datetime = [datetime dateByAddingTimeInterval:-59];
                        NSLog(@"%@",datetime);
                        
                        for (int i=5;i>=1;i--)
                        {
                            
                            NSDate *Alertnotification = [dateschedule dateByAddingTimeInterval:-60*i];
                            
                            NSDateComponents *compsch = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond
                                                                                        fromDate:[NSDate date]];
                            NSDate *datetimeinfo = [[NSDate date] dateByAddingTimeInterval:-compsch.second-60];
                            
                            
                            NSLog(@"%@",[NSDate date]);
                            NSLog(@"%@",datetimeinfo);
                            NSLog(@"%@",Alertnotification);
                            
                            if ([Alertnotification compare:datetimeinfo] == NSOrderedDescending) {
                                NSLog(@"currentdate is later than getDate");
                                
                                
                                // if ([Alertnotification laterDate:[NSDate date]]) {
                                
                                
                                
                                //localNotification.soundName = UILocalNotificationDefaultSoundName;
                                
                                if (i == 2 || i == 3) {
                                    
                                    // localNotification.soundName = @"";
                                }
                                else{
                                    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                                    
                                    if (i==1) {
                                        
                                        
                                      //  localNotification.fireDate = [Alertnotification dateByAddingTimeInterval:-10];
                                        
                                      //  localNotification.soundName = @"ShortBeep.mp3";
                                    }
                                    
                                    localNotification.fireDate = [Alertnotification dateByAddingTimeInterval:0];//[NSDate dateWithTimeIntervalSinceNow:60];
                                    localNotification.alertAction=@"This is Local";
                                    //localNotification.alertBody = [NSString stringWithFormat:@"Today you have new race at %@",[DELEGATE convertDateTotime:Race_info.starttime]];
                                    localNotification.alertBody = [NSString stringWithFormat:@"%@ will start in %d mins",race_info.name,i];
                                    
                                    
                                    if (i ==5) {
                                        
                                        localNotification.soundName = @"ShortBeep.mp3";
                                    }
                                    else if (i==4)
                                        
                                    {
                                     localNotification.soundName = @"ShortBeep.mp3";
                                    }
                                    else if (i==1)
                                    {
                                        localNotification.soundName = @"ShortBeep.mp3";
                                    }
                                    
                                    
                                    localNotification.timeZone = [NSTimeZone defaultTimeZone];
                                    // localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
                                    
                                    NSMutableDictionary *infoDict =[[NSMutableDictionary alloc]init];
                                    [infoDict setObject:race_info.identifier forKey:@"raceid"];
                                    [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
                                    [infoDict setObject:race_info.name forKey:@"racename"];
                                    [infoDict setObject:[NSString stringWithFormat:@"%d",i] forKey:@"notificationno"];
                                    localNotification.userInfo = infoDict;
                                    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                                }
                                
                                
                            }
                            
                            
                            
                            
                            
                        }
                        
                        
                        [CoreDataUtils updateDatabase];
                        
                    }
                    
                    
                    
                }
                
          
                
                [self.viewAlert setHidden:NO];
                
                CGRect newFrame = self.viewAlert.frame;
                newFrame.origin.y = 1500;
                self.viewAlert.frame = newFrame;
                
                [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.viewAlert.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                } completion:^(BOOL finished)
                 {
                     
                 }];
                
                break;
            }
        }
        
        if (!tap)
        {
            ViewController *addBoatscontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"AddBoatsViewController"];
            [self.navigationController pushViewController:addBoatscontroller animated:YES];
        }
    }
}

#pragma mark Button Add Boats
- (IBAction)btnAddBoatsClicked:(id)sender
{
    
    [self.view endEditing:YES];
    //For Animating a custom add boat view
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.AddBoatsView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
    } completion:^(BOOL finished)
     {}];
    
   // [_AddNewBoatCustomView setHidden:NO];
    [_AddExistingBoatView setHidden:YES];
    [_AddBoatsView setHidden:NO];
    [_AddCustomAddBoatsView setHidden:NO];
    [_txtSearch endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
    
    
    
}

#pragma mark textfield delegate
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_txtBoatName isFirstResponder])
    {
        [_txtSailNo becomeFirstResponder];
    }
    else if ([_txtSailNo isFirstResponder])
    {
         [_txtSkipperName becomeFirstResponder];
    }
    else if ([_txtSkipperName isFirstResponder])
    {
        [_txtClass becomeFirstResponder];
    }
    else if ([_txtClass isFirstResponder])
    {
        [_txtBowNo becomeFirstResponder];
    }
    else if ([_txtBowNo isFirstResponder])
    {
        [_txtBowNo resignFirstResponder];
    }
    else if ([_txtSearch isFirstResponder])
    {
         [_txtSearch resignFirstResponder];
        
    }

    return YES;
}


- (IBAction)SearchBarChnage:(UITextField *)sender
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    sender.text = [sender.text stringByTrimmingCharactersInSet:whitespace];
    
    //remove allobjects from array
    [copyListArray removeAllObjects];
    
    if([sender.text length] > 0) {
        
        //call this method
        [self searchTableView];
        
    }
    else
    {
        isSearching=NO;
    }
    [_tblAddRaceView reloadData];
}


#pragma mark Search bar sorting
-(void)searchTableView
{
    
    isSearching = YES;
    NSString *searchtext = _txtSearch.text;
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    [searchArray addObjectsFromArray:[_arrBoatList valueForKey:@"sailno"]];
    
    for (NSString *sTemp in searchArray)
    {
        NSRange titleResultsRange = [sTemp rangeOfString:searchtext options:NSCaseInsensitiveSearch];
        
        if (titleResultsRange.length > 0){
            if (copyListArray==nil) {
                copyListArray=[[NSMutableArray alloc]initWithObjects:sTemp, nil];
            }
            else{
                [copyListArray addObject:sTemp];
            }
        }
    }
    
    searchArray = nil;
}


////////////// Custom Add Boats View ////////////////////
#pragma mark CUSTOM ADD BOATS



#pragma mark add new boats
- (IBAction)btnAddNewBoatClicked:(id)sender
{
    _txtBoatName.text=@"";
    _txtSailNo.text=@"";
    _txtSkipperName.text=@"";
    _txtClass.text=@"";
    _txtBowNo.text=@"";
    
    
    [self.view endEditing:YES];
    [self.AddNewBoatCustomView setHidden:NO];
    [self.AddCustomAddBoatsView setHidden:YES];
}


#pragma mark chose from existing
- (IBAction)btnAddFromExistingClicked:(id)sender
{
    [self.AddExistingBoatView setHidden:NO];
    [self.AddCustomAddBoatsView setHidden:YES];
    [copyListArray removeAllObjects];
    [copyListBoatArray removeAllObjects];
  
    NSArray *array =[[NSArray alloc]init];
    NSMutableArray *arrBoatList=[[NSMutableArray alloc] init];
    array =[CoreDataUtils getObjects:[Boat_master description]];
    
    [arrBoatList addObjectsFromArray:array];
    NSLog(@"%@",arrBoatList);
    
    NSManagedObjectContext *context = [[CoreDataUtils shared] managedObjectContext];
    
    NSFetchRequest* uniqueKeysFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Boat_master"];
    
    uniqueKeysFetchRequest.propertiesToFetch = @[@"classname"];
    uniqueKeysFetchRequest.resultType = NSDictionaryResultType;
    uniqueKeysFetchRequest.returnsDistinctResults = YES;
    
    NSError* error = nil;
    NSArray *results = [context executeFetchRequest:uniqueKeysFetchRequest
                                              error:&error];
    NSLog(@"uniqueKeysFetchRequest: %@", results);
    
    NSLog(@"distinct values for \"key\": %@", [results valueForKeyPath:@"@distinctUnionOfObjects.classname"]);
    
    //NSMutableArray *arrMain_group=[[NSMutableArray alloc]initWithArray:results];
    _arrAddFromExisting=[[NSMutableArray alloc]init];
    NSMutableArray *finaldetailarray=[[NSMutableArray alloc]init];
    
    for (NSString *thisKey in [results valueForKey:@"classname"]) {
        NSFetchRequest *oneKeyFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Boat_master"];
        NSString *predicateString = [NSString stringWithFormat:@"classname LIKE '%@'", thisKey];
        oneKeyFetchRequest.predicate = [NSPredicate predicateWithFormat:predicateString];
        oneKeyFetchRequest.resultType = NSDictionaryResultType;
        oneKeyFetchRequest.propertiesToFetch = @[@"sailno",@"identifier"];
        NSLog(@"%@: %@", thisKey, [context executeFetchRequest:oneKeyFetchRequest error:&error]);
        
        NSArray *arr_detail =[context executeFetchRequest:oneKeyFetchRequest error:&error];
        finaldetailarray =[[NSMutableArray alloc] init];
        
        for(int j=0;j<[arr_detail count];j++)
        {
            
            NSMutableDictionary *dict_detail=[[NSMutableDictionary alloc]init];
            
            //[dict_detail setObject:[[arrdetail_group valueForKey:@""]objectAtIndex:i] forKey:@"user_name"];
            [dict_detail setObject:[[arr_detail objectAtIndex:j] valueForKey:@"sailno"] forKey:@"user_name"];
            [dict_detail setObject:[[arr_detail objectAtIndex:j] valueForKey:@"identifier"] forKey:@"boatid"];
            [dict_detail setObject:@"N" forKey:@"isSelected"];
            [finaldetailarray addObject:dict_detail];
            NSLog(@"%@",finaldetailarray);
            
        }
        NSLog(@"%@",_arrAddFromExisting);
        NSMutableDictionary *dict_temp=[[NSMutableDictionary alloc]init];
        //[dict_temp setObject:@"N" forKey:@"isgroupselected"];
        [dict_temp setObject:thisKey forKey:@"Group"];
        [dict_temp setObject:finaldetailarray forKey:@"User"];
        
        
        [_arrAddFromExisting addObject:dict_temp];
        NSLog(@"%@",_arrAddFromExisting);
    }
    NSLog(@"%@",_arrAddFromExisting);

    [_tblAddExistingView reloadData];
}

- (IBAction)btnBackFromCustomViewClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCloseFromCustomView:(id)sender
{
    
    CGRect newFrame = self.AddBoatsView.frame;
    newFrame.origin.y = 1500;
    self.AddBoatsView.frame = newFrame;
    
}



/////////////////////  Custom Add New Boats ///////////////////////
#pragma mark CUSTOM ADD NEW BOATS


- (IBAction)btnAddNewBoatsDoneClicked:(id)sender
{
    [self.view endEditing:YES];
    [self Validator];
    
    
    
}

- (IBAction)btnAddNewBoatBackClicked:(id)sender
{
    [self.view endEditing:YES];
    [self.AddNewBoatCustomView setHidden:YES];
    [self.AddCustomAddBoatsView setHidden:NO];
}




#pragma mark CUSTOM VIEW ADD EXISTING

- (IBAction)btnExistingBackClicked:(id)sender
{
    [self.view endEditing:YES];
    [self.AddExistingBoatView setHidden:YES];
    [self.AddCustomAddBoatsView setHidden:NO];
}


- (IBAction)btnExistingDoneClicked:(id)sender
{
    NSLog(@"%@",_arrAddFromExisting);

    for (int i=0; i<_arrAddFromExisting.count; i++)
    {
        
        
        for (int j=0; j<[[[_arrAddFromExisting objectAtIndex:i]valueForKey:@"User"] count]; j++)
        {
            
            if ([[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"isSelected"] isEqualToString:@"Y"])
            {
                
                
                boatNumber++;
                
                NSString *strboatid=[NSString stringWithFormat:@"%@",[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"boatid"]];
                
                NSString *strsailno=[NSString stringWithFormat:@"%@",[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"user_name"]];
                
                NSLog(@"%@",strsailno);
                NSLog(@"%@",_arrBoatList);
                if (![[_arrBoatList valueForKey:@"sailno"] containsObject:strsailno]){
                    
                    NSLog(@"true");
                    NSArray *ary =[[NSArray alloc] init];
                    ary =[CoreDataUtils RelationgetObject:[Boat_master description] withQueryString:@"(identifier = %@)" queryArguments:@[strboatid] sortBy:nil];
                    
                    boat_info =[ary objectAtIndex:0];
                    
                    raceboat_info = [Race_boat newInsertedObject];
                    raceboat_info.identifier = @([CoreDataUtils getNextID:[Race_boat description]]);
                    raceboat_info.boat_id =[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"boatid"];
                    NSLog(@"%@",_raceid);
                    raceboat_info.race_id =_raceid;
                    raceboat_info.addboatmaster = boat_info;
                    [CoreDataUtils updateDatabase];
                    
                    NSMutableDictionary *dict_detail=[[NSMutableDictionary alloc]init];
                    [dict_detail setObject:[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"user_name"] forKey:@"sailno"];
                    [_arrBoatList addObject:dict_detail];
                }
                


            
            }
            
        }
        
    }
    
    
    [self.view endEditing:YES];
    [self.AddExistingBoatView setHidden:YES];
    [self.AddCustomAddBoatsView setHidden:NO];
    [_tblAddRaceView reloadData];
    
    
//    DELEGATE.COREIDENTIFIER=@"identifier";
//    DELEGATE.QUERY_IDENTIFIER =@"identifier = %d";
//
//    raceboat_info.addboatmaster = boat_info;
//    boat_info.addboat=raceboat_info;
//    
//    [CoreDataUtils updateDatabase];
//    
//    NSArray *array =[[NSArray alloc] init];
//    array =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"identifier =%@" queryArguments:@[_raceid] sortBy:nil];
//    
//    NSLog(@"%@",array);
//    
//    race_info=[array objectAtIndex:0];
//    
//    raceboat_info.addracemaster=race_info;
//    race_info.addrace=raceboat_info;
//    
//    
//    [CoreDataUtils updateDatabase];
    

    /// Addboat custom view frame to normal
    CGRect newFrame = self.AddBoatsView.frame;
    newFrame.origin.y = 1500;
    self.AddBoatsView.frame = newFrame;
    
    
    
}


#pragma mark Add from existing search bar

- (IBAction)customViewSearchBar:(UITextField *)sender
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    sender.text = [sender.text stringByTrimmingCharactersInSet:whitespace];
    
    //remove allobjects from array
    [copyListBoatArray removeAllObjects];
    
    if([sender.text length] > 0) {
        
        //call this method
        [self searchbarTableView];
        
    }
    else
    {
        isSearchBar=NO;
    }
    [_tblAddExistingView reloadData];
}


#pragma mark add from existing Search bar sorting
-(void)searchbarTableView
{
    
    isSearchBar = YES;
    NSString *searchtext = _txtAddExisting.text;
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    NSLog(@"%@",_arrAddFromExisting);
   // [searchArray addObjectsFromArray:[_arrAddFromExisting valueForKey:@"Group"]];
     [searchArray addObjectsFromArray:_arrAddFromExisting];
    NSLog(@"%lu",(unsigned long)searchArray.count);
    
//    for (NSString *sTemp in [searchArray valueForKey:@"Group"])
//    {
//        NSRange titleResultsRange = [sTemp rangeOfString:searchtext options:NSCaseInsensitiveSearch];
//        
//        if (titleResultsRange.length > 0)
//        {
//            if (copyListBoatArray==nil) {
//                copyListBoatArray=[[NSMutableArray alloc]initWithObjects:sTemp, nil];
//            }
//            else
//            {
//                [copyListBoatArray addObject:sTemp];
//                
//            }
//        }
//    }
    
    for (int i=0; i<[_arrAddFromExisting count]; i++) {
        
        NSString *sTemp =[NSString stringWithFormat:@"%@",[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"Group"]];
        NSRange titleResultsRange = [sTemp rangeOfString:searchtext options:NSCaseInsensitiveSearch];
        
        if (titleResultsRange.length > 0)
        {
            if (copyListBoatArray==nil) {
                copyListBoatArray=[[NSMutableArray alloc]initWithObjects:[_arrAddFromExisting objectAtIndex:i], nil];
            }
            else
            {
                [copyListBoatArray addObject:[_arrAddFromExisting objectAtIndex:i]];
                
            }
        }
    }
    NSLog(@"%@",copyListBoatArray);
    searchArray = nil;
}

-(NSDate *)MergeTwoDates:(NSDate *)date1 date2:(NSDate *)date2{
    
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:date1];
    NSDate *date3 = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:date2];
    date3 = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:date3 options:0];
    
    NSLog(@"%@",date3);
    return date3;
}

#pragma mark add from existing validator
-(void)Validator
{
    NSString *strName= [self.txtBoatName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strSailNo= [self.txtSailNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strSkipper= [self.txtSkipperName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strClass= [self.txtClass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strBowNo= [self.txtBowNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //******** check here for existing class name
    
//  NSArray *class= [CoreDataUtils getObjects:[Boat_master description] withQueryString:@"classname = %@" queryArguments:@[strClass] sortBy:nil];
//   // NSLog(@"%@",[DELEGATE convertToArray:class]);
//    
//    
//    if (class.count>0)
//    {
//
//        [CustomAlertsCX ShowAlert:@"class already exists."];
//        [_txtClass becomeFirstResponder];
//        return;
//      
//    }

    //  [self.AddBoatsView setHidden:NO];
    [self.AddCustomAddBoatsView setHidden:NO];
    
    if ([Validate isEmpty:strName])
    {
        [CustomAlertsCX ShowAlert:@"Please enter boat name"];
    }
    else if ([Validate isEmpty:strSailNo])
    {
        [CustomAlertsCX ShowAlert:@"Please enter sail no"];
    }
    else if ([Validate isEmpty:strSkipper])
    {
        [CustomAlertsCX ShowAlert:@"Please enter Skipper name"];
    }
    else if ([Validate isEmpty:strClass])
    {
        [CustomAlertsCX ShowAlert:@"Please enter class"];
    }
//    else if ([Validate isEmpty:strBowNo])
//    {
//        [CustomAlertsCX ShowAlert:@"Please enter bow no"];
//    }
    else
    {
        //// now adding details in array
      
        DELEGATE.COREIDENTIFIER=@"identifier";
        DELEGATE.QUERY_IDENTIFIER =@"identifier = %d";
        
        NSArray *checkuniqueboat =[[NSArray alloc] init];
        checkuniqueboat =[CoreDataUtils RelationgetObject:[Boat_master description]withQueryString:@"(classname =%@) AND (sailno = %@)" queryArguments:@[[DELEGATE trimWhiteSpaces:self.txtClass.text],[DELEGATE trimWhiteSpaces:self.txtSailNo.text]] sortBy:nil];
        
        NSLog(@"%@",[checkuniqueboat objectAtIndex:0]);
        
        if (checkuniqueboat.count>0)
        {
            

            [CustomAlertsCX ShowAlert:@"This sail no alreday exist for this class"];
        }
        else{
   
            if (![[_arrBoatList valueForKey:@"sailno"] containsObject:[DELEGATE trimWhiteSpaces:self.txtSailNo.text]])
            {
                
                
                boatNumber++;
                
                boat_info = [Boat_master newInsertedObject];
                boat_info.identifier = @([CoreDataUtils getNextID:[Boat_master description]]);
                boat_info.name =[NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtBoatName.text]];
                boat_info.classname = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtClass.text]];
                
                
                boat_info.boatno = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtBowNo.text]];
                boat_info.sailno = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtSailNo.text]];
                boat_info.skipper = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtSkipperName.text]];
                
                NSLog(@"%@",_raceid);
                raceboat_info = [Race_boat newInsertedObject];
                raceboat_info.identifier = @([CoreDataUtils getNextID:[Race_boat description]]);
                raceboat_info.boat_id = boat_info.identifier;
                NSLog(@"%@",_raceid);
                raceboat_info.race_id =_raceid;
                
                raceboat_info.addboatmaster = boat_info;
                //boat_info.addboat=raceboat_info;
                
                [CoreDataUtils updateDatabase];
                
                
                NSMutableDictionary *dict_detail=[[NSMutableDictionary alloc]init];
                [dict_detail setObject:boat_info.sailno forKey:@"sailno"];
                [_arrBoatList addObject:dict_detail];
                
            }
           
            
 
//            NSArray *array =[[NSArray alloc] init];
//            array =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"identifier =%@" queryArguments:@[_raceid] sortBy:nil];
//            
//            NSLog(@"%@",array);
//            
//            race_info=[array objectAtIndex:0];
//            
//            raceboat_info.addracemaster=race_info;
//            race_info.addrace=raceboat_info;
//            
//            
//            [CoreDataUtils updateDatabase];
//
            [_AddNewBoatCustomView setHidden:YES];
            [_AddExistingBoatView setHidden:YES];
            [_AddBoatsView setHidden:YES];
            [self.AddCustomAddBoatsView setHidden:NO];

            
            
            NSLog(@"%@",_arrBoatList);
            
            [self.tblAddRaceView reloadData];
        }
        

        
        NSLog(@"%@",_arrBoatList);
    
        
//        [UIView animateWithDuration:0.4
//                         animations:^{_AddNewBoatCustomView.alpha = 0.0;}
//                         completion:^(BOOL finished){
//                             [_AddNewBoatCustomView removeFromSuperview];
//                             [_AddExistingBoatView removeFromSuperview];
//                             [_AddBoatsView removeFromSuperview];
//                         }];
        
        
        
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////


- (void)addselectionbutton:(UIButton *)sender
{
    NSString *strSelected=[NSString stringWithFormat:@"%@",[[[[self.arrAddFromExisting valueForKey:@"User"]objectAtIndex:taptag]valueForKey:@"isSelected"] objectAtIndex:0]];
    
    
    if([strSelected isEqualToString:@"N"])
    {
        isSelect=YES;
        
        NSLog(@"%@",[[[_arrAddFromExisting objectAtIndex:taptag]valueForKey:@"User"]objectAtIndex:sender.tag]);
        
        //for main group selection
        
        NSMutableDictionary *temp_dict = [[[NSMutableDictionary alloc] initWithDictionary:[_arrAddFromExisting objectAtIndex:taptag]] mutableCopy];
        
        int ij=[[temp_dict valueForKey:@"selectedcount"]intValue];
        ij=ij+1;
        [temp_dict setObject:[NSString stringWithFormat:@"%d",ij] forKey:@"selectedcount"];
        
        [_arrAddFromExisting replaceObjectAtIndex:taptag withObject:temp_dict];
        NSLog(@"%@",temp_dict);
        
        if([[[_arrAddFromExisting objectAtIndex:taptag]valueForKey:@"totalcount"] isEqualToString:[[_arrAddFromExisting objectAtIndex:taptag]valueForKey:@"selectedcount"]])
        {
            
            NSMutableDictionary *temp_dict = [[[NSMutableDictionary alloc] initWithDictionary:[_arrAddFromExisting objectAtIndex:taptag]] mutableCopy];
            [temp_dict setObject:@"N" forKey:@"isSelected"];
            
            [_arrAddFromExisting replaceObjectAtIndex:taptag withObject:temp_dict];
        }
        else
        {
            NSMutableDictionary *temp_dict = [[[NSMutableDictionary alloc] initWithDictionary:[_arrAddFromExisting objectAtIndex:taptag]] mutableCopy];
            [temp_dict setObject:@"Y" forKey:@"isSelected"];
            [temp_dict setObject:@"-1" forKey:@"selectedcount"];
            [_arrAddFromExisting replaceObjectAtIndex:taptag withObject:temp_dict];
        }
    }
    else
    {
        
        isSelect=NO;
        count=0;
        
        //for main group selection
        if([strSelected isEqualToString:@"N"])
        {
            NSMutableDictionary *temp_dict = [[[NSMutableDictionary alloc] initWithDictionary:[_arrAddFromExisting objectAtIndex:taptag]] mutableCopy];
            
            int ij=[[temp_dict valueForKey:@"selectedcount"]intValue];
            ij=ij-1;
            [temp_dict setObject:[NSString stringWithFormat:@"%d",ij] forKey:@"selectedcount"];
            
            [_arrAddFromExisting replaceObjectAtIndex:taptag withObject:temp_dict];
            NSLog(@"%@",temp_dict);
        }
        
        if ([[[_arrAddFromExisting objectAtIndex:taptag]valueForKey:@"totalcount"] isEqualToString:[[_arrAddFromExisting objectAtIndex:taptag]valueForKey:@"selectedcount"]])
            //  if([[[groupdetailmaster objectAtIndex:taptag]valueForKey:@"user"]count]==count)
        {
            NSMutableDictionary *temp_dict = [[[NSMutableDictionary alloc] initWithDictionary:[_arrAddFromExisting objectAtIndex:taptag]] mutableCopy];
            [temp_dict setObject:@"Y" forKey:@"isSelected"];
            
            [_arrAddFromExisting replaceObjectAtIndex:taptag withObject:temp_dict];
        }
        else
        {
            NSMutableDictionary *temp_dict = [[[NSMutableDictionary alloc] initWithDictionary:[_arrAddFromExisting objectAtIndex:taptag]] mutableCopy];
            [temp_dict setObject:@"N" forKey:@"isSelected"];
            
            [_arrAddFromExisting replaceObjectAtIndex:taptag withObject:temp_dict];
        }
    }
    [self.tblAddExistingView reloadData];
}
-(void)changeStatus:(NSString*)status atIndex:(NSInteger)atIndex innerIndex:(NSInteger)innerIndex
{
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithDictionary:[self.arrAddFromExisting objectAtIndex:atIndex]] mutableCopy];
    
    NSMutableArray *arrTemp = [[[NSMutableArray alloc] initWithArray:[dict valueForKey:@"User"]] mutableCopy];
    
    [[arrTemp objectAtIndex:innerIndex] setObject:status forKey:@"isSelected"];
    
    [dict setObject:arrTemp forKey:@"User"];
    
    
    [self.arrAddFromExisting replaceObjectAtIndex:atIndex withObject:dict];
}

#pragma mark ---------- UIAlertview Delegate -------

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==1)
    {
        
        if (buttonIndex==[alertView cancelButtonIndex])
        {
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[ViewController class]])
                {
            
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            
        }
        else
        {
            
        
            RaceViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceViewController"];
            
        
            obj.strId=[[NSString alloc]init];
            
            obj.strId=[NSString stringWithFormat:@"%@",_raceid];
            
            
            DELEGATE.backToHome=YES;
         
            [self.navigationController pushViewController:obj animated:YES];
          
        }
       
    }
 
}

- (IBAction)clickBackToHome:(id)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[ViewController class]])
        {
            
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
    [self.viewAlert setHidden:YES];
    
}

- (IBAction)clickRaceDetails:(id)sender
{
    
    RaceViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceViewController"];
    
    
    obj.strId=[[NSString alloc]init];
    
    obj.strId=[NSString stringWithFormat:@"%@",_raceid];
    DELEGATE.backToHome=YES;
    [self.navigationController pushViewController:obj animated:YES];
    [self.viewAlert setHidden:YES];
    
    
}


@end
