//
//  CreateNewRacesViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 06/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "CreateNewRacesViewController.h"
#import "AddBoatsViewController.h"
#import "Validate.h"
#import "Utilities.h"
#import "CustomAlertsCX.h"
#import "Race_master.h"


@interface CreateNewRacesViewController ()
{
   // Student_master *objStudentMaster;
}

@end

@implementation CreateNewRacesViewController
{
    UIToolbar *toolBar;
   // UIToolbar *toolBar2;
    DemoContentView *AlertView;
    Race_master *Race_info;
}

- (void)viewDidLoad
{
    
  //  [_scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    
    
//     [CoreDataUtils deleteObject:Race_info];
//    
//    NSArray *array =[[NSArray alloc]init];
//    array =[CoreDataUtils getObjects:[Race_master description]];
//  
//    NSLog(@"%@",array);
//    //error handling goes here
//    for (NSManagedObject * arr in array) {
//        [CoreDataUtils deleteObject:arr];
//    }
//    [CoreDataUtils updateDatabase];
    
//    NSDate* now = [NSDate date] ;
//    
//    NSDateComponents* tomorrowComponents = [NSDateComponents new] ;
//    tomorrowComponents.day = 1 ;
//    NSCalendar* calendar1 = [NSCalendar currentCalendar] ;
//    NSDate* tomorrow = [calendar1 dateByAddingComponents:tomorrowComponents toDate:now options:0] ;
//    
//    NSDateComponents* tomorrowAt8AMComponents = [calendar1 components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:tomorrow] ;
//    tomorrowAt8AMComponents.hour = 8 ;
//    NSDate* tomorrowAt8AM = [calendar1 dateFromComponents:tomorrowAt8AMComponents] ;
//    NSLog(@"%@",tomorrowAt8AM);
//    
////#define COREIDENTIFIER @"race_id"
////#define QUERY_IDENTIFIER @"race_id = %d"
//    
//    [super viewDidLoad];
//    
//    DELEGATE.COREIDENTIFIER=@"identifier";
//    DELEGATE.QUERY_IDENTIFIER =@"identifier = %d";
//    Race_info = [Race_master newInsertedObject];
//    Race_info.identifier = @([CoreDataUtils getNextID:[Race_master description]]);
//    Race_info.name =@"new race on delhi";
//    Race_info.date =tomorrowAt8AM;
//    Race_info.starttime = tomorrowAt8AM;
//    Race_info.timelimit =@"2 hours";
//    Race_info.typeofrace = @"super fast";
//    Race_info.location = @"Delhi";
//    Race_info.notificationStatus = @"0";
//    
//    [CoreDataUtils updateDatabase];
    
    

//    DELEGATE.COREIDENTIFIER=@"id";
//    DELEGATE.QUERY_IDENTIFIER =@"id =%d";
//    Race_info = [Race_master newInsertedObject];
//    Race_info.id = @([CoreDataUtils getNextID:[Race_master description]]);
//    Race_info.name =@"new race on delhi";
//    Race_info.date =[NSDate date];
//    Race_info.starttime = [NSDate date];
//    Race_info.timelimit =@"2 hours";
//    Race_info.typeofrace = @"super fast";
//    Race_info.location = @"Delhi";
//    
//    [CoreDataUtils updateDatabase];
    
    
//    DELEGATE.COREIDENTIFIER=@"id";
//    DELEGATE.QUERY_IDENTIFIER =@"id =%d";
//     NSArray  *gettedStudentData =[[NSArray alloc]init];
//    //********* insert Data into Table
//    
//    [self InsertIntoStudentTable:@"dk" email:@"dk@peerbits.com"];
//    
//    
//    gettedStudentData= [CoreDataUtils getObjects:[Student_master description] withQueryString:@"" queryArguments:@[@""] sortBy:nil];
//    
//    NSLog(@"%@",gettedStudentData);
//    
//    
//    //********* Convert Results into Dictionary
//    
//    NSMutableArray *get=[[NSMutableArray alloc]init];
//    
//    get=[self convertToArray:gettedStudentData];
//    
//    NSLog(@"%@",get);
    

    
    
    
  
  //  [pickerLocation setHidden:YES];
   // [_scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
 

    
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    firsttimeselected =NO;
    
//    @property (strong, nonatomic) IBOutlet UITextField *txtRaceName;
//    @property (strong, nonatomic) IBOutlet UITextField *txtDate;
//    @property (strong, nonatomic) IBOutlet UITextField *txtTime;
//    @property (strong, nonatomic) IBOutlet UITextField *txtTimeLimit;
//    @property (strong, nonatomic) IBOutlet UITextField *txtTypeofRace;
//    @property (strong, nonatomic) IBOutlet UITextField *txtLocation;
    
    _txtRaceName.text =@"";
    _txtDate.text =@"";
    _txtTime.text =@"";
    _txtTimeLimit.text =@"";
    _txtTypeofRace.text =@"";
    _txtLocation.text =@"";
    
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self action:@selector(donePressed)];
    [toolBar sizeToFit];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = [NSArray arrayWithObjects:flexibleSpace,done, nil];
    
    self.txtDate.inputAccessoryView = toolBar;
    self.txtTime.inputAccessoryView = toolBar;
    self.txtTypeofRace.inputAccessoryView = toolBar;
    self.txtTimeLimit.inputAccessoryView = toolBar;
    // self.txtLocation.inputAccessoryView = toolBar;
    
    _pickerRace =[[UIPickerView alloc]init];
    _pickerRace.delegate=self;
    _pickerRace.dataSource=self;
    _pickerRace.showsSelectionIndicator=YES;
     self.pickerRace.backgroundColor =[UIColor whiteColor];
    
    [self.pickerRace selectRow:0 inComponent:0 animated:YES];
    
    [self.pickerRace setUserInteractionEnabled:NO];

    
    self.datePicker1 = [[UIDatePicker alloc] init];
    self.datePicker2 = [[UIDatePicker alloc] init];
    
    self.datePicker1.backgroundColor =[UIColor whiteColor];
    self.datePicker2.backgroundColor =[UIColor whiteColor];
    
    self.datePicker1.datePickerMode = UIDatePickerModeDate;
    [self.datePicker1 addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:30];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:0];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    
    [self.datePicker1 setMaximumDate:maxDate];
    [self.datePicker1 setMinimumDate:minDate];
    

    
  //  [self.datePicker2 setMinimumDate:minDate];
    [self.datePicker2 setMaximumDate:maxDate];
    
    
    [self.txtDate setTintColor:[UIColor clearColor]];
    [self.txtTime setTintColor:[UIColor clearColor]];
    [self.txtTypeofRace setTintColor:[UIColor clearColor]];
    
    
    self.txtTime.inputView =_datePicker2;
    self.txtDate.inputView =_datePicker1;
    self.txtTypeofRace.inputView =_pickerRace;
    
    
    dateformateDate=[[NSDateFormatter alloc]init];
    dateformateTime=[[NSDateFormatter alloc]init];
    
    dateformateDate.dateFormat = @"MMMM dd, yyyy";
    dateformateTime.dateFormat = @"hh:mm a";
    
    
    self.datePicker2.datePickerMode = UIDatePickerModeTime;
    [self.datePicker2 addTarget:self action:@selector(timePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _arrRace =[[NSMutableArray alloc] initWithObjects:@"Fleet", @"Match", @"Team" ,nil];
    
    ////////////////////////// Array Picker for location for country ////////////////
    
    
    //    _arrPickerArray=[[NSMutableArray alloc]initWithObjects:@"Afghanistan", @"Akrotiri", @"Albania", @"Algeria", @"American Samoa", @"Andorra", @"Angola", @"Anguilla", @"Antarctica", @"Antigua and Barbuda", @"Argentina", @"Armenia", @"Aruba", @"Ashmore and Cartier Islands", @"Australia", @"Austria", @"Azerbaijan", @"The Bahamas", @"Bahrain", @"Bangladesh", @"Barbados", @"Bassas da India", @"Belarus", @"Belgium", @"Belize", @"Benin", @"Bermuda", @"Bhutan", @"Bolivia", @"Bosnia and Herzegovina", @"Botswana", @"Bouvet Island", @"Brazil", @"British Indian Ocean Territory", @"British Virgin Islands", @"Brunei", @"Bulgaria", @"Burkina Faso", @"Burma", @"Burundi", @"Cambodia", @"Cameroon", @"Canada", @"Cape Verde", @"Cayman Islands", @"Central African Republic", @"Chad", @"Chile", @"China", @"Christmas Island", @"Clipperton Island", @"Cocos (Keeling) Islands", @"Colombia", @"Comoros", @"Democratic Republic of the Congo", @"Republic of the Congo", @"Cook Islands", @"Coral Sea Islands", @"Costa Rica", @"Cote d'Ivoire", @"Croatia", @"Cuba", @"Cyprus", @"Czech Republic", @"Denmark", @"Dhekelia", @"Djibouti", @"Dominica", @"Dominican Republic", @"Ecuador", @"Egypt", @"El Salvador", @"Equatorial Guinea", @"Eritrea", @"Estonia", @"Ethiopia", @"Europa Island", @"Falkland Islands (Islas Malvinas)", @"Faroe Islands", @"Fiji", @"Finland", @"France", @"French Guiana", @"French Polynesia", @"French Southern and Antarctic Lands", @"Gabon", @"The Gambia", @"Gaza Strip", @"Georgia", @"Germany", @"Ghana", @"Gibraltar", @"Glorioso Islands", @"Greece", @"Greenland", @"Grenada", @"Guadeloupe", @"Guam", @"Guatemala", @"Guernsey", @"Guinea", @"Guinea-Bissau", @"Guyana", @"Haiti", @"Heard Island and McDonald Islands", @"Holy See (Vatican City)", @"Honduras", @"Hong Kong", @"Hungary", @"Iceland", @"India", @"Indonesia", @"Iran", @"Iraq", @"Ireland", @"Isle of Man", @"Israel", @"Italy", @"Jamaica", @"Jan Mayen", @"Japan", @"Jersey", @"Jordan", @"Juan de Nova Island", @"Kazakhstan", @"Kenya", @"Kiribati", @"North Korea", @"South Korea", @"Kuwait", @"Kyrgyzstan", @"Laos", @"Latvia", @"Lebanon", @"Lesotho", @"Liberia", @"Libya", @"Liechtenstein", @"Lithuania", @"Luxembourg", @"Macau", @"Macedonia", @"Madagascar", @"Malawi", @"Malaysia", @"Maldives", @"Mali", @"Malta", @"Marshall Islands", @"Martinique", @"Mauritania", @"Mauritius", @"Mayotte", @"Mexico", @"Federated States of Micronesia", @"Moldova", @"Monaco", @"Mongolia", @"Montserrat", @"Morocco", @"Mozambique", @"Namibia", @"Nauru", @"Navassa Island", @"Nepal", @"Netherlands", @"Netherlands Antilles", @"New Caledonia", @"New Zealand", @"Nicaragua", @"Niger", @"Nigeria", @"Niue", @"Norfolk Island", @"Northern Mariana Islands", @"Norway", @"Oman", @"Pakistan", @"Palau", @"Panama", @"Papua New Guinea", @"Paracel Islands", @"Paraguay", @"Peru", @"Philippines", @"Pitcairn Islands", @"Poland", @"Portugal", @"Puerto Rico", @"Qatar", @"Reunion", @"Romania", @"Russia", @"Rwanda", @"Saint Helena", @"Saint Kitts and Nevis", @"Saint Lucia", @"Saint Pierre and Miquelon", @"Saint Vincent and the Grenadines", @"Samoa", @"San Marino", @"Sao Tome and Principe", @"Saudi Arabia", @"Senegal", @"Serbia", @"Montenegro", @"Seychelles", @"Sierra Leone", @"Singapore", @"Slovakia", @"Slovenia", @"Solomon Islands", @"Somalia", @"South Africa", @"South Georgia and the South Sandwich Islands", @"Spain", @"Spratly Islands", @"Sri Lanka", @"Sudan", @"Suriname", @"Svalbard", @"Swaziland", @"Sweden", @"Switzerland", @"Syria", @"Taiwan", @"Tajikistan", @"Tanzania", @"Thailand", @"Tibet", @"Timor-Leste", @"Togo", @"Tokelau", @"Tonga", @"Trinidad and Tobago", @"Tromelin Island", @"Tunisia", @"Turkey", @"Turkmenistan", @"Turks and Caicos Islands", @"Tuvalu", @"Uganda", @"Ukraine", @"United Arab Emirates", @"United Kingdom", @"United States", @"Uruguay", @"Uzbekistan", @"Vanuatu", @"Venezuela", @"Vietnam", @"Virgin Islands", @"Wake Island", @"Wallis and Futuna", @"West Bank", @"Western Sahara", @"Yemen", @"Zambia", @"Zimbabwe", nil];
    
    
    //    pickerLocation= [[UIPickerView alloc] init];
    //
    //    [pickerLocation setBackgroundColor:[UIColor whiteColor]];
    //    pickerLocation.showsSelectionIndicator = YES;
    //    pickerLocation.delegate =self;
    //    pickerLocation.dataSource =self;
    //
    //    [pickerLocation reloadAllComponents];
    //    _txtLocation.inputView=pickerLocation;
    
    
    //code For getting the currunt location country using nslocale
    
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    
    NSLog(@"%@",countryCode);
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *country = [usLocale displayNameForKey:NSLocaleCountryCode value: countryCode];
    NSLog(@"%@",country);
    
    curruntcountrycode=[NSString stringWithFormat:@"%@",country];
    NSLog(@"%@",curruntcountrycode);
}


-(void)InsertIntoStudentTable:(NSString *)name email:(NSString *)email
{

    
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

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
    
    
}


#pragma mark Validation

-(void)Validator
{

    self.txtRaceName.text =[DELEGATE trimWhiteSpaces:self.txtRaceName.text];
    self.txtTimeLimit.text =[DELEGATE trimWhiteSpaces:self.txtTimeLimit.text];
    self.txtTypeofRace.text =[DELEGATE trimWhiteSpaces:self.txtTypeofRace.text];
    self.txtLocation.text =[DELEGATE trimWhiteSpaces:self.txtLocation.text];
    
    
    if ([Validate isEmpty:self.txtRaceName.text])
    {
        [CustomAlertsCX ShowAlert:@"Please enter race name"];
    }
    else if ([Validate isEmpty:_txtDate.text])
    {
        [CustomAlertsCX ShowAlert:@"Please enter date"];
    }
    else if ([Validate isEmpty:_txtTime.text])
    {
        [CustomAlertsCX ShowAlert:@"Please enter start time"];
    }
    else if ([Validate isEmpty:self.txtTimeLimit.text])
    {
        [CustomAlertsCX ShowAlert:@"Please enter time limit"];
    }
    else if ([self.txtTimeLimit.text intValue]<=0)
    {
        [CustomAlertsCX ShowAlert:@"Please enter valid time limit"];
    }
    else if ([Validate isEmpty:self.txtTypeofRace.text])
    {
        [CustomAlertsCX ShowAlert:@"Please enter type of race"];
    }
    else if ([Validate isEmpty:self.txtLocation.text])
    {
        [CustomAlertsCX ShowAlert:@"Please enter location"];
    }
    
    else
    {
        //GeneralFunctions *GENERAL;
        
        DELEGATE.COREIDENTIFIER=@"identifier";
        DELEGATE.QUERY_IDENTIFIER =@"identifier = %d";
        
        
        
        NSDate *date1 = [self MergeTwoDates:[_datePicker1 date] date2:[_datePicker2 date]];
        
        
        NSDateComponents *comp1 = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:date1];
        date1 = [date1 dateByAddingTimeInterval:-comp1.second+59];
        
        NSLog(@"%@",date1);

        Race_info = [Race_master newInsertedObject];
        Race_info.identifier = @([CoreDataUtils getNextID:[Race_master description]]);
        
        Race_info.name =[NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtRaceName.text]];
        Race_info.date = [_datePicker1 date];
        Race_info.starttime =date1;
        if ([self.txtTimeLimit.text isEqualToString:@"1"]) {
            
                Race_info.timelimit = [NSString stringWithFormat:@"%@ minute",[DELEGATE trimWhiteSpaces:self.txtTimeLimit.text]];
        }
        else{
                Race_info.timelimit = [NSString stringWithFormat:@"%@ minutes",[DELEGATE trimWhiteSpaces:self.txtTimeLimit.text]];
        }

        Race_info.typeofrace = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtTypeofRace.text]];
        Race_info.location = [NSString stringWithFormat:@"%@",[DELEGATE trimWhiteSpaces:self.txtLocation.text]];
        Race_info.notificationStatus = @"0";
        Race_info.racecomplete=@"N";
        NSLog(@"%@",Race_info.starttime);
        
        int timececk =[self.txtTimeLimit.text intValue];
        int check = timececk*60;
        Race_info.expiretime =[NSString stringWithFormat:@"%d",check];
       
        [CoreDataUtils updateDatabase];

        NSDate *date = Race_info.starttime;
        
        NSLog(@"%@",date);
        
        NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond
                                                                 fromDate:date];
        date = [date dateByAddingTimeInterval:-comp.second-60];
        NSLog(@"%@",date);
       // NSDate *oldDate = date;

        
        NSDate *dateschedule = [self MergeTwoDates:[_datePicker1 date] date2:[_datePicker2 date]];
        NSDateComponents *compschedule = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:dateschedule];
        dateschedule = [dateschedule dateByAddingTimeInterval:-compschedule.second];
        NSLog(@"%@",dateschedule);
        
        
        
       //*********** Schedule notification
        
        
