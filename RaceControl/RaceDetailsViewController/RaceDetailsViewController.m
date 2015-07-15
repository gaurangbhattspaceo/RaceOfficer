//
//  RaceDetailsViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "RaceDetailsViewController.h"
#import "AddBoatsCustomCell.h"
#import "RaceDetailVC.h"
#import "Race_master.h"
#import "Boat_master.h"
#import "Race_boat.h"
#import "Race_result.h"
#import "RaceDetailCustomCell.h"

@interface RaceDetailsViewController ()

@end

@implementation RaceDetailsViewController
{
    NSMutableArray *arrRaceEntity, *arrRaceBoat , *arrboat_id;
    Race_master *raceEntity;
    Boat_master *boat_info;
    Race_boat *raceboat_info;
    NSMutableArray *arrBoatEntity;
    UIToolbar *toolBar;
    NSArray *arrTemp;
    NSDate *pickerDates;
    UIToolbar *toolDoneBar;
    int checkboatcount;
    
    NSMutableArray *addboatinformation;
    NSMutableArray *copyListBoatArray;
    NSMutableArray *copyListArray;
    NSMutableDictionary *dictTemp;
    NSMutableDictionary *Dictmain;
    NSMutableArray *arrUser;
    BOOL isSearching;
    BOOL isSearchBar;
    
    NSDate *raceDate;
    
    UIDatePicker *datePicker;
}

@synthesize strID;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    raceDate=[[NSDate alloc]init];
    
    datePicker = [[UIDatePicker alloc] init];
    
    datePicker.backgroundColor =[UIColor whiteColor];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerValueChangedRaceDate:) forControlEvents:UIControlEventValueChanged];
    
    
    
    NSCalendar *calendar1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate1 = [NSDate date];
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    [comps1 setYear:30];
    NSDate *maxDate1 = [calendar1 dateByAddingComponents:comps1 toDate:currentDate1 options:0];
    [comps1 setYear:0];
    NSDate *minDate1 = [calendar1 dateByAddingComponents:comps1 toDate:currentDate1 options:0];
    
    [datePicker setMaximumDate:maxDate1];
    [datePicker setMinimumDate:minDate1];
    
    [_txtfldRaceDate setInputView:datePicker];
    
     
    [_txtLocation setUserInteractionEnabled:NO];
    [_txtStartTime setUserInteractionEnabled:NO];
    [_txtTimeLimit setUserInteractionEnabled:NO];
    [_txtTypeOfRace setUserInteractionEnabled:NO];
    [_btnSave setHidden:YES];
    arrboat_id =[[NSMutableArray alloc] init];
    
    
    CGRect newFrame = self.AddBoatsView.frame;
    newFrame.origin.y = 1500;
    self.AddBoatsView.frame = newFrame;
    //Abrez
    
    _pickerRace =[[UIPickerView alloc]init];
    _pickerRace.delegate=self;
    _pickerRace.dataSource=self;
    _pickerRace.showsSelectionIndicator=YES;
    self.pickerRace.backgroundColor =[UIColor whiteColor];
    _txtTypeOfRace.inputView =_pickerRace;
    
    [_pickerRace selectRow:0 inComponent:0 animated:YES];
    [_pickerRace setUserInteractionEnabled:NO];
    
     _arrRace =[[NSMutableArray alloc] initWithObjects:@"Fleet", @"Match", @"Team" ,nil];
    
    arrTemp=[[NSArray alloc]init];
    NSArray *array =[[NSArray alloc]init];
    
    if (DELEGATE.camefrmnotification)
    {

        strID=DELEGATE.Raceid;
        
    }

    array =[CoreDataUtils RelationgetObject:[Race_boat description] withQueryString:@"(race_id = %@)" queryArguments:@[strID] sortBy:nil];
    
   addboatinformation =[[NSMutableArray alloc] initWithArray:[DELEGATE convertToArray:array]];
   
    
    
