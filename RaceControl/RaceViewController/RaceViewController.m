//
//  RaceViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "RaceViewController.h"
#import "RaceDetailCollectionCell.h"
#import "RaceResultController.h"

#import "Race_boat.h"
#import "Race_master.h"
#import "Boat_master.h"
#import "Race_result.h"
static void *AVPlayerDemoPlaybackViewControllerStatusObservationContext = &AVPlayerDemoPlaybackViewControllerStatusObservationContext;

@interface RaceViewController ()
{
    NSString *csvpath;
    NSString *csvName;
    
    int uppertimecount;
    
    AVCaptureVideoPreviewLayer* preview;
    
    BOOL iscaturestart;
    BOOL isselect;
    int totalBoats;
  
}

@end

@implementation RaceViewController

{
    
    NSMutableArray *aryBoatNo;
    NSMutableArray *aryBoatName;
    NSMutableArray *arrTempry;
    NSMutableArray *arrCsvData;
    NSMutableArray *finalArray;
    NSMutableArray *arrboatinfo;
    NSMutableArray *avgArray;
    
    int FinalTag;
    int checktag;
    NSMutableArray *arrtagremaing;
    
    Boat_master *boat_info;
    Race_boat *raceboat_info;
    Race_master *race_info;
    Race_result *raceResult_info;
   // NSMutableArray *arrBoatEntity;
    NSMutableArray *arrConvertedData;
    NSMutableArray *arrNewTmp;
    NSMutableArray *arrBoatid;
    NSMutableArray *arrskipper;
    NSArray *arrTemp;
    int raceTag;
    int senderTag;
    BOOL isSelected;
    BOOL isSetTimer;
    NSIndexPath *indexPaths;
    
   
    double secondreaming;
    NSString *strracetime;
    
    double timeleft;
}
@synthesize strId;


static NSString * const reuseIdentifier = @"RaceDetailCollectionCell";