//        
//        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//        localNotification.fireDate = [dateschedule dateByAddingTimeInterval:0];//[NSDate dateWithTimeIntervalSinceNow:60];
//        localNotification.alertAction=@"This is Local";
//       // localNotification.alertBody = [NSString stringWithFormat:@"Today you have new race at %@",[DELEGATE convertDateTotime:Race_info.starttime]];
//        
//        localNotification.alertBody = [NSString stringWithFormat:@"%@ Race start",Race_info.name];
//        localNotification.timeZone = [NSTimeZone defaultTimeZone];
//        localNotification.soundName = @"sound1.mp3";
//        // localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
//        
//        NSMutableDictionary *infoDict =[[NSMutableDictionary alloc]init];
//        [infoDict setObject:Race_info.identifier forKey:@"raceid"];
//        [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
//        [infoDict setObject:Race_info.name forKey:@"racename"];
//        localNotification.userInfo = infoDict;
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//        
//        
//        
//        NSDate *datetime = Race_info.starttime;
//        
//        datetime = [datetime dateByAddingTimeInterval:-59];
//        NSLog(@"%@",datetime);
//        
//        for (int i=5;i>=1;i--)
//        {
//            
//            NSDate *Alertnotification = [dateschedule dateByAddingTimeInterval:-60*i];
//            
//            NSDateComponents *compsch = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond
//                                                                     fromDate:[NSDate date]];
//           NSDate *datetimeinfo = [[NSDate date] dateByAddingTimeInterval:-compsch.second-60];
//            NSLog(@"%@",date);
//            
//            
//            NSLog(@"%@",[NSDate date]);
//            NSLog(@"%@",datetimeinfo);
//            NSLog(@"%@",Alertnotification);
//            
//        if ([Alertnotification compare:datetimeinfo] == NSOrderedDescending) {
//                NSLog(@"currentdate is later than getDate");
//                
//            
//           // if ([Alertnotification laterDate:[NSDate date]]) {
//                
//                
//
//                //localNotification.soundName = UILocalNotificationDefaultSoundName;
//            
//                 if (i == 2 || i == 3) {
//                
//                    // localNotification.soundName = @"";
//                 }
//                 else{
//                     UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//                     localNotification.fireDate = [Alertnotification dateByAddingTimeInterval:0];//[NSDate dateWithTimeIntervalSinceNow:60];
//                     localNotification.alertAction=@"This is Local";
//                     //localNotification.alertBody = [NSString stringWithFormat:@"Today you have new race at %@",[DELEGATE convertDateTotime:Race_info.starttime]];
//                     localNotification.alertBody = [NSString stringWithFormat:@"%@ will start in %d mins",Race_info.name,i];
//                 
//                     localNotification.soundName = @"sound1.mp3";
//                     localNotification.timeZone = [NSTimeZone defaultTimeZone];
//                     // localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
//                     
//                     NSMutableDictionary *infoDict =[[NSMutableDictionary alloc]init];
//                     [infoDict setObject:Race_info.identifier forKey:@"raceid"];
//                     [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
//                     [infoDict setObject:Race_info.name forKey:@"racename"];
//                     [infoDict setObject:[NSString stringWithFormat:@"%d",i] forKey:@"notificationno"];
//                     localNotification.userInfo = infoDict;
//                     [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//                 }
//            
//
//            }
//            
//            
//
//            
//            
//        }

        
        
        
        
    //********************************************
        
        
        
        
        
        
