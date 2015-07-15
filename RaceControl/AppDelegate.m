//
//  AppDelegate.m
//  RaceControl
//
//  Created by peerbits_10 on 06/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "AppDelegate.h"
#import "Notification_master.h"
#import "Race_master.h"
#import "RaceViewController.h"
#import "RaceDetailsViewController.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
{
    
    NSMutableArray *unfinishedRaces;
}

@end

@implementation AppDelegate
{
    Race_master *Race_info;
    AVAudioPlayer *player;
}
@synthesize window,nav,backToHome,videopath;
//dax
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // Override point for customization after application launch.
    
    sleep(5);
    _Notificationtimetamp =0;
    
    _camefrmcompleterace =NO;
     checknotificationsound=YES;
     DELEGATE.camefrmnotification = NO;
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"notification"]) {
    
        Notification_master *obj = [Notification_master newInsertedObject];
        obj.badgecount=[NSNumber numberWithInt:0];
        [CoreDataUtils updateDatabase];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"notification"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
    }
    application.applicationIconBadgeNumber = 0;

    UILocalNotification *localNotification=[launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey];
    if(localNotification)
    {
        application.applicationIconBadgeNumber=0;
    }
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |
                                                                                             UIUserNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert
                                                            |
                                                                                             UIUserNotificationTypeAlert
                                                                ) categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIUserNotificationTypeSound | UIUserNotificationTypeAlert| UIUserNotificationTypeBadge;
        [application registerForRemoteNotificationTypes:myTypes];
    }

    _dateformateDate =[[NSDateFormatter alloc] init];

    if (launchOptions!=nil)
    {
        UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        if (notification != nil)
        {
            application.applicationIconBadgeNumber = 0;
            

            Notification_master *obj =[CoreDataUtils getObject:[Notification_master description]];

            int number =[obj.badgecount intValue];
            number=number+1;
            obj.badgecount=[NSNumber numberWithInt:number];
            [CoreDataUtils updateDatabase];

            _Raceid =[NSString stringWithFormat:@"%@",[notification.userInfo valueForKey:@"raceid"]];
            //  [infoDict setObject:Race_info.identifier forKey:@"raceid"];
            //  [infoDict setObject:@"0" forKey:@"isnotificationcheck"];

            NSDate *notificationDate=notification.fireDate;
            int Notification_timestamp=[notificationDate timeIntervalSince1970];
            int currentimestamp=[[NSDate date] timeIntervalSince1970];
            NSLog(@"%d",currentimestamp-Notification_timestamp+120);
//            if (currentimestamp>Notification_timestamp+120)
//            {
//
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Race Control" message:@"Race Already Completed" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//
//            }
//            else
//            {

                NSLog(@"%@",obj.badgecount);
                NSLog(@"%@",notification.alertBody);
                NSLog(@"%@",notification.fireDate);

                Popup=[[PopupView alloc] initWithNibName:@"PopupView" bundle:nil];

                Popup.view.frame=CGRectMake([UIScreen mainScreen].applicationFrame.origin.x, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+20);
                [Popup.btn_close addTarget:self action:@selector(touchup_close:) forControlEvents:UIControlEventTouchUpInside];
               // [Popup.lblRaceName setText:[NSString stringWithFormat:@"%@",[notification.userInfo valueForKey:@"racename"]]];
            
                [Popup.lblRaceName setText:[NSString stringWithFormat:@"%@",notification.alertBody]];
                [Popup.btn_gotorace addTarget:self action:@selector(Clickgotorace:) forControlEvents:UIControlEventTouchUpInside];
                [Popup.btn_racedetail addTarget:self action:@selector(Clickgotoracedetail:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.window addSubview:Popup.view];
                
                [application cancelLocalNotification:notification];
                
           // }

        }
        
        
    }

    return YES;
}


-(void)checkForUnfinished_PastRaces
{
    
    unfinishedRaces = [[NSMutableArray alloc]init];
    
    NSDate *currentDate = [NSDate date];
    
  
    
    currentDate = [currentDate dateByAddingTimeInterval:60];
    
    //NSLog(@"%@",currentDate);
    
    NSArray *array =[[NSArray alloc]init];
    //array =[CoreDataUtils getObjects:[Race_master description]];
    array = [CoreDataUtils getObjects:[Race_master description] withQueryString:@"(starttime >= %@ AND isboatadded = %@ AND racecomplete = %@)" queryArguments:@[currentDate,@"Y",@"N"] sortBy:nil];
    
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
            [unfinishedRaces addObject:[array objectAtIndex:i]];
            
            
        }
        
        
    }
    
    unfinishedRaces=[self convertToArray:unfinishedRaces];
 
    
}