-(void)viewDidLoad {
    
    [super viewDidLoad];

    self.btnRecord.enabled=YES;
    self.btnStop.enabled=NO;
    self.btnPause.enabled=NO;
    
    self.btnPause.titleLabel.text=@"Pause";
    
    secondsLeft=300;
    captureplay=0;
 
    self.btnRaceComplete.enabled=NO;
    
    csvpath=[[NSString alloc]init];
    csvName=[[NSString alloc]init];
    arrboatinfo =[[NSMutableArray alloc] init];
    arrtagremaing =[[NSMutableArray alloc] init];
    
    [self dataFilePath];
    
    FinalTag=1;
    
    NSLog(@"%@",arrNewTmp);
    raceTag=0;
    secondreaming=0;
    
    [_btnDownArrow setHidden:YES];
    [self.collectionRaceView registerNib:[UINib nibWithNibName:@"RaceDetailCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"RaceDetailCollectionCell"];
    //    NSLog(@"%@",strId);
    

    
    
    if (DELEGATE.camefrmnotification)
    {
        strId =DELEGATE.Raceid;
    }
 
    arrCsvData =[[NSMutableArray alloc] init];
    NSArray *arrracetemp =[[NSArray alloc]init];
    arrracetemp =[CoreDataUtils RelationgetObject:[Race_boat description] withQueryString:@"(race_id = %@)" queryArguments:@[strId] sortBy:nil];
    NSMutableArray *addracetemp =[[NSMutableArray alloc] initWithArray:[DELEGATE convertToArray:arrracetemp]];
    NSLog(@"%@",addracetemp);
    
    
    finalArray = [[NSMutableArray alloc] init];
    // NSString *strboatidlist =[[NSString alloc] init];
    for (int i=0; i<addracetemp.count; i++)
    {
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        NSArray *array2 =[[NSArray alloc]init];
        array2 =[CoreDataUtils getObjects:[Race_result description]withQueryString:@"(boat_id = %@)" queryArguments:@[[[addracetemp objectAtIndex:i]valueForKey:@"boat_id"]] sortBy:nil];
        NSLog(@"%@",array2);
        
        Race_result *raceResult;
        int sum = 0;
        for (int j = 0; j< array2.count ; j++)
        {
            raceResult = [array2 objectAtIndex:j];
            sum = sum+[raceResult.place intValue];
            
        }
        
        
        
        Boat_master *boatMaster = [CoreDataUtils getObject:[Boat_master description]withQueryString:@"(identifier = %@)" queryArguments:@[[[addracetemp objectAtIndex:i]valueForKey:@"boat_id"]] sortBy:nil];
        if (array2.count>0)
        {
            float avg = sum/array2.count;
            [dict setValue:boatMaster.skipper forKey:@"skipper"];
            [dict setValue:boatMaster.sailno forKey:@"sailno"];
            [dict setValue:boatMaster.identifier forKey:@"identifier"];
            [dict setValue:boatMaster.name forKey:@"name"];
            [dict setValue:boatMaster.boatno forKey:@"boatno"];
            [dict setObject:[NSString stringWithFormat:@"%f",avg] forKey:@"avg"];
            [dict setValue:[NSString stringWithFormat:@"%lu",(unsigned long)array2.count] forKey:@"count"];
            
        }
        else
        {
            [dict setValue:boatMaster.skipper forKey:@"skipper"];
            [dict setValue:boatMaster.sailno forKey:@"sailno"];
            [dict setValue:boatMaster.identifier forKey:@"identifier"];
            [dict setValue:boatMaster.name forKey:@"name"];
            [dict setValue:boatMaster.boatno forKey:@"boatno"];
            [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"avg"];
            [dict setValue:[NSString stringWithFormat:@"%lu",(unsigned long)array2.count] forKey:@"count"];
        }
        
        
        
        [finalArray addObject:dict];
        
        
    }
    //    NSMutableDictionary *dict = [NSMutableDictionary new];
    //
    //    [dict setObject:[NSString stringWithFormat:@"1.00000"] forKey:@"avg"];
    //    [dict setValue:[NSString stringWithFormat:@"3"] forKey:@"count"];
    //
    //    [finalArray addObject:dict];
    NSLog(@"%@",finalArray);
    
    
    
    NSArray *avgArr = [[NSArray alloc] init];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"avg" ascending:YES ];
    NSSortDescriptor *sort2= [NSSortDescriptor sortDescriptorWithKey:@"count" ascending:YES ];
    
    avgArr = [finalArray sortedArrayUsingDescriptors:@[sort1, sort2]];
    NSLog(@"%@",avgArray);
    avgArray =[[NSMutableArray alloc] initWithArray:avgArr];
    NSLog(@"%@",avgArray);
    
    
    
    
    arrBoatid =[[NSMutableArray alloc] init];
    arrskipper =[[NSMutableArray alloc] init];
    aryBoatNo =[[NSMutableArray alloc] init] ;
    aryBoatName =[[NSMutableArray alloc] init];
    //  NSMutableArray *arrRaceBoat =[[NSMutableArray alloc] initWithArray:array];
    arrTempry =[[NSMutableArray alloc] init];
    
    for (int i =0; i<avgArray.count; i++) {
        
        
        [arrskipper addObject:[[avgArray objectAtIndex:i] valueForKey:@"skipper"]];
        [arrTempry addObject:[[avgArray objectAtIndex:i] valueForKey:@"sailno"]];
        [aryBoatName addObject:[[avgArray objectAtIndex:i] valueForKey:@"name"]];
        [aryBoatNo addObject:[[avgArray objectAtIndex:i] valueForKey:@"boatno"]];
        [arrBoatid addObject:[[avgArray objectAtIndex:i] valueForKey:@"identifier"]];
        
    }
    
    
    

 //   arrTempry=[[NSMutableArray alloc]initWithObjects:@"111",@"222",@"333",@"444",@"555", nil];
    
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"N",@"isSelected", nil];
    
    arrNewTmp=[[NSMutableArray alloc]init];
    
    
    for (int i=0;i< [arrTempry count]; i++)
    {
        [arrNewTmp addObject:[dict mutableCopy]];
    }
 
    NSArray *arr =[[NSArray alloc]init];
    arr =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(identifier = %@)" queryArguments:@[strId] sortBy:nil];
    race_info =[arr objectAtIndex:0];
    
    arrConvertedData =[[NSMutableArray alloc]initWithObjects:race_info, nil];
    
    
    NSString *strTemp=[NSString stringWithFormat:@"%@",[[arrConvertedData objectAtIndex:0]valueForKey:@"starttime"]];
    
    _lblRaceName.text=[NSString stringWithFormat:@"%@",[[arrConvertedData objectAtIndex:0]valueForKey:@"name"]];
    _lblTotalBoats.text=[NSString stringWithFormat:@"Boats: %lu",(unsigned long)[arrTempry count]];
    
    totalBoats=(int)arrTempry.count;
    
    
     NSDate *timeofDate =race_info.starttime;
    
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"HH:mm"];
    
    NSString *strTime=[df stringFromDate:timeofDate];
    
  
    _lblDate.text=[NSString stringWithFormat:@"%@ %@",[strTemp substringToIndex:10],strTime];
    
    
    _lblDuration.text=[NSString stringWithFormat:@"Time Limit:%@",[[arrConvertedData objectAtIndex:0]valueForKey:@"timelimit"]];
    
    
    strracetime =[NSString stringWithFormat:@"%@",[[arrConvertedData objectAtIndex:0]valueForKey:@"timelimit"]];
    


    NSLog(@"%@",strracetime);
    
    // NSLog(@"%@",race_info.starttime);
    
    NSDate *RaceDate =race_info.starttime;
    
    NSDateComponents *comp1 = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:RaceDate];
    RaceDate = [RaceDate dateByAddingTimeInterval:-comp1.second];
    
    NSDate *Today=[NSDate date];
    
    NSTimeInterval distanceBetweenDates = [RaceDate timeIntervalSinceDate:Today];
    
    timeleft=(int)distanceBetweenDates;
    
    NSLog(@"%f",timeleft);
    
    uppertimecount =[race_info.timelimit intValue]*60;
    
    NSLog(@"%d",uppertimecount);
    
    
    
    //******* Remaining Seconds for Race
    if (timeleft>0)
    {
        
        isSetTimer=NO;
        ischecktime =NO;
        
   

           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
               [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
               
               _timerleft = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateRaceCountdown) userInfo:nil repeats: YES];
               
               [[NSRunLoop mainRunLoop] addTimer:_timerleft forMode:NSRunLoopCommonModes];

               
               
                  });
        
        
        

    }
    else{
    
       // NSString *strtime =[NSString stringWithFormat:@"00:00:00"];
       // _lbltimeleft.text = strtime;
        
        
        isSetTimer=YES;
        [self.collectionRaceView reloadData];
        secondreaming =labs(timeleft);
        NSLog(@"%f",secondreaming);
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
        {
            
            
            [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
            _racetimeleft = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
            [[NSRunLoop mainRunLoop] addTimer:_racetimeleft forMode:NSRunLoopCommonModes];

            
            
        });
        
        
        
        ischecktime =YES;
        timeleft =labs(timeleft);
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           
                           
                           [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
                           _timerleft = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateRaceCountdown) userInfo:nil repeats: YES];
                           
                           [[NSRunLoop mainRunLoop] addTimer:_timerleft forMode:NSRunLoopCommonModes];
                           
                           
                       });
        
        
        
        
        
        
   
        

    }
    
    self.backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        //end the background task
        
        NSLog(@"Background handler called. Not running background tasks anymore.");
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTask];
        self.backgroundTask = UIBackgroundTaskInvalid;
    }];
    
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
    
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect newFrame = self.customCompleteRaceView.frame;
    newFrame.origin.y = 1500;
    self.customCompleteRaceView.frame = newFrame;
    isselect =NO;
    DELEGATE.videopath=@"";
    
    [self.btnPause setHidden:NO];
    [self.btnRecord setHidden:NO];
    [self.btnStop setHidden:NO];
    
    iscaturestart =NO;
    BOOL hasCamera = ([[AVCaptureDevice devices] count] > 0);
    
    if (hasCamera) {
        [[CameraEngine engine] startup];
        
        preview = [[CameraEngine engine] getPreviewLayer];
        
        [[[CameraEngine engine] _session]startRunning];
        
        preview.frame=CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,self.view_Video.frame.size.height);
        
        
        if([[preview connection] isVideoOrientationSupported]) // **Here it is, its always false**
        {
            
            [[preview connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
        }
        
        [self.view_Video.layer addSublayer:preview];
        [self.view_Video.layer addSublayer:self.btnPause.layer];
        [self.view_Video.layer addSublayer:self.btnRecord.layer];
        [self.view_Video.layer addSublayer:self.btnStop.layer];
    }
}