//        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//        localNotification.fireDate = [date dateByAddingTimeInterval:0];//[NSDate dateWithTimeIntervalSinceNow:60];
//        localNotification.alertAction=@"This is Local";
//        localNotification.alertBody = [NSString stringWithFormat:@"Today you have new race at %@",[DELEGATE convertDateTotime:Race_info.starttime]];
//        localNotification.timeZone = [NSTimeZone defaultTimeZone];
//        // localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
//        
//        NSMutableDictionary *infoDict =[[NSMutableDictionary alloc]init];
//        [infoDict setObject:Race_info.identifier forKey:@"raceid"];
//        [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
//        [infoDict setObject:Race_info.name forKey:@"racename"];
//        localNotification.userInfo = infoDict;
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        AddBoatsViewController *addBoatscontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"AddBoatsViewController"];
        NSLog(@"%@",Race_info.identifier);
        [addBoatscontroller setRaceid:Race_info.identifier];
        //  [addBoatscontroller setRaceid:[NSNumber numberWithInt:3]];
        
        [self.navigationController pushViewController:addBoatscontroller animated:YES];
        
    }
    

//    AddBoatsViewController *addBoatscontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"AddBoatsViewController"];
//    NSLog(@"%@",Race_info.identifier);
//    [addBoatscontroller setRaceid:Race_info.identifier];
//    //  [addBoatscontroller setRaceid:[NSNumber numberWithInt:3]];
//    [self.navigationController pushViewController:addBoatscontroller animated:YES];
    
    
//    NSArray *gettedStudentData =[[NSArray alloc] init];
//     gettedStudentData= [CoreDataUtils getObjects:[Race_master description] withQueryString:@"" queryArguments:@[@""] sortBy:nil];
//    
//    NSLog(@"%@",gettedStudentData);
//    NSLog(@"%@",[gettedStudentData objectAtIndex:0]);
    
    

}