//    array =[CoreDataUtils RelationgetObject:[Race_result description] withQueryString:@"(race_id = %@)" queryArguments:@[strID] sortBy:nil];
//    
//    NSMutableArray *add =[[NSMutableArray alloc] initWithArray:[DELEGATE convertToArray:array]];
//    NSLog(@"%@",add);

    arrRaceBoat =[[NSMutableArray alloc] initWithArray:array];
    arrBoatEntity = [[NSMutableArray alloc]init];
    
    _arrBoatList =[[NSMutableArray alloc] init];
    for (raceboat_info in arrRaceBoat)
    {
        boat_info  = raceboat_info.addboatmaster;
        NSLog(@"%@",boat_info.sailno);
        [arrBoatEntity addObject:boat_info.sailno];
        NSLog(@"%@",boat_info);
        [arrboat_id addObject:boat_info.identifier];
       
        NSMutableDictionary *dict_detail=[[NSMutableDictionary alloc]init];
        [dict_detail setObject:boat_info.sailno forKey:@"sailno"];
        [_arrBoatList addObject:dict_detail];
    }
    
    
    arrTemp =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"identifier = %@" queryArguments:@[strID] sortBy:nil];
    
    raceEntity =[arrTemp objectAtIndex:0];
    arrRaceEntity =[[NSMutableArray alloc] initWithArray:arrTemp];
    
//    _lblRaceName.text=[NSString stringWithFormat:@"%@",raceEntity.name];
//    _lblRaceDate.text=[NSString stringWithFormat:@"%@",[DELEGATE convertDateToStringwith3charchter:raceEntity.date]];
    
    
    
    
    _txtfldRaceName.text=[NSString stringWithFormat:@"%@",raceEntity.name];
    
    raceDate=raceEntity.date;
    
    
    _txtfldRaceDate.text=[NSString stringWithFormat:@"%@",[DELEGATE convertDateToStringwith3charchter:raceEntity.date]];

    //NSLog(@"%@",raceEntity.starttime);
    
    _txtStartTime.text=[NSString stringWithFormat:@"%@",[DELEGATE convertDateToFullStringformat:raceEntity.starttime]];
    
    
    _txtLocation.text=[NSString stringWithFormat:@"%@",raceEntity.location];
    
    
    
    NSArray *splitarray = [raceEntity.timelimit componentsSeparatedByString:@" "];
    NSString * str1 = [splitarray objectAtIndex:0];
    //123
   
    _txtTimeLimit.text=[NSString stringWithFormat:@"%@",str1];
//    if ([_txtTimeLimit.text isEqualToString:@""]) {
//        
//         _txtTimeLimit.text=[NSString stringWithFormat:@"%@",str1];
//    }
//    else{
//     _txtTimeLimit.text=[NSString stringWithFormat:@"%@",str1];
//    }
   
    _txtTypeOfRace.text=[NSString stringWithFormat:@"%@",raceEntity.typeofrace];
    
    checkboatcount =(int)arrRaceBoat.count;
    if (arrRaceBoat.count>1) {
            _lblnumberofrace.text =[NSString stringWithFormat:@"Boats (%lu)",(unsigned long)arrRaceBoat.count];
    }
    
    else{
        _lblnumberofrace.text =[NSString stringWithFormat:@"Boat (%lu)",(unsigned long)arrRaceBoat.count];
    }

    
    //// Picker and toolbar
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self action:@selector(donePress)];
    [toolBar sizeToFit];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = [NSArray arrayWithObjects:flexibleSpace,done, nil];
    
    
    // tooldonebar
    
    toolDoneBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    toolDoneBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *donebar = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self action:@selector(donePress)];
    [toolDoneBar sizeToFit];
    
    UIBarButtonItem *flexibleSpaces = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolDoneBar.items = [NSArray arrayWithObjects:flexibleSpaces,donebar, nil];
   // [_txtLocation setInputAccessoryView:toolDoneBar];
    [_txtTimeLimit setInputAccessoryView:toolDoneBar];
    [_txtTypeOfRace setInputAccessoryView:toolDoneBar];
    [_txtStartTime setInputAccessoryView:toolBar];
    [_txtfldRaceName setInputAccessoryView:toolBar];
    [_txtfldRaceDate setInputAccessoryView:toolBar];
    
    
    self.datePicker1 = [[UIDatePicker alloc] init];
    self.datePicker1.backgroundColor =[UIColor whiteColor];
  
    self.datePicker1.datePickerMode = UIDatePickerModeTime;
    [self.datePicker1 addTarget:self action:@selector(datePickerValuedChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:30];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:0];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.datePicker1 setMaximumDate:maxDate];
    [self.datePicker1 setMinimumDate:minDate];
    
    [_txtStartTime setTintColor:[UIColor clearColor]];
    [_txtTypeOfRace setTintColor:[UIColor clearColor]];
    self.txtStartTime.inputView =_datePicker1;
    
    dateformateDate=[[NSDateFormatter alloc]init];
    dateformateTime=[[NSDateFormatter alloc]init];
    
    dateformateTime.dateFormat = @"hh:mm a";
    
    [self.txtStartTime setText:[dateformateTime stringFromDate:raceEntity.starttime]];
   // dateformateTime.dateFormat = @"HH:mm";
    
    [_scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 277)];
    
    _tblRaceDetailView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    
    [_AddNewBoatCustomView setHidden:YES];
    [_AddExistingBoatView setHidden:YES];
    [_scrollAddNewBoatsView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+10)];
    
    [_scrollAddFromExisting setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
   // [_imgSearchBackGround.layer setCornerRadius:5.0f];
   // [_imgSearchBackGround.layer setMasksToBounds:YES];
    [_imgSearchBarAddExisting.layer setCornerRadius:5.0f];
    [_imgSearchBarAddExisting.layer setMasksToBounds:YES];
    
    
    isSelect= NO;
    [_tblRaceDetailView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.txtfldRaceName setUserInteractionEnabled:NO];
    [self.txtfldRaceDate setUserInteractionEnabled:NO];
    FirstTimeEditDate = NO;
    checkdelete =YES;
    [_Btnaddboat setHidden:YES];
    firsttimeselected =NO;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)datePickerValuedChanged:(id)sender
{
    // Date formatter for date picker
    
    dateformateTime.dateFormat = @"hh:mm a";
    _txtStartTime.text = [NSString stringWithFormat:@"%@",
                          [dateformateTime stringFromDate:[_datePicker1 date]]];
    pickerDates=_datePicker1.date;
    
}