#pragma mark Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrTempry count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"RaceDetailCollectionCell";
    RaceDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    

    indexPaths=indexPath;
    
    if (isSetTimer==YES)
    {
        [cell.btnRacer setUserInteractionEnabled:YES];
    }
    else{
        [cell.btnRacer setUserInteractionEnabled:NO];
        
    }
    
    
    [cell.btnRacer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[cell.btnRacer.titleLabel setFont:FONT_Regular(16)];
    
    cell.btnRacer.tag = indexPath.row;
    
    
    
    NSString *strSelected=[NSString stringWithFormat:@"%@",[[arrNewTmp objectAtIndex:indexPath.row] valueForKey:@"isSelected"]];
    
    if ([strSelected isEqualToString:@"Y"])
    {
        [cell.btnRacer setUserInteractionEnabled:NO];
        [cell.imgFlag setImage:[UIImage imageNamed:@"imgFlagwithButton"]];
         [cell.btnRacer.titleLabel setTextAlignment:NSTextAlignmentCenter];
        cell.lblBoatNo.attributedText =[arrTempry objectAtIndex:indexPath.row];
    }
    else
    {
        cell.lblBoatNo.text =[NSString stringWithFormat:@"%@",[arrTempry objectAtIndex:indexPath.row]];
         [cell.btnRacer.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.imgFlag setImage:[UIImage imageNamed:@""]];
        [cell.imgFlag setBackgroundColor:[UIColor colorWithRed:47.0/255.0 green:113.0/255.0 blue:179.0/255.0 alpha:1.0]];
    }
    
    
    /*if ([[[NSString stringWithFormat:@"%@",[arrTempry objectAtIndex:indexPath.row]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]containsString:@"    "])
     {
     
     NSLog(@"%@",[[NSString stringWithFormat:@"%@",[arrTempry objectAtIndex:indexPath.row]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]);
     
     [cell.btnRacer setUserInteractionEnabled:NO];
     [cell.imgFlag setImage:[UIImage imageNamed:@"imgFlagwithButton"]];
     
     
     }
     else if ([[[NSString stringWithFormat:@"%@",[arrTempry objectAtIndex:indexPath.row]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]containsString:@"  "]){
     
     [cell.btnRacer setUserInteractionEnabled:NO];
     [cell.imgFlag setImage:[UIImage imageNamed:@"imgFlagwithButton"]];
     }
     else
     {
     [cell.imgFlag setImage:[UIImage imageNamed:@""]];
     [cell.imgFlag setBackgroundColor:[UIColor colorWithRed:47.0/255.0 green:113.0/255.0 blue:179.0/255.0 alpha:1.0]];
     }*/
    
    
  //  [cell.btnRacer setTitle:[NSString stringWithFormat:@"%@",[arrTempry objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
   // cell.lblBoatNo.attributedText =[NSString stringWithFormat:@"%@",[arrTempry objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    
  
   // cell.btnRacer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
  //  cell.btnRacer.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    
    [cell.btnRacer addTarget:self action:@selector(btnRacerClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(IBAction)btnDisplayresultClicked:(UIButton *)sender
{
    
    if (isSetTimer==YES)
    {
       
        if (FinalTag!=1) {
            
            if (FinalTag-1 != [arrTempry count])
            {
               // [timer invalidate];
               // timer =nil;
                [_racetimeleft invalidate];
                _racetimeleft =nil;
                [[CameraEngine engine] stopCapture];
                
                
                
                
                
                if (arrTempry.count != arrtagremaing.count) {
                    
                    for (int i=0;i<arrTempry.count; i++) {
                        
                        
                        NSString *strSelected=[NSString stringWithFormat:@"%@",[[arrNewTmp objectAtIndex:i] valueForKey:@"isSelected"]];
                        
                        if ([strSelected isEqualToString:@"N"])
                        {
                            NSArray *arr =[[NSArray alloc]init];
                            arr =[CoreDataUtils RelationgetObject:[Race_result description] withQueryString:@"(race_id = %@)" queryArguments:@[strId] sortBy:nil];
                            raceResult_info = [Race_result newInsertedObject];
                            raceResult_info.identifier = @([CoreDataUtils getNextID:[Race_result description]]);
                            
                            NSLog(@"%@",csvName);
                            
                            
                            
                            
                            raceResult_info.csv_path=[NSString stringWithFormat:@"%@",csvName];
                            
                            raceResult_info.boat_id =[arrBoatid objectAtIndex:i];
                           // raceResult_info.place =[NSString stringWithFormat:@"%d",FinalTag];
                            raceResult_info.place =@"DNF";
                            raceResult_info.race_id = [NSNumber numberWithInt:[strId intValue]];
                            raceResult_info.time =[NSString stringWithFormat:@"DNF"];
                            raceResult_info.sailno =[arrTempry objectAtIndex:i];
                            raceResult_info.skipper =[arrskipper objectAtIndex:i];
                            [CoreDataUtils updateDatabase];
                            
                            
                            NSString *strtime =@"DNF";
                            
                            
                            NSMutableDictionary *dict1 =[[NSMutableDictionary alloc] init];
                            [dict1 setObject:raceResult_info.identifier forKey:@"id"];
                            [dict1 setObject:raceResult_info.sailno forKey:@"sailno"];
                            [dict1 setObject:raceResult_info.skipper forKey:@"skipper"];
                            [dict1 setObject:@"00:00:00" forKey:@"time"];
                            [dict1 setObject:raceResult_info.place forKey:@"place"];
                            [dict1 setObject:[NSString stringWithFormat:@"%d",totalBoats] forKey:@"points"];
                            
                            [arrCsvData addObject:dict1];
                            FinalTag++;
                            
                        }
                        
                        
                        

                        
                    }
                    
                }
                
                
                
                NSString *str =DELEGATE.videopath;
                
                NSLog(@"%@",DELEGATE.videopath);
                NSArray *arr =[[NSArray alloc] init];
                
                arr =[CoreDataUtils RelationgetObject:[Race_result description] withQueryString:@"(race_id = %@)" queryArguments:@[strId] sortBy:nil];
                
                //NSLog(@"%@",[DELEGATE convertToArray:arr]);
                if (arr.count>0) {
                    
                    raceResult_info =[arr objectAtIndex:0];
                    NSLog(@"%@",csvName);
                    
                    raceResult_info.csv_path=[NSString stringWithFormat:@"%@",csvName];
                    raceResult_info.video_path=[NSString stringWithFormat:@"%@",str];
                    [CoreDataUtils updateDatabase];
                }
                else{
                    
                }
                
                
                self.btnRaceComplete.enabled=YES;
                
                [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.customCompleteRaceView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    _lblCustomRaceName.text = [NSString stringWithFormat:@"%@",_lblRaceName.text];
                } completion:^(BOOL finished)
                 {}];
                
              //  DELEGATE.videopath=@"";
            }
            
            NSArray *arr =[[NSArray alloc] init];
            
            arr =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(identifier = %@)" queryArguments:@[strId] sortBy:nil];
            
            NSLog(@"%@",[DELEGATE convertToArray:arr]);
            
            race_info =[arr objectAtIndex:0];
            
            race_info.racecomplete=@"Y";
            
            [CoreDataUtils updateDatabase];
            
            UIApplication *app = [UIApplication sharedApplication];
            NSArray *eventArray = [app scheduledLocalNotifications];
            if (eventArray.count>0) {
                for (int i=0; i<[eventArray count]; i++)
                {
                    UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
                    NSDictionary *userInfoCurrent = oneEvent.userInfo;
                    NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"raceid"]];
                    if ([uid isEqualToString:strId])
                    {
                        //Cancelling local notification
                        [app cancelLocalNotification:oneEvent];
                    }
                }
            }
            
            [_racetimeleft invalidate];
            _racetimeleft =nil;
            
            [self createdatabase];
            
            
            
            RaceResultController *raceResult=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceResultController"];
            
            raceResult.gettedCsvPath=[[NSString alloc]init];
            
            NSLog(@"%@",csvpath);
            
            raceResult.gettedCsvPath=[NSString stringWithFormat:@"%@",csvName];
            
            [raceResult setRaceId:strId];
            
            [raceResult setStrRacename: _lblRaceName.text];
            [raceResult setStrRacetime:_lblDuration.text];
            
            [CoreDataUtils updateDatabase];
            
            [self.navigationController pushViewController:raceResult animated:YES];
            
        }
        
        
 
    }

}