//-(NSDate *)getRaceEndtime:(NSDate *)StartTime timeLimit:(NSString *)timeLimit
//{
//  
//    
//    
//    
//}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{

  //  if (checknotificationsound) {
    
  //  }
    
    
    Notification_master *obj =[CoreDataUtils getObject:[Notification_master description]];
    int number =[obj.badgecount intValue];
    number=number+1;
    obj.badgecount=[NSNumber numberWithInt:number];
    [CoreDataUtils updateDatabase];
    
    _Raceid =[NSString stringWithFormat:@"%@",[notification.userInfo valueForKey:@"raceid"]];
  //  [infoDict setObject:Race_info.identifier forKey:@"raceid"];
  //  [infoDict setObject:@"0" forKey:@"isnotificationcheck"];
    
    NSDate *notificationDate=notification.fireDate;
    
    
    int Notification_timestamp=[notificationDate timeIntervalSince1970];
    DELEGATE.Notificationtimetamp= Notification_timestamp;
    
    int currentimestamp=[[NSDate date] timeIntervalSince1970];
    NSLog(@"%d",currentimestamp-Notification_timestamp+120);


   
    NSLog(@"%@",obj.badgecount);
    NSLog(@"%@",notification.alertBody);
    NSLog(@"%@",notification.fireDate);
    
    NSLog(@"%@",self.nav.visibleViewController);
    NSLog(@"%@",self.window.rootViewController);
    
    UINavigationController *objNav=(UINavigationController *)self.window.rootViewController;
    
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
    {
        
    }
    else{
        
        if ([[notification.userInfo valueForKey:@"notificationno"]isEqualToString:@"2"]||[[notification.userInfo valueForKey:@"notificationno"]isEqualToString:@"3"])
        {
            
        }
        else{
        
            
            if ([[notification.userInfo valueForKey:@"istime"]isEqualToString:@"10"]) {
//                NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"sound1"
//                                                                          ofType:@"mp3"];
//                NSURL *soundFileURL = [NSURL URLWithString:soundFilePath];
//                player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
//                                                                error:nil];
                checkcounttime =10;
                timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(didUpdateTime) userInfo:nil repeats:YES];
                
                
                
                
            }
            else{
                NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"ShortBeep"
                                                                          ofType:@"mp3"];
                NSURL *soundFileURL = [NSURL URLWithString:soundFilePath];
                player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                error:nil];
                if ([player prepareToPlay]) {
                    [player play];
                }
            
            }


            
        }
        
        
        
        
    
        if([objNav.visibleViewController isKindOfClass:[RaceViewController class]])
        {
            NSLog(@"asd");
        }
        else{
            
            Popup=[[PopupView alloc] initWithNibName:@"PopupView" bundle:nil];
            
            Popup.view.frame=CGRectMake([UIScreen mainScreen].applicationFrame.origin.x, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+20);
            [Popup.btn_close addTarget:self action:@selector(touchup_close:) forControlEvents:UIControlEventTouchUpInside];
            //[Popup.lblRaceName setText:[NSString stringWithFormat:@"%@",[notification.userInfo valueForKey:@"racename"]]];
            
            [Popup.lblRaceName setText:[NSString stringWithFormat:@"%@",notification.alertBody]];
            
            [Popup.btn_gotorace addTarget:self action:@selector(Clickgotorace:) forControlEvents:UIControlEventTouchUpInside];
            [Popup.btn_racedetail addTarget:self action:@selector(Clickgotoracedetail:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.window addSubview:Popup.view];
            
        }
    }

    [application cancelLocalNotification:notification];
    // AudioServicesPlaySystemSound(1002);


        
//    }

    // Set icon badge number to zero
 
}
-(void)didUpdateTime{

    checkcounttime--;
    if (checkcounttime == 0) {
        
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"LongBeep"
                                                                  ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL URLWithString:soundFilePath];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                        error:nil];
        if ([player prepareToPlay]) {
            [player play];
        }
        
       
        [timer invalidate];
        
    }
    else{
    
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"ShortBeep"
                                                                  ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL URLWithString:soundFilePath];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                        error:nil];
        if ([player prepareToPlay]) {
            [player play];
        }
    }
    
    
    
}
- (IBAction)touchup_close:(id)sender
{
    [self checkNotificationcount];
    for (UIView *view in self.window.subviews) {
        
        if (view.tag == 50) {
            [view removeFromSuperview];
        }
        
    }
}