- (void)datePickerValueChangedRaceDate:(id)sender
{
    // Date formatter for date picker
    
   
//    _txtfldRaceDate.text = [NSString stringWithFormat:@"%@",
//                           [DELEGATE convertDateToStringwith3charchter:datePicker.date]];
//    
//    raceDate=_datePicker1.date;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==_txtStartTime)
    {
        //add the pick

        if (!FirstTimeEditDate) {
            
            
            
            FirstTimeEditDate=NO;
            [_datePicker1 setDate:raceEntity.starttime];
            [self.txtStartTime setText:[dateformateTime stringFromDate:raceEntity.starttime]];
            pickerDates=_datePicker1.date;
            
           
            
           // NSString *YourselectedTitle = [self.yourArrayName objectAtIndex:[self.yourPickerName selectedRowInComponent:0]];
          //  NSLog(@"%@", YourselectedTitle);
            
           // [_pickerLocation selectRow:10 inComponent:0 animated:NO];
            
        }
        
        
//        if (!firsttimeselected) {
//        
//            firsttimeselected=YES;
//            BOOL ObjectThere = [_arrPickerArray containsObject:curruntcountrycode];
//        
//            if (ObjectThere) {
//                        NSUInteger fooIndex = [_arrPickerArray indexOfObject:curruntcountrycode];
//                        [pickerLocation selectRow:fooIndex inComponent:0 animated:NO];
//            }
//            else{
//                        [pickerLocation selectRow:0 inComponent:0 animated:NO];
//            }
//        }

    }
    else if (textField ==_txtTypeOfRace){
        
        if (!firsttimeselected) {
            
            firsttimeselected=YES;
            BOOL ObjectThere = [_arrRace containsObject:raceEntity.typeofrace];
            
            if (ObjectThere) {
                NSUInteger fooIndex = [_arrRace indexOfObject:raceEntity.typeofrace];
                [_pickerRace selectRow:fooIndex inComponent:0 animated:NO];
            }
            else{
                [_pickerRace selectRow:0 inComponent:0 animated:NO];
            }
        }
        
        

    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{

    if(textField==self.txtfldRaceDate)
    {
        raceDate=datePicker.date;
        
        [_txtfldRaceDate setText:[DELEGATE convertDateToStringwith3charchter:datePicker.date]];
        
    }
    
  
   
}


-(void)donePress
{
    if ([_txtTimeLimit isEditing])
    {
        [_txtTimeLimit resignFirstResponder];
    }
    else if ([_txtTypeOfRace isEditing])
    {
        [_txtTypeOfRace resignFirstResponder];
    }
    else if ([_txtLocation isEditing])
    {
        [_txtLocation resignFirstResponder];
    }
    
    
    else if ([_txtfldRaceDate isEditing])
    {
        [_txtfldRaceDate resignFirstResponder];
    }
    else if ([_txtfldRaceName isEditing])
    {
        [_txtfldRaceName resignFirstResponder];
    }
    
    
    else
    {
        [_txtStartTime resignFirstResponder];
    }
    
    [_scrollView setFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 277)];
}


#pragma mark Tableview Datasource

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"RaceDetailCustomCell";
//    RaceDetailCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil)
//    {
//        NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"RaceDetailCustomCell" owner:self options:nil];
//        cell = (RaceDetailCustomCell *)[arrNib objectAtIndex:0];
//    }
//    
//    if (checkdelete) {
//        
//        cell.btndelete.hidden =YES;
//    }
//    else{
//    
//        cell.btndelete.hidden =NO;
//    }
//    
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    
//    cell.lblRank.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
//    
//    cell.lblBoatName.text=[NSString stringWithFormat:@"%@",[arrBoatEntity objectAtIndex:indexPath.row]];
//    
//    cell.btndelete.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-55, 8, 46, 30);
//    [cell.btndelete setTag:indexPath.row];
//    //[cell.btndelete setImage:[UIImage imageNamed:@"heart_red.png"] forState:UIControlStateNormal];
//    [cell.btndelete addTarget:self
//                     action:@selector(DeleteClick:)
//           forControlEvents:UIControlEventTouchDown];
//    
//    return cell;
//}

-(IBAction)DeleteClick:(UIButton *)sender
{
    
    NSLog(@"%@",arrBoatEntity);
    boattag =(int)sender.tag;
    //[arrBoatEntity removeObjectAtIndex:sender.tag];
    
    
    [_arrBoatList removeObjectAtIndex:sender.tag];

    
//    NSMutableArray *add =[[NSMutableArray alloc] initWithArray:[DELEGATE convertToArray:array]];
//   // NSLog(@"%@",add);
//    
//
//    for (raceboat_info in array)
//    {
//        boat_info  = raceboat_info.addboatmaster;
//        NSLog(@"%@",boat_info.sailno);
//        
//        if ([[arrBoatEntity objectAtIndex:sender.tag] isEqualToString:boat_info.sailno])
//        {
//            break;
//        }
//    }
    
    
    
    NSArray *array =[[NSArray alloc] init];
    array =[CoreDataUtils RelationgetObject:[Race_boat description] withQueryString:@"(race_id = %@) AND (boat_id =%@)" queryArguments:@[strID,[arrboat_id objectAtIndex:boattag]] sortBy:nil];
    
    for (int i = 0 ; i < array.count; i++) {
        Race_boat *race = [array objectAtIndex:i];
        [CoreDataUtils deleteObject:race];
        [CoreDataUtils updateDatabase];
    }
    
     checkboatcount=checkboatcount-(int)array.count;
    
    
    if (checkboatcount>1) {
        _lblnumberofrace.text =[NSString stringWithFormat:@"Boats (%lu)",(unsigned long)checkboatcount];
    }
    
    else{
        _lblnumberofrace.text =[NSString stringWithFormat:@"Boat (%lu)",(unsigned long)checkboatcount];
    }
    
    [_tblRaceDetailView reloadData];
    
    
    
}
#pragma mark Textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [textField resignFirstResponder];
//    return YES;
//    fgg
    
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

    return YES;
}