-(IBAction)btnRacerClicked:(UIButton *)sender
{
    NSLog(@"%d",(int)sender.tag);
    NSLog(@"%@",[arrTempry objectAtIndex:sender.tag]);
    senderTag=(int)sender.tag;
    
    [arrtagremaing addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    DELEGATE.COREIDENTIFIER=@"identifier";
    DELEGATE.QUERY_IDENTIFIER =@"identifier =%d";
    
    
    NSArray *arr =[[NSArray alloc]init];
    arr =[CoreDataUtils RelationgetObject:[Race_result description] withQueryString:@"(race_id = %@)" queryArguments:@[strId] sortBy:nil];
    
//    NSLog(@"%d",(int)[arr count]);
//    
//    NSLog(@"%@",[DELEGATE convertToArray:arr]);
//    
//    
//    
//    if ((int)[arr count]>0)
//    {
//        
//       
//    }
//    else
//    {
        raceResult_info = [Race_result newInsertedObject];
        raceResult_info.identifier = @([CoreDataUtils getNextID:[Race_result description]]);
    
        NSLog(@"%@",csvName);
    
        raceResult_info.csv_path=[NSString stringWithFormat:@"%@",csvName];
    
        raceResult_info.boat_id =[arrBoatid objectAtIndex:sender.tag];
        raceResult_info.place =[NSString stringWithFormat:@"%d",FinalTag];
        raceResult_info.race_id = [NSNumber numberWithInt:[strId intValue]];
        raceResult_info.time =[NSString stringWithFormat:@"%.03f",secondreaming];
        raceResult_info.sailno =[arrTempry objectAtIndex:sender.tag];
        raceResult_info.skipper =[arrskipper objectAtIndex:sender.tag];
        [CoreDataUtils updateDatabase];
        

   // }
    int hours,mins,sec;
    hours =((int)secondreaming/3600);
    mins = ((int)secondreaming/ 60) % 60;
    sec = (int)secondreaming % 60;
    
    NSLog(@"%02d",sec);
    NSLog(@"%02d",mins);
    NSLog(@"%02d",hours);
    
    NSString *strtime =[NSString stringWithFormat:@"%02d:%02d:%02d",hours,mins,sec];
    

    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc] init];
    [dict1 setObject:raceResult_info.identifier forKey:@"id"];
    [dict1 setObject:raceResult_info.sailno forKey:@"sailno"];
    [dict1 setObject:raceResult_info.skipper forKey:@"skipper"];
    [dict1 setObject:strtime forKey:@"time"];
    [dict1 setObject:raceResult_info.place forKey:@"place"];
    
    if ([raceResult_info.place isEqualToString:@"DNF"])
    {
    
        [dict1 setObject:[NSString stringWithFormat:@"%d",totalBoats]forKey:@"points"];
        
    }
    else
    {
        
       
        [dict1 setObject:raceResult_info.place forKey:@"points"];
        
        
    }

   
    [arrCsvData addObject:dict1];

    NSString *strname=[NSString stringWithFormat:@"%@",[arrTempry objectAtIndex:senderTag]];
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"Y",@"isSelected", nil];
    
    NSString *strTag=[NSString stringWithFormat:@"0%d",FinalTag];
   // NSString *strTitle=[strTag stringByAppendingString:[NSString stringWithFormat:@"    %@",strname]];
    
    UIFont *Ubuntufont1 = [UIFont fontWithName:@"Ubuntu" size:22.0];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:Ubuntufont1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:strTag attributes:arialDict];
    
    UIFont *Ubuntufont2 = [UIFont fontWithName:@"Ubuntu" size:16.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:Ubuntufont2 forKey:NSFontAttributeName];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"   %@",strname] attributes:verdanaDict];
    //[vAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:(NSMakeRange(0, 15))];
    
    //[vAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    [aAttrString appendAttributedString:vAttrString];
    
   

    [arrTempry replaceObjectAtIndex:sender.tag withObject:aAttrString];
    [arrNewTmp replaceObjectAtIndex:sender.tag withObject:dict];
    
    
    if (FinalTag == [arrTempry count])
    {
       // [timer invalidate];
       // timer =nil;
        [_racetimeleft invalidate];
        _racetimeleft =nil;
        [[CameraEngine engine] stopCapture];
        NSString *str =[NSString stringWithFormat:@"%@",DELEGATE.videopath];
       // NSLog(@"%@",DELEGATE.videopath);
        NSArray *arr =[[NSArray alloc] init];
        
        arr =[CoreDataUtils RelationgetObject:[Race_result description] withQueryString:@"(race_id = %@)" queryArguments:@[strId] sortBy:nil];
        
        //NSLog(@"%@",[DELEGATE convertToArray:arr]);
      
        raceResult_info =[arr objectAtIndex:0];
        
         NSLog(@"%@",csvName);
        
        raceResult_info.csv_path=[NSString stringWithFormat:@"%@",csvName];
      
        NSLog(@"%@",DELEGATE.videopath);
        raceResult_info.video_path=[NSString stringWithFormat:@"%@",str];
        [CoreDataUtils updateDatabase];

        
       
        self.btnRaceComplete.enabled=YES;
        
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.customCompleteRaceView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            _lblCustomRaceName.text = [NSString stringWithFormat:@"%@",_lblRaceName.text];
        } completion:^(BOOL finished)
         {}];
        
        //DELEGATE.videopath=@"";
    }
    FinalTag++;
    
    
    [self.collectionRaceView reloadData];
}