#pragma mark textfield delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==_txtDate) {
        //add the pick
    [self.txtDate setText:[dateformateDate stringFromDate:[_datePicker1 date]]];
        
    }
    else if (textField == _txtTime){
    
        
        if ([DELEGATE isSameDay:_datePicker1.date otherDay:[NSDate date]])
        {
            [self.datePicker2 setMinimumDate:[NSDate date]];
        }
        else{
            [self.datePicker2 setMinimumDate:nil];
        }
        
        
    [self.txtTime setText:[dateformateTime stringFromDate:[_datePicker2 date]]];
    }
    else if (textField ==_txtTypeofRace){
    
    
    }
    else if (textField == _txtLocation){
    
        
//        if (!firsttimeselected) {
//            
//            firsttimeselected=YES;
//            BOOL ObjectThere = [_arrPickerArray containsObject:curruntcountrycode];
//            
//            if (ObjectThere) {
//                NSUInteger fooIndex = [_arrPickerArray indexOfObject:curruntcountrycode];
//                [pickerLocation selectRow:fooIndex inComponent:0 animated:NO];
//            }
//            else{
//                [pickerLocation selectRow:0 inComponent:0 animated:NO];
//            }
//        }

    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField==_txtTimeLimit)
    {
        
        NSString *newString = [_txtTimeLimit.text stringByReplacingCharactersInRange:range withString:string];
        
        return !([newString length] > 4);
    }
    return YES;
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_txtRaceName isFirstResponder])
    {
       // [_txtRaceName resignFirstResponder];
        [_txtDate becomeFirstResponder];
    }