#pragma mark Button Actions
- (IBAction)btnEditRaceClicked:(id)sender
{
    
    [self.txtfldRaceName setUserInteractionEnabled:YES];
    [self.txtfldRaceDate setUserInteractionEnabled:YES];
    [_txtLocation setUserInteractionEnabled:YES];
    [_txtStartTime setUserInteractionEnabled:YES];
    [_txtTimeLimit setUserInteractionEnabled:YES];
    [_txtTypeOfRace setUserInteractionEnabled:YES];
    [_btnEdit setHidden:YES];
    [_btnSave setHidden:NO];
    [_Btnaddboat setHidden:NO];
    checkdelete =NO;
    [_tblRaceDetailView reloadData];
    
    //// Abrez /////
    
}
- (IBAction)btnAddClicked:(id)sender
{
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.AddBoatsView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
    } completion:^(BOOL finished)
     {}];
}


    //merge two dates

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

-(NSDate *)toLocalTime:(NSDate *)utcDate
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate:utcDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate:utcDate];
}


-(void)UpdateDatabase:(NSArray *)DataToUpdate StartTime:(NSDate *)time TimeLimit:(NSString *)limit TypeOfRace:(NSString *)typeOfrace Location:(NSString *)location racedate:(NSDate *)RaceDate racename:(NSString *)racename
{
    NSLog(@"%lu",(unsigned long)DataToUpdate.count);
    
    for (int i=0;i<[DataToUpdate count];i++)
    {
        raceEntity=[DataToUpdate objectAtIndex:i];
        
        if (!time)
        {
            time=raceEntity.starttime;
      
        }
        
        if(time||RaceDate)
        {
            //NSLog(@"%@",time);
          
       
       ///******** first remove old notification
            
            UIApplication *app = [UIApplication sharedApplication];
            NSArray *eventArray = [app scheduledLocalNotifications];
            if (eventArray.count>0) {
                for (int i=0; i<[eventArray count]; i++)
                {
                    UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
                    NSDictionary *userInfoCurrent = oneEvent.userInfo;
                    NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"raceid"]];
                    
                    if ([uid isEqualToString:strID])
                    {
                        //Cancelling local notification
                        [app cancelLocalNotification:oneEvent];
                        
                    }
                }
            }
            
            
            //******** now generate new

            
            NSDate *dateschedule =[self MergeTwoDates:RaceDate date2:time];
            
            NSDateComponents *compschedule = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:dateschedule];
            dateschedule = [dateschedule dateByAddingTimeInterval:-compschedule.second];
         
           
            
            int dateScheduleTimeStamp=[dateschedule timeIntervalSince1970];
            
            int Todaytimestamp=[[NSDate date]timeIntervalSince1970];