#pragma mark collection view cell delegate

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if ([UIScreen mainScreen].bounds.size.width==375)
    {
        return UIEdgeInsetsMake(10,10,10,10);
    }
    else if([UIScreen mainScreen].bounds.size.width==414)
    {
        return UIEdgeInsetsMake(10,10,10,10);
    }
    else
    {
        return UIEdgeInsetsMake(10,10,10,10);// top, left, bottom, right
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UIScreen mainScreen].bounds.size.width==375)
    {
        return CGSizeMake(172, 56);
    }
    else if ([UIScreen mainScreen].bounds.size.width==414)
    {
        return CGSizeMake(191, 56);
    }
    else if ([UIScreen mainScreen].bounds.size.height==568)
    {
        return CGSizeMake(145, 56);
    }
    else
    {
        return CGSizeMake(145, 56);
    }
}

#pragma mark Button Actions


- (IBAction)clickAddVideo:(id)sender
{
    
//    DELEGATE.videopath=@"";
//    
//    [self.btnPause setHidden:NO];
//    [self.btnRecord setHidden:NO];
//    [self.btnStop setHidden:NO];
//    
//    preview = [[CameraEngine engine] getPreviewLayer];
//    
//    [[[CameraEngine engine] _session]startRunning];
//    
//    preview.frame=CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,self.view_Video.frame.size.height);
//    
//    
//    if([[preview connection] isVideoOrientationSupported]) // **Here it is, its always false**
//    {
//        
//        [[preview connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
//    }
//    
//    [self.view_Video.layer addSublayer:preview];
//    [self.view_Video.layer addSublayer:self.btnPause.layer];
//    [self.view_Video.layer addSublayer:self.btnRecord.layer];
//    [self.view_Video.layer addSublayer:self.btnStop.layer];
    
}


- (IBAction)clickRecord:(UIButton*)sender
{
    
    if (isselect) {
        isselect =NO;
        [self.btnRecord setBackgroundImage:[UIImage imageNamed:@"playrace"] forState:UIControlStateNormal];
        [self.btnPause setHidden:NO];
        [self.btnRecord setHidden:NO];
        [self.btnStop setHidden:NO];
        
        self.btnRecord.enabled=YES;
        self.btnStop.enabled=YES;
        self.btnPause.enabled=YES;
        
        
       // [timer invalidate];
        self.btnPause.tag=10;
        NSLog(@"%d",secondsLeft);
        
        [[CameraEngine engine] pauseCapture];
        NSLog(@"%@",DELEGATE.videopath);

    }
    else{
        isselect =YES;
        self.btnRecord.enabled=YES;
        self.btnStop.enabled=YES;
        self.btnPause.enabled=YES;
        
        [self.btnPause setHidden:NO];
        [self.btnRecord setHidden:NO];
        [self.btnStop setHidden:NO];
        
       // timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [self.btnRecord setBackgroundImage:[UIImage imageNamed:@"STOP"] forState:UIControlStateNormal];
        
        if (iscaturestart) {
            [[CameraEngine engine] resumeCapture];
        }
        else{
        
            [[CameraEngine engine] startCapture];
            iscaturestart=YES;
        }

    }
 
}


//-(void)updateTime
//{
//    int  minutes, seconds;
//    secondsLeft--;
//    
//    minutes = (secondsLeft % 3600) / 60;
//    seconds = (secondsLeft %3600) % 60;
//    _lblduration.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
//    
//    if (secondsLeft<=0)
//    {
//        
//        [timer invalidate];
//        
//        self.btnRecord.enabled=YES;
//        self.btnStop.enabled=YES;
//        self.btnPause.enabled=YES;
//        
//        [self.btnPause.titleLabel setText:@"Pause"];
//        
//        //stop the capture
//        [[CameraEngine engine] stopCapture];
//        
//        NSLog(@"%@",DELEGATE.videopath);
//        
//        [self.btnPause setHidden:YES];
//        [self.btnRecord setHidden:YES];
//        [self.btnStop setHidden:YES];
//        
//    }
//    else
//    {
//        
//        
//        NSLog(@"%d,vide Remaining Time",secondsLeft);
//        
//        
//    }
//    
//    
//}