//    else if ([_txtDate isFirstResponder])
//    {
//        [_txtDate resignFirstResponder];
//        [_txtTime becomeFirstResponder];
//    }
//    else if ([_txtTime isFirstResponder])
//    {
//        [_txtTime resignFirstResponder];
//        [_txtTimeLimit becomeFirstResponder];
//    }
//    else if ([_txtTimeLimit isFirstResponder])
//    {
//     //   [_txtTimeLimit resignFirstResponder];
//        [_txtTypeofRace becomeFirstResponder];
//    }
    else if ([_txtTypeofRace isFirstResponder])
    {
       // [_txtTypeofRace resignFirstResponder];
        [_txtLocation becomeFirstResponder];
    }
    else
    {
        [_txtLocation resignFirstResponder];
        [_scrollView setContentOffset:CGPointMake(0,0)];
        [_scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 294)];

       
    }
    return YES;
}




#pragma mark toolbar for date picker
-(void)donePressed
{
    [_txtDate resignFirstResponder];
    [_txtLocation resignFirstResponder];
    [_txtRaceName resignFirstResponder];
    [_txtTime resignFirstResponder];
    [_txtLocation resignFirstResponder];
    [_txtTimeLimit resignFirstResponder];
    [_txtTypeofRace resignFirstResponder];
 
     [_scrollView setContentOffset:CGPointMake(0,0)];
    [_scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    
}

#pragma mark Date Picker 1

- (void)datePickerValueChanged:(id)sender
{
    // Date formatter for date picker

    dateformateDate.dateFormat = @"MMMM dd, yyyy";
    _txtDate.text = [NSString stringWithFormat:@"%@",
                     [dateformateDate stringFromDate:[_datePicker1 date]]];
    
//    _txtDate.text=strDate;
    
}

#pragma mark Date Picker 2

- (void)timePickerValueChanged:(id)sender
{
    NSLog(@"%@",[_datePicker2 date]);
    dateformateTime.dateFormat = @"hh:mm a";
    _txtTime.text = [NSString stringWithFormat:@"%@",
                     [dateformateTime stringFromDate:[_datePicker2 date]]];
}

- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnNextClicked:(id)sender
{
    [self.view endEditing:YES];
    [self Validator];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _txtTypeofRace.text=[_arrRace objectAtIndex:[_pickerRace selectedRowInComponent:0]];
    return [_arrRace objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==_pickerRace) {
        [_txtTypeofRace setText:[_arrRace objectAtIndex:row]];
    }
    
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



@end