//            
//            NSLog(@"%d",dateScheduleTimeStamp);
//            NSLog(@"%d",Todaytimestamp);
      
            if (dateScheduleTimeStamp>Todaytimestamp)
            {
              
           
                
                //*********** Schedule notification
                
                
                
                UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                localNotification.fireDate = [dateschedule dateByAddingTimeInterval:-11];//[NSDate dateWithTimeIntervalSinceNow:60];
                localNotification.alertAction=@"This is Local";
                // localNotification.alertBody = [NSString stringWithFormat:@"Today you have new race at %@",[DELEGATE convertDateTotime:Race_info.starttime]];
                
                localNotification.alertBody = [NSString stringWithFormat:@"%@ Race start",raceEntity.name];
                localNotification.timeZone = [NSTimeZone defaultTimeZone];
                localNotification.soundName = @"sound1.mp3";
                // localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
                
                NSMutableDictionary *infoDict =[[NSMutableDictionary alloc]init];
                [infoDict setObject:raceEntity.identifier forKey:@"raceid"];
                [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
                [infoDict setObject:raceEntity.name forKey:@"racename"];
                [infoDict setObject:@"10" forKey:@"istime"];
                localNotification.userInfo = infoDict;
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                
                
                
                NSDate *datetime = raceEntity.starttime;
                
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
                            localNotification.alertBody = [NSString stringWithFormat:@"%@ will start in %d mins",raceEntity.name,i];
                            
                            
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
                            [infoDict setObject:raceEntity.identifier forKey:@"raceid"];
                            [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
                            [infoDict setObject:raceEntity.name forKey:@"racename"];
                            [infoDict setObject:[NSString stringWithFormat:@"%d",i] forKey:@"notificationno"];
                            localNotification.userInfo = infoDict;
                            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                        }
                        
                        
                    }
            
            }
                
                raceEntity.starttime=dateschedule;
                raceEntity.date=dateschedule;
          
            }
          
            
           
            
//            NSDate *date = time;
//
//            NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond
//                                                                     fromDate:date];
//            date = [date dateByAddingTimeInterval:-comp.second-60];
//
//            NSLog(@"%@",date);
//
//
//            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//            localNotification.fireDate = [date dateByAddingTimeInterval:0];//[NSDate dateWithTimeIntervalSinceNow:60];
//            localNotification.alertAction=@"This is Local";
//            localNotification.alertBody = [NSString stringWithFormat:@"Today you have new race at %@",[DELEGATE convertDateTotime:time]];
//            localNotification.timeZone = [NSTimeZone defaultTimeZone];
//            
//            NSMutableDictionary *infoDict =[[NSMutableDictionary alloc]init];
//            [infoDict setObject:strID forKey:@"raceid"];
//            [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
//            [infoDict setObject:self.lblRaceName.text forKey:@"racename"];
//            localNotification.userInfo = infoDict;
//            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
            
        }
        if ([limit isEqualToString:@"1"]) {
            
            raceEntity.timelimit = [NSString stringWithFormat:@"%@ minute",[DELEGATE trimWhiteSpaces:limit]];
        }
        else{
            raceEntity.timelimit = [NSString stringWithFormat:@"%@ minutes",[DELEGATE trimWhiteSpaces:limit]];
        }
        
        
        
       // raceEntity.timelimit=limit;
        raceEntity.typeofrace=typeOfrace;
        raceEntity.location=location;
        //raceEntity.date=RaceDate;
        //raceEntity.starttime=RaceDate;
        raceEntity.name=racename;
        
        [CoreDataUtils updateDatabase];
    }
    FirstTimeEditDate =NO;
}