- (IBAction)clickPause:(id)sender
{
    
    
    
//    [self.btnPause setHidden:NO];
//    [self.btnRecord setHidden:NO];
//    [self.btnStop setHidden:NO];
//    
//    self.btnRecord.enabled=NO;
//    self.btnStop.enabled=YES;
//    self.btnPause.enabled=YES;
//    
//    
//    
//    if (self.btnPause.tag ==10)
//    {
//        NSLog(@"%d",secondsLeft);
//        self.btnPause.tag=1;
//        
//        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
//        [[CameraEngine engine] resumeCapture];
//        
//    }
//    else
//    {
//        [timer invalidate];
//        self.btnPause.tag=10;
//        NSLog(@"%d",secondsLeft);
//        
//        [[CameraEngine engine] pauseCapture];
//        
//    }
//    
//    if (self.btnPause.tag==10)
//    {
//       
//       // [self.btnPause setTitle: @"Resume" forState: UIControlStateNormal];
//        
//    }
//    else
//    {
//        
//        //[self.btnPause setTitle: @"Pause" forState: UIControlStateNormal];
//        
//    }
    
    
    
}

- (IBAction)clickStop:(id)sender
{
    
    self.btnRecord.enabled=YES;
    self.btnStop.enabled=YES;
    //self.btnPause.titleLabel.text=@"Pause";
    self.btnPause.enabled=YES;
    
    
    [self.btnPause setHidden:YES];
    [self.btnRecord setHidden:YES];
    [self.btnStop setHidden:YES];
    
    //***** now save video here
    
   // [timer invalidate];
    
   // secondsLeft=300;
    
    //stop the capture
    [[CameraEngine engine] stopCapture];

    NSLog(@"%@",DELEGATE.videopath);
    
}