- (IBAction)Clickgotorace:(id)sender
{
    
    [self checkNotificationcount];
    
    DELEGATE.camefrmnotification = YES;
    UIStoryboard *Mainstorybard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.nav=[Mainstorybard instantiateViewControllerWithIdentifier:@"navigation2"];
    self.window.rootViewController=self.nav;

    //[self.nav pushViewController: animated:YES];
    
}
- (IBAction)Clickgotoracedetail:(id)sender
{
    
    [self checkNotificationcount];
    
    
    DELEGATE.camefrmnotification = YES;
    
    UIStoryboard *Mainstorybard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.nav=[Mainstorybard instantiateViewControllerWithIdentifier:@"navigation3"];
    self.window.rootViewController=self.nav;
 
}


-(void)checkNotificationcount{
    
    Notification_master *obj =[CoreDataUtils getObject:[Notification_master description]];
    int number =[obj.badgecount intValue];
    number=number-1;
    obj.badgecount=[NSNumber numberWithInt:number];
    [CoreDataUtils updateDatabase];
    
    
    DELEGATE.COREIDENTIFIER=@"identifier";
    DELEGATE.QUERY_IDENTIFIER =@"identifier = %d";
    NSArray *array =[[NSArray alloc] init];
    array = [CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"identifier = %@" queryArguments:@[_Raceid] sortBy:nil];
    NSMutableArray *arr =[[NSMutableArray alloc] initWithArray:array];
    
    Race_info =[arr objectAtIndex:0];
    Race_info.notificationStatus=@"1";
    [CoreDataUtils updateDatabase];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index {


}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIApplication  *app = [UIApplication sharedApplication];
    UIBackgroundTaskIdentifier bgTask;
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        
        
        
        NSTimeInterval ti = [[UIApplication sharedApplication]backgroundTimeRemaining];
        NSLog(@"backgroundTimeRemaining: %f", ti);
        
        // just for debug
    }];

    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     checknotificationsound =NO;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
    checknotificationsound =YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//MEthod to trim whitspaces
-(NSString*)trimWhiteSpaces:(NSString*)text{
    return  [text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSString *)convertDateToStringformat:(NSDate *)Date{
    
    _dateformateDate.dateFormat = @"dd/MM/yyyy";
    NSString *strDate = [NSString stringWithFormat:@"%@",
                         [_dateformateDate stringFromDate:Date]];
    
    return strDate;
}
-(NSString *)convertDateToFullStringformat:(NSDate *)Date{
    
    _dateformateDate.dateFormat = @"HH:mm";
    NSString *strDate = [NSString stringWithFormat:@"%@",
                         [_dateformateDate stringFromDate:Date]];
    
    return strDate;
}


-(NSString *)convertDateTotime:(NSDate *)Date{

    _dateformateDate.dateFormat = @"HH:mm";
    NSString *strDate = [NSString stringWithFormat:@"%@",
                         [_dateformateDate stringFromDate:Date]];
    NSLog(@"%@",strDate);
    
    return strDate;
}
-(NSString *)convertDateToString:(NSDate *)Date{

   
    _dateformateDate.dateFormat = @"MMMM dd,yyyy";
    NSString *strDate = [NSString stringWithFormat:@"%@",
                     [_dateformateDate stringFromDate:Date]];
    
    return strDate;
}
-(NSString *)convertDateToStringwith3charchter:(NSDate *)Date{
    
    
    _dateformateDate.dateFormat = @"MMM dd,yyyy";
    NSString *strDate = [NSString stringWithFormat:@"%@",
                         [_dateformateDate stringFromDate:Date]];
    
    return strDate;
}

-(NSMutableArray *)convertToArray:(NSArray *)Data
{
    
    NSMutableArray *ConvertedData;
    ConvertedData=[[NSMutableArray alloc]init];
    
    NSLog(@"%@",Data);
    
    if ([Data count]>0)
    {
        for (int i=0;i<[Data count];i++)
        {
            
            NSArray *keys = [[[[Data objectAtIndex:i] entity] attributesByName] allKeys];
            NSDictionary *dict = [[Data objectAtIndex:i] dictionaryWithValuesForKeys:keys];
            
            [ConvertedData addObject:dict];
            
            
        }
        
    }
    else
    {
        ConvertedData=[[NSMutableArray alloc]init];
        
    }
    
 
    
     NSLog(@"%@",ConvertedData);
    return ConvertedData;
    
}

- (BOOL)isSameDay:(NSDate*)date45 otherDay:(NSDate*)date46 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date45];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date46];
    NSLog(@"%ld ===>%ld",(long)[comp1 day],(long)[comp2 day]);
   // long same = [comp2 day] - [comp1 day];
    return (([comp1 day]   == [comp2 day] &&
             [comp1 month] == [comp2 month] &&
             [comp1 year]  == [comp2 year]));
}
@end