-(BOOL)validation
{
    if ([_txtfldRaceName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<=0)
    {
        [CustomAlertsCX ShowAlert:@"Please enter race name"];
        [_txtfldRaceName becomeFirstResponder];
        return NO;
        
        
    }
    
    if ([_txtfldRaceDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<=0)
    {
        [CustomAlertsCX ShowAlert:@"Please enter race date"];
        [_txtfldRaceDate becomeFirstResponder];
        return NO;
        
        
    }

    else
    {
        return YES;
    }
  
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField==_txtfldRaceName)
    {
        
        NSString *newString = [_txtfldRaceName.text stringByReplacingCharactersInRange:range withString:string];
        
        return !([newString length]>20);
    }
 
    return YES;
    
}



- (IBAction)btnSaveClicked:(id)sender
{
    
    if ([self validation])
    {
        checkdelete =YES;
        [_Btnaddboat setHidden:YES];
        [_btnSave setHidden:YES];
        [_btnEdit setHidden:NO];
        [_txtLocation setUserInteractionEnabled:NO];
        [_txtStartTime setUserInteractionEnabled:NO];
        [_txtTimeLimit setUserInteractionEnabled:NO];
        [_txtTypeOfRace setUserInteractionEnabled:NO];
        [self.txtfldRaceName setUserInteractionEnabled:NO];
        [self.txtfldRaceDate setUserInteractionEnabled:NO];
        
        
        
        
        
        NSLog(@"%@",arrRaceEntity);
        
         NSLog(@"%@",raceDate);
        
        [self UpdateDatabase:arrTemp StartTime:pickerDates TimeLimit:_txtTimeLimit.text TypeOfRace:_txtTypeOfRace.text Location:_txtLocation.text racedate:raceDate racename:_txtfldRaceName.text];
        [_tblRaceDetailView reloadData];

        
    }
    

}


- (IBAction)btnBackClicked:(id)sender
{

    if (DELEGATE.camefrmnotification)
    {
        
        DELEGATE.camefrmnotification=NO;
        
        UIStoryboard *Mainstorybard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DELEGATE.nav=[Mainstorybard instantiateViewControllerWithIdentifier:@"rootnav"];
        DELEGATE.window.rootViewController=DELEGATE.nav;
        
    }
    else if (DELEGATE.backToHome)
    {
        
        DELEGATE.backToHome=NO;
        
        UIStoryboard *Mainstorybard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DELEGATE.nav=[Mainstorybard instantiateViewControllerWithIdentifier:@"rootnav"];
        DELEGATE.window.rootViewController=DELEGATE.nav;
        
        
    }
    
    else
    {
    
    [self.navigationController popViewControllerAnimated:YES];
        
    }
}


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
- (IBAction)btnBackFromCustomViewClicked:(id)sender
{
   // [self.navigationController popViewControllerAnimated:YES];
    [_AddNewBoatCustomView setHidden:YES];
    [_AddExistingBoatView setHidden:YES];
    [_AddBoatsView setHidden:YES];
    [_AddCustomAddBoatsView setHidden:YES];
}

- (IBAction)btnCloseFromCustomView:(id)sender
{
    
    CGRect newFrame = self.AddBoatsView.frame;
    newFrame.origin.y = 1500;
    self.AddBoatsView.frame = newFrame;
    
}

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

#pragma mark tableview Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    ///tableview 1
    
    if (tableView.tag==300)
    {
        return 0;
    }
    
    ///tableview 2
    
    else if(tableView.tag==400)
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
    
    if (tableView.tag==300)
    {
        return NO;
    }
    
    ///tableview 2
    
    else if(tableView.tag==400)
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
    if (tableView.tag==300)
    {
        return 1;
    }
    else if(tableView.tag==400)
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

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//
//    return [arrBoatEntity count];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    ///tableview 1
    
    if (tableView.tag==300)
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
    
    else if(tableView.tag==400)
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
//    static NSString *cellIdentifier = @"RaceDetailCustomCell";
//    RaceDetailCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil)
//    {
//        NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"RaceDetailCustomCell" owner:self options:nil];
//        cell = (RaceDetailCustomCell *)[arrNib objectAtIndex:0];
//    }
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    ///tableview 1
    
    if (tableView.tag==300)
    {
        
        static NSString *cellIdentifier = @"RaceDetailCustomCell";
        RaceDetailCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"RaceDetailCustomCell" owner:self options:nil];
            cell = (RaceDetailCustomCell *)[arrNib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        if (isSearching)
        {
            NSLog(@"%@",copyListArray);
            cell.lblRank.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
            cell.lblBoatName.text=[NSString stringWithFormat:@"%@",[copyListArray objectAtIndex:indexPath.row]];
        }
        else
        {
            //boat_info =[_arrBoatList objectAtIndex:indexPath.row];
            NSLog(@"%@",_arrBoatList);
            cell.lblRank.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
            //cell.lblBoatName.text=[NSString stringWithFormat:@"%@",boat_info.sailno];
            cell.lblBoatName.text=[NSString stringWithFormat:@"%@",[[_arrBoatList objectAtIndex:indexPath.row]valueForKey:@"sailno"]];
            
            
            if (checkdelete) {
                
                cell.btndelete.hidden =YES;
            }
            else{
                
                cell.btndelete.hidden =NO;
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.btndelete.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-55, 8, 46, 30);
            [cell.btndelete setTag:indexPath.row];
            //[cell.btndelete setImage:[UIImage imageNamed:@"heart_red.png"] forState:UIControlStateNormal];
            [cell.btndelete addTarget:self
                               action:@selector(DeleteClick:)
                     forControlEvents:UIControlEventTouchDown];
            
            
            
        }
        return cell;
    }
    
    ///tableview 2
    
   // else if (tableView.tag==400)
    else
    {
        
        static NSString *cellIdentifier = @"AddBoatsCustomCell";
        AddBoatsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"AddBoatsCustomCell" owner:self options:nil];
            cell = (AddBoatsCustomCell *)[arrNib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
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
            //[cell.imgButton setImage:[UIImage imageNamed:@"imgRound-Done-Button"]];
            
            
            
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
        
        return cell;
    }
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==400) {
        
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
-(void)changeStatus:(NSString*)status atIndex:(NSInteger)atIndex innerIndex:(NSInteger)innerIndex
{
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithDictionary:[self.arrAddFromExisting objectAtIndex:atIndex]] mutableCopy];
    
    NSMutableArray *Temparr = [[[NSMutableArray alloc] initWithArray:[dict valueForKey:@"User"]] mutableCopy];
    
    [[Temparr objectAtIndex:innerIndex] setObject:status forKey:@"isSelected"];
    
    [dict setObject:Temparr forKey:@"User"];
    
    
    [self.arrAddFromExisting replaceObjectAtIndex:atIndex withObject:dict];
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