- (IBAction)btnSetTimeClicked:(id)sender
{
//    isSetTimer=YES;
//    [self.collectionRaceView reloadData];
//    
//    _racetimeleft = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
}
-(void) updateCountdown
{
    
   // secondreaming =secondreaming+0.001;
    secondreaming =secondreaming+1;
    NSLog(@"%.03f",secondreaming);
}
-(void)updateRaceCountdown {
    
    int hours,mins,sec;
    
    if (ischecktime) {
        
        //dax
        if (uppertimecount == timeleft ) {
            
            [_timerleft invalidate];
            [_racetimeleft invalidate];
            
           // if (FinalTag!=1) {
                
             //   if (FinalTag-1 != [arrTempry count])
             //   {
                    // [timer invalidate];
                    // timer =nil;
                    [_racetimeleft invalidate];
                    _racetimeleft =nil;
                    [[CameraEngine engine] stopCapture];
                
                    
                    if (arrTempry.count != arrtagremaing.count) {
                        
                        for (int i=0;i<arrTempry.count; i++) {
                            
                            
                            NSString *strSelected=[NSString stringWithFormat:@"%@",[[arrNewTmp objectAtIndex:i] valueForKey:@"isSelected"]];
                            
                            if ([strSelected isEqualToString:@"N"])
                            {
                                NSArray *arr =[[NSArray alloc]init];
                                arr =[CoreDataUtils RelationgetObject:[Race_result description] withQueryString:@"(race_id = %@)" queryArguments:@[strId] sortBy:nil];
                                raceResult_info = [Race_result newInsertedObject];
                                raceResult_info.identifier = @([CoreDataUtils getNextID:[Race_result description]]);
                                
                                NSLog(@"%@",csvName);
                                
                                
                                
                                
                                raceResult_info.csv_path=[NSString stringWithFormat:@"%@",csvName];
                                
                                raceResult_info.boat_id =[arrBoatid objectAtIndex:i];
                                // raceResult_info.place =[NSString stringWithFormat:@"%d",FinalTag];
                                raceResult_info.place =@"DNF";
                                raceResult_info.race_id = [NSNumber numberWithInt:[strId intValue]];
                                raceResult_info.time =[NSString stringWithFormat:@"00:00:00"];
                                raceResult_info.sailno =[arrTempry objectAtIndex:i];
                                raceResult_info.skipper =[arrskipper objectAtIndex:i];
                                [CoreDataUtils updateDatabase];
                                
                                
                                NSString *strtime =@"DNF";
                                
                                
                                NSMutableDictionary *dict1 =[[NSMutableDictionary alloc] init];
                                [dict1 setObject:raceResult_info.identifier forKey:@"id"];
                                [dict1 setObject:raceResult_info.sailno forKey:@"sailno"];
                                [dict1 setObject:raceResult_info.skipper forKey:@"skipper"];
                                [dict1 setObject:@"00:00:00" forKey:@"time"];
                                [dict1 setObject:raceResult_info.place forKey:@"place"];
                               
                                [dict1 setObject:[NSString stringWithFormat:@"%d",totalBoats]forKey:@"points"];
                                
                                [arrCsvData addObject:dict1];
                                FinalTag++;
                                
                            }
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
                    NSString *str =DELEGATE.videopath;
                    
                    NSLog(@"%@",DELEGATE.videopath);
                    NSArray *arr =[[NSArray alloc] init];
                    
                    arr =[CoreDataUtils RelationgetObject:[Race_result description] withQueryString:@"(race_id = %@)" queryArguments:@[strId] sortBy:nil];
                    
                    //NSLog(@"%@",[DELEGATE convertToArray:arr]);
                    if (arr.count>0) {
                        
                        raceResult_info =[arr objectAtIndex:0];
                        NSLog(@"%@",csvName);
                        
                        raceResult_info.csv_path=[NSString stringWithFormat:@"%@",csvName];
                        raceResult_info.video_path=[NSString stringWithFormat:@"%@",str];
                        [CoreDataUtils updateDatabase];
                    }
                    else{
                        
                    }
                    
                    
                    self.btnRaceComplete.enabled=YES;
                    
                    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.customCompleteRaceView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                        _lblCustomRaceName.text = [NSString stringWithFormat:@"%@",_lblRaceName.text];
                    } completion:^(BOOL finished)
                     {}];
                    
                    //  DELEGATE.videopath=@"";
                
                //}
                
                NSArray *arr1 =[[NSArray alloc] init];
                
                arr1 =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(identifier = %@)" queryArguments:@[strId] sortBy:nil];
                
                NSLog(@"%@",[DELEGATE convertToArray:arr1]);
                
                race_info =[arr1 objectAtIndex:0];
                
                race_info.racecomplete=@"Y";
                
                [CoreDataUtils updateDatabase];
                
                UIApplication *app = [UIApplication sharedApplication];
                NSArray *eventArray = [app scheduledLocalNotifications];
                if (eventArray.count>0) {
                    for (int i=0; i<[eventArray count]; i++)
                    {
                        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
                        NSDictionary *userInfoCurrent = oneEvent.userInfo;
                        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"raceid"]];
                        if ([uid isEqualToString:strId])
                        {
                            //Cancelling local notification
                            [app cancelLocalNotification:oneEvent];
                        }
                    }
                }
                
                [_racetimeleft invalidate];
                _racetimeleft =nil;
                
                [self createdatabase];
                
                
                
                RaceResultController *raceResult=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceResultController"];
                
                raceResult.gettedCsvPath=[[NSString alloc]init];
                
                NSLog(@"%@",csvpath);
                
                raceResult.gettedCsvPath=[NSString stringWithFormat:@"%@",csvName];
                
                [raceResult setRaceId:strId];
                
                [raceResult setStrRacename: _lblRaceName.text];
                [raceResult setStrRacetime:_lblDuration.text];
                
                [CoreDataUtils updateDatabase];
                
                [self.navigationController pushViewController:raceResult animated:YES];
                
            
            //}
            
        }
        else {
       
            timeleft++;
            hours =(timeleft/3600);
            mins = ((int)timeleft/ 60) % 60;
            sec = (int)timeleft % 60;
            
            if (hours < 99) {
                NSString *strtime =[NSString stringWithFormat:@"%02d:%02d:%02d",hours,mins,sec];
                _lbltimeleft.text = strtime;
                _lbltimeleft.adjustsFontSizeToFitWidth=YES;
            }
            else{
                NSString *strtime =[NSString stringWithFormat:@"%03d:%02d:%02d",hours,mins,sec];
                _lbltimeleft.text = strtime;
                _lbltimeleft.adjustsFontSizeToFitWidth=YES;
            }

        
        }
        
        
        
        
    }
    else{
   
        timeleft--;
        
        if (timeleft==0)
        {
            
           // [_timerleft invalidate];
           // _timerleft =nil;
            ischecktime =YES;
            isSetTimer=YES;
            [self.collectionRaceView reloadData];
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                           {
                               
                               [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
                               
                               _racetimeleft = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
                               
                               [[NSRunLoop mainRunLoop] addTimer:_racetimeleft forMode:NSRunLoopCommonModes];
                               

                               
                           });
            
            
            
            
            
            
            
            //  [self viewDidLoad];
        }
        
        //convert the second into hours,mins,second
        // hours = (secondlefttime % (24*3600))/3600;
        
        
        hours =(timeleft/3600);
        mins = ((int)timeleft/ 60) % 60;
        sec = (int)timeleft % 60;
        
        
        NSLog(@"%d",hours);
        if (hours < 99) {
            NSString *strtime =[NSString stringWithFormat:@"%02d:%02d:%02d",hours,mins,sec];
            _lbltimeleft.text = strtime;
            _lbltimeleft.adjustsFontSizeToFitWidth=YES;
            
        }
        else{
            NSString *strtime =[NSString stringWithFormat:@"%03d:%02d:%02d",hours,mins,sec];
            _lbltimeleft.text = strtime;
            _lbltimeleft.adjustsFontSizeToFitWidth=YES;
        }
    }
    

    
   
    

}
- (IBAction)btnBackClicked:(id)sender
{

    
    [_racetimeleft invalidate];
    _racetimeleft =nil;
//    UIStoryboard *Mainstorybard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    UIViewController *obj=[Mainstorybard instantiateViewControllerWithIdentifier:@"RaceDetailsViewController"];
//    
//    [self.navigationController popToViewController:obj animated:YES];
    if (DELEGATE.camefrmnotification==YES)
    {
    
        DELEGATE.camefrmnotification=NO;
        
        UIStoryboard *Mainstorybard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DELEGATE.nav=[Mainstorybard instantiateViewControllerWithIdentifier:@"rootnav"];
        DELEGATE.window.rootViewController=DELEGATE.nav;
        
       // ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
        
       // [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (DELEGATE.backToHome)
    {
        
        DELEGATE.backToHome=NO;
   
        ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
        
        [self.navigationController pushViewController:obj animated:YES];
    
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
 
}


#pragma mark Button Complete Race
- (IBAction)btnRaceComplete:(id)sender
{
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.customCompleteRaceView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _lblCustomRaceName.text = [NSString stringWithFormat:@"%@",_lblRaceName.text];
    } completion:^(BOOL finished)
     {}];
}

#pragma mark Show Result
- (IBAction)btnShowResultClicked:(id)sender
{
    
    NSArray *arr =[[NSArray alloc] init];
    
    arr =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(identifier = %@)" queryArguments:@[strId] sortBy:nil];
    
    NSLog(@"%@",[DELEGATE convertToArray:arr]);
 
    race_info =[arr objectAtIndex:0];
    
    race_info.racecomplete=@"Y";
    
    [CoreDataUtils updateDatabase];
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    if (eventArray.count>0) {
        for (int i=0; i<[eventArray count]; i++)
        {
            UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
            NSDictionary *userInfoCurrent = oneEvent.userInfo;
            NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"raceid"]];
            if ([uid isEqualToString:strId])
            {
                //Cancelling local notification
                [app cancelLocalNotification:oneEvent];
            }
        }
    }
    
    [_racetimeleft invalidate];
    _racetimeleft =nil;
    
    [self createdatabase];
    
    
    
    RaceResultController *raceResult=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceResultController"];
    
    raceResult.gettedCsvPath=[[NSString alloc]init];
    
    NSLog(@"%@",csvpath);
    
    raceResult.gettedCsvPath=[NSString stringWithFormat:@"%@",csvName];
    
    [raceResult setRaceId:strId];
    
    [raceResult setStrRacename: _lblRaceName.text];
    [raceResult setStrRacetime:_lblDuration.text];
    
   
   // [CoreDataUtils updateDatabase];
    
   
    
    [self.navigationController pushViewController:raceResult animated:YES];
}

