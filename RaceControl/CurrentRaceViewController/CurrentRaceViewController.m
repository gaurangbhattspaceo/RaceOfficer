//
//  CurrentRaceViewController.m
//  RaceControl
//
//  Created by macmini6 on 04/06/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "CurrentRaceViewController.h"
#import "Race_master.h"
#import "UpcomingCustomCell.h"
#import "RaceDetailsViewController.h"
#import "RaceViewController.h"
#import "Race_boat.h"


@interface CurrentRaceViewController ()
{
    NSTimer *timer;
    UILabel *lbl;
}

@end

@implementation CurrentRaceViewController
{
    // NSString *strRaceName;
    Race_master *Race_info;
    NSString *strID;
    NSMutableArray *arrRaceDetail;
    
    int selectedIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    


 
    selectedIndex = 0;
    
//   timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
//                                                  target: self
//                                                selector:@selector(reFreshPage)
//                                                userInfo: nil repeats:YES];

  
    // Do any additional setup after loading the view.
}


-(void)reFreshPage
{

    NSDateComponents *comp1 = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:[NSDate date]];
    
    NSLog(@"%ld",(long)comp1.second);

    if (comp1.second == 0)
    {
 
        [self viewWillAppear:YES];
        
    }
    
    
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
    
    _arrCurrentRace =[[NSMutableArray alloc] init];
    arrRaceDetail =[[NSMutableArray alloc] init];
    
    NSDate *currentDate = [NSDate date];
    currentDate = [currentDate dateByAddingTimeInterval:60];
    NSLog(@"%@",currentDate);
    
    
    NSArray *array =[[NSArray alloc]init];
    //array =[CoreDataUtils getObjects:[Race_master description]];
    array = [CoreDataUtils getObjects:[Race_master description] withQueryString:@"starttime <= %@ AND racecomplete = %@ AND isboatadded = %@" queryArguments:@[currentDate,@"N",@"Y"] sortBy:nil];
    NSLog(@"%@",array);
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
            [_arrCurrentRace addObject:[array objectAtIndex:i]];
            
            
        }
        
        
    }
    
    arrRaceDetail=[self convertToArray:_arrCurrentRace];
    
    if (array.count>0)
    {
    
        for (UILabel *label in self.view.subviews)
        {
            if (label.tag == 999)
            {
                
                [label removeFromSuperview];
                
            }
            
            
        }
        
        
        
        [_tblCurrentRaceView reloadData];
    }
    else{
        
        
        for (UILabel *label in self.view.subviews)
        {
            if (label.tag == 999)
            {
                
                [label removeFromSuperview];
                
            }
            
            
        }
     
        lbl =[[UILabel alloc] initWithFrame:CGRectMake(10,self.view.frame.size.height/2 -100, [UIScreen mainScreen].bounds.size.width-10, 200)];
        
        lbl.text =@"You don't have any current races.";
        lbl.font =FONT_Regular(24);
        lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
        lbl.numberOfLines=0;
        lbl.textAlignment =NSTextAlignmentCenter;
        lbl.tag=999;
        [self.view addSubview:lbl];
        
        
        
         [_tblCurrentRaceView reloadData];
        
        
        
    }
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrCurrentRace.count;
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
    
    
    Race_info =[_arrCurrentRace objectAtIndex:indexPath.row];
    
    
    
    
    NSLog(@"%@",Race_info.date);
    
    NSLog(@"%@",Race_info.date);
    
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
    
    
    
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@ %@",[DELEGATE convertDateToString:Race_info.date],shortnamedayofweekFromDate(Race_info.date)]);
    
    
    cell.lblDate.text =[NSString stringWithFormat:@"%@ %@",[DELEGATE convertDateToString:Race_info.date],shortnamedayofweekFromDate(Race_info.date)];
    
    
    [cell.lblStartTime setText:[NSString stringWithFormat:@"STARTED %@",[DELEGATE convertDateToFullStringformat:Race_info.starttime]]];
    
    //NSLog(@"%@",Race_info.timelimit);
    
    NSString *timeLimit=[NSString stringWithFormat:@"%@",Race_info.timelimit];
    timeLimit=[timeLimit stringByReplacingOccurrencesOfString:@"minutes" withString:@""];
    
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
    
     selectedIndex = (int)indexPath.row;
    
    Race_info =[_arrCurrentRace objectAtIndex:selectedIndex];
    
    NSString *timeLimit = [[_arrCurrentRace objectAtIndex:selectedIndex]valueForKey:@"timelimit"];
    
    NSString *strTime =[timeLimit stringByReplacingOccurrencesOfString:@"minute" withString:@""];
    
    NSDateComponents *comp1 = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:Race_info.starttime];
    
    NSDate *endTime = [Race_info.starttime dateByAddingTimeInterval:-comp1.second];
    
    double timelimit = [strTime intValue]*60;
    
    endTime = [endTime dateByAddingTimeInterval:timelimit];
    
    
    NSLog(@"%f",[endTime timeIntervalSince1970]);
    
    NSLog(@"%f",[[NSDate date] timeIntervalSince1970]);
    
    
    if ([endTime timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"541GO Race Officer" message:@"Race Already Completed" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else
    {
    
    strID=[NSString stringWithFormat:@"%@",[[arrRaceDetail valueForKey:@"identifier"] objectAtIndex:indexPath.row]];
    
    RaceViewController *raceVC=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceViewController"];
    raceVC.strId=[NSString stringWithFormat:@"%@",strID];
    [self.navigationController pushViewController:raceVC animated:YES];
    }

//    [self.myCustomAlertView setHidden:NO];
//    
//    

//
//    
//    CGRect newFrame = self.myCustomAlertView.frame;
//    newFrame.origin.y = 1500;
//    self.myCustomAlertView.frame = newFrame;
//    
//    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.myCustomAlertView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    } completion:^(BOOL finished)
//     {
//         Race_info =[_arrCurrentRace objectAtIndex:indexPath.row];
//         _lblRaceName.text =[NSString stringWithFormat:@"%@",Race_info.name];
//     }];
//    
    
}

#pragma mark Button Actions
- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)btnGotoRaceClicked:(id)sender
{
    
    
    RaceViewController *raceVC=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceViewController"];
    raceVC.strId=[NSString stringWithFormat:@"%@",strID];
    [self.navigationController pushViewController:raceVC animated:YES];
}

- (IBAction)btnRaceDetailClicked:(id)sender
{
//    RaceDetailsViewController *raceDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceDetailsViewController"];
//    raceDetails.strID=[NSString stringWithFormat:@"%@",strID];
//    [self.navigationController pushViewController:raceDetails animated:YES];
    
    [CustomAlertsCX ShowAlert:@"Race already started"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
*/

-(void)viewWillDisappear:(BOOL)animated
{
    
    [timer invalidate];
}

- (IBAction)clickRefresh:(id)sender
{
    
    [self viewWillAppear:YES];
    
}
@end