- (IBAction)btnExistingDoneClicked:(id)sender
{
    NSLog(@"%@",_arrAddFromExisting);
    
    for (int i=0; i<_arrAddFromExisting.count; i++) {
        
        
        for (int j=0; j<[[[_arrAddFromExisting objectAtIndex:i]valueForKey:@"User"] count]; j++) {
            
            if ([[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"isSelected"] isEqualToString:@"Y"])
            {
                
                NSString *strboatid=[NSString stringWithFormat:@"%@",[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"boatid"]];
                
                NSString *strsailno=[NSString stringWithFormat:@"%@",[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"user_name"]];
                
                NSLog(@"%@",strsailno);
                NSLog(@"%@",_arrBoatList);
                if (![[_arrBoatList valueForKey:@"sailno"] containsObject:strsailno]){
                    
                    NSLog(@"true");
                    NSArray *ary =[[NSArray alloc] init];
                    ary =[CoreDataUtils RelationgetObject:[Boat_master description] withQueryString:@"(identifier = %@)" queryArguments:@[strboatid] sortBy:nil];
                    
                    boat_info =[ary objectAtIndex:0];
                    DELEGATE.COREIDENTIFIER=@"identifier";
                    DELEGATE.QUERY_IDENTIFIER =@"identifier = %d";
                    [arrboat_id addObject:boat_info.identifier];
                    raceboat_info = [Race_boat newInsertedObject];
                    raceboat_info.identifier = @([CoreDataUtils getNextID:[Race_boat description]]);
                    raceboat_info.boat_id =[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"boatid"];
                    NSLog(@"%@",strID);
                    raceboat_info.race_id =[NSNumber numberWithInt:[[NSString stringWithFormat:@"%@",strID]intValue]];
                    raceboat_info.addboatmaster = boat_info;
                    [CoreDataUtils updateDatabase];
                    
                    NSMutableDictionary *dict_detail=[[NSMutableDictionary alloc]init];
                    [dict_detail setObject:[[[[_arrAddFromExisting objectAtIndex:i] valueForKey:@"User"]objectAtIndex:j] valueForKey:@"user_name"] forKey:@"sailno"];
                    [_arrBoatList addObject:dict_detail];
                    
                    
                    checkboatcount=checkboatcount+1;
                    
                    
                    if (checkboatcount>1) {
                        _lblnumberofrace.text =[NSString stringWithFormat:@"Boats (%lu)",(unsigned long)checkboatcount];
                    }
                    
                    else{
                        _lblnumberofrace.text =[NSString stringWithFormat:@"Boat (%lu)",(unsigned long)checkboatcount];
                    }
                }
                
                
                
                
            }
            
        }
        
    }
    
    
    [self.view endEditing:YES];
    [self.AddExistingBoatView setHidden:YES];
    [self.AddCustomAddBoatsView setHidden:NO];
    [_tblRaceDetailView reloadData];
    
    
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
    //[_txtSearch endEditing:YES];
}