- (IBAction)btnCancel:(id)sender
{
//    CGRect newFrame = self.customCompleteRaceView.frame;
//    newFrame.origin.y = 1500;
//    self.customCompleteRaceView.frame = newFrame;
    
    NSArray *arr =[[NSArray alloc] init];
    
    arr =[CoreDataUtils RelationgetObject:[Race_master description] withQueryString:@"(identifier = %@)" queryArguments:@[strId] sortBy:nil];
    
    NSLog(@"%@",[DELEGATE convertToArray:arr]);
    
    race_info =[arr objectAtIndex:0];
    
    race_info.racecomplete=@"Y";
    
    [CoreDataUtils updateDatabase];
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    if (eventArray.count>0) {
        for (int i=0; i<[eventArray count]; i++)
        {
            UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
            NSDictionary *userInfoCurrent = oneEvent.userInfo;
            NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"raceid"]];
            if ([uid isEqualToString:strId])
            {
                //Cancelling local notification
                [app cancelLocalNotification:oneEvent];
            }
        }
    }
    
    [_racetimeleft invalidate];
    _racetimeleft =nil;
    
    [self createdatabase];
    
    [CoreDataUtils updateDatabase];
    
  //  [self.navigationController popToRootViewControllerAnimated:YES];
    ViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)btnUpperArrowClicked:(id)sender
{
    [_customVIewCollection setFrame:CGRectMake(0, 100,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [_btnDownArrow setHidden:NO];
}

- (IBAction)btnDownArrowClicked:(id)sender
{
    [_customVIewCollection setFrame:CGRectMake(0, 204,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_btnDownArrow setHidden:YES];
}

-(NSString *)dataFilePath
{
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    
    NSInteger time = timeStamp;
  
    NSArray *paths=[[NSArray alloc]init];
    
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[[NSString alloc]init];
    
    documentsDirectory = [paths objectAtIndex:0];
    
    NSString *savedImagePath=[[NSString alloc]init];
    
    NSLog(@"%@",[NSString stringWithFormat:@"/%d.csv",(int)time]);
    
 
    
    //NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"CSVFILE"];
    savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.csv",(int)time]];
    
    csvpath=savedImagePath;
    
    csvName=[NSString stringWithFormat:@"/%d.csv",(int)time];
    
    NSLog(@"%@",csvName);
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"/%d.csv",(int)time] forKey:@"time"];

    [[NSUserDefaults standardUserDefaults]synchronize];
   
    return [documentsDirectory stringByAppendingPathComponent:savedImagePath];
}

-(void)createdatabase
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:csvpath])
    {
        NSLog(@"%@",csvName);
        
        NSLog(@"%@",csvpath);
        
        [[NSFileManager defaultManager] createFileAtPath:csvpath contents:nil attributes:nil];
        NSLog(@"Route creato");
    }

    
    NSString *headingtitle;
    
    headingtitle = [NSString stringWithFormat:@"%@ %@ Race Name:%@,\n",@"",@"",_lblRaceName.text];
    
    
    NSFileHandle *handle;
    handle = [NSFileHandle fileHandleForWritingAtPath:csvpath];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[headingtitle dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *headingstring;

    headingstring = [NSString stringWithFormat:@"%@, %@, %@, %@ ,%@ ,%@ , %@ , %@\n",@"SailNo",@"boatname",@"Skipper",@"TimeLimit",@"ElapsedTime",@"Place",@"BowNo",@"Points"];
    
    NSFileHandle *handle1;
    handle1 = [NSFileHandle fileHandleForWritingAtPath:csvpath];
    //say to handle where's the file fo write
    [handle1 truncateFileAtOffset:[handle1 seekToEndOfFile]];
    //position handle cursor to the end of file
     NSLog(@"%@",csvpath);
    [[NSUserDefaults standardUserDefaults]setValue:csvpath forKey:@"csvpath"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [handle1 writeData:[headingstring dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSString *stringtime =[NSString stringWithFormat:@"%@ minutes",strracetime];
    
    
    NSString *writeString;
    for (int i=0; i<[arrCsvData count]; i++)
    {
        
      //  writeString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@ \n",[[arrCsvData objectAtIndex:i]valueForKey:@"id"],[[arrCsvData objectAtIndex:i]  valueForKey:@"sailno"],[[arrCsvData objectAtIndex:i] valueForKey:@"skipper"] ,[[arrCsvData objectAtIndex:i] valueForKey:@"time"],[aryBoatName objectAtIndex:i],[aryBoatNo objectAtIndex:i]];
       
        writeString = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@ , %@\n",[[arrCsvData objectAtIndex:i] valueForKey:@"sailno"],[aryBoatName objectAtIndex:i],[[arrCsvData objectAtIndex:i] valueForKey:@"skipper"],strracetime,[[arrCsvData objectAtIndex:i] valueForKey:@"time"],[[arrCsvData objectAtIndex:i] valueForKey:@"place"],[aryBoatNo objectAtIndex:i],[[arrCsvData objectAtIndex:i] valueForKey:@"points"]];
       
       // NSLog(@"%@",csvpath);
        
        NSFileHandle *handle;
        handle = [NSFileHandle fileHandleForWritingAtPath:csvpath];
        //say to handle where's the file fo write
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        //position handle cursor to the end of file
        
        
    
        [handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
}

-(void)viewWillDisappear:(BOOL) animated
{
    [super viewWillDisappear:animated];
    
  //  [timer invalidate];
  //  [_racetimeleft invalidate];
  //  [_timerleft invalidate];
//    if ([self isMovingFromParentViewController])
//    {
//        if (self.navigationController.delegate == self)
//        {
//            self.navigationController.delegate = nil;
//        }
//    }
}
@end