#pragma mark add from existing validator
-(void)Validator
{
    NSString *strName= [self.txtBoatName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strSailNo= [self.txtSailNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strSkipper= [self.txtSkipperName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strClass= [self.txtClass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 //   NSString *strBowNo= [self.txtBowNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
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
        [CustomAlertsCX ShowAlert:@"Please enter boat name"];
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
        
        if (checkuniqueboat.count>0) {
            
            
            [CustomAlertsCX ShowAlert:@"This sail no alreday exist for this class"];
        }
        else{
            
            if (![[_arrBoatList valueForKey:@"sailno"] containsObject:[DELEGATE trimWhiteSpaces:self.txtSailNo.text]]){
                
                boat_info = [Boat_master newInsertedObject];
                boat_info.identifier = @([CoreDataUtils getNextID:[Boat_master description]]);
                boat_info.name =[NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtBoatName.text]];
                boat_info.classname = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtClass.text]];
                
                boat_info.boatno = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtBowNo.text]];
                boat_info.sailno = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtSailNo.text]];
                boat_info.skipper = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtSkipperName.text]];
                [arrboat_id addObject:boat_info.identifier];
                
                NSLog(@"%@",strID);
                raceboat_info = [Race_boat newInsertedObject];
                raceboat_info.identifier = @([CoreDataUtils getNextID:[Race_boat description]]);
                raceboat_info.boat_id = boat_info.identifier;
                NSLog(@"%@",strID);
                raceboat_info.race_id =[NSNumber numberWithInt:[[NSString stringWithFormat:@"%@",strID] intValue]];
                
                raceboat_info.addboatmaster = boat_info;
                //boat_info.addboat=raceboat_info;
                
                [CoreDataUtils updateDatabase];
                
                
                NSMutableDictionary *dict_detail=[[NSMutableDictionary alloc]init];
                [dict_detail setObject:boat_info.sailno forKey:@"sailno"];
                [_arrBoatList addObject:dict_detail];
                
                
                checkboatcount=checkboatcount+1;
                
                
                if (checkboatcount>1) {
                    _lblnumberofrace.text =[NSString stringWithFormat:@"Boats (%lu)",(unsigned long)checkboatcount];
                }
                
                else{
                    _lblnumberofrace.text =[NSString stringWithFormat:@"Boat (%lu)",(unsigned long)checkboatcount];
                }
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
            
            [self.tblRaceDetailView reloadData];
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


///// Picker view for location //////

#pragma mark PICKER DATASOURCE & DALEGATE

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return _arrRace.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    _txtTypeOfRace.text=[_arrRace objectAtIndex:[_pickerRace selectedRowInComponent:0]];
    return [_arrRace objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==_pickerRace) {
        [_txtTypeOfRace setText:[_arrRace objectAtIndex:row]];
    }
    
}
@end
