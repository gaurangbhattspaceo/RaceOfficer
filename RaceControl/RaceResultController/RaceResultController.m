//
//  RaceResultController.m
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "RaceResultController.h"
#import "RaceResultCustomCell.h"
#import "Race_result.h"
#import "ViewController.h"
#import "CompleteRaceViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "DHSmartScreenshot.h"


@interface RaceResultController ()
{
    NSMutableArray *arr_raceresult;
    
    NSString *csvFilePath;
    NSString *Videopath;
    UIButton *buttonplay;
}
@property (strong, nonatomic) UIImage *screenshotTaken;
@end

@implementation RaceResultController

{
    
    // NSMutableArray *arrresult;
    Race_result *RaceResult;
    
}
@synthesize RaceId,gettedCsvPath,viewTblHeader;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenshotTaken = nil;

    CGRect newFrame = self.viewShare.frame;
    newFrame.origin.y = 1500;
    self.viewShare.frame = newFrame;
    
    csvFilePath=[[NSString alloc]init];
    
    checkplay =NO;
    [_btnDownArrow setHidden:YES];
    

    
    
    
    

    DELEGATE.COREIDENTIFIER =@"race_id";
    DELEGATE.QUERY_IDENTIFIER =@"race_id = %d";
    NSArray *arr =[[NSArray alloc]init];
    arr =[CoreDataUtils RelationgetObject:[Race_result description] withQueryString:@"(race_id = %@)" queryArguments:@[RaceId] sortBy:nil];
    
    NSLog(@"%@",arr);
//    
//    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"place" ascending:YES];
//    
//    arr = [arr sortedArrayUsingDescriptors:@[sort1]];
    
    
    NSLog(@"%@",arr);
    arr_raceresult =[[NSMutableArray alloc] init];
    
    arr_raceresult =[DELEGATE convertToArray:arr];
    
    
    //NSLog(@"%@",arr_raceresult);
    
    //csvFilePath=gettedCsvPath;
    
    if (arr_raceresult.count>0) {
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDir = [documentPaths objectAtIndex:0];
        csvFilePath=[[arr_raceresult objectAtIndex:0]valueForKey:@"csv_path"];
        
        if (csvFilePath)
        {
            csvFilePath=[documentDir stringByAppendingString:csvFilePath];
        }
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        Videopath =[[arr_raceresult objectAtIndex:0]valueForKey:@"video_path"];
        
        
        NSLog(@"%@",Videopath);
        if (![Videopath isKindOfClass:[NSNull class]] )
        {
            
            if (![Videopath isEqualToString:@""]) {
                
                
                
                if (Videopath) {
                    checkplay =YES;
                    Videopath=[documentsDirectory stringByAppendingString:Videopath];
                    _moviePlayer =[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:Videopath]];
                    [[_moviePlayer view] setFrame:CGRectMake(0,99,[UIScreen mainScreen].bounds.size.width,140)];
                    [_moviePlayer view].contentMode=UIViewContentModeScaleAspectFill;
                    
                    
                    
                    
                    [[_moviePlayer moviePlayer] prepareToPlay];
                    [[_moviePlayer moviePlayer] setShouldAutoplay:NO];
                    [[_moviePlayer moviePlayer] setControlStyle:1];
                    [self.view addSubview:_moviePlayer.view];
                }
                else{
                
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0,99,[UIScreen mainScreen].bounds.size.width,140)];
                    [img setBackgroundColor:[UIColor whiteColor]];
                    [self.view addSubview:img];
                    
                    
                    UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(0,99,[UIScreen mainScreen].bounds.size.width,140)];
                    lbl.text =@"No video available.";
                    lbl.font =FONT_Regular(24);
                    lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
                    lbl.numberOfLines=0;
                    lbl.textAlignment =NSTextAlignmentCenter;
                    [self.view addSubview:lbl];
                }

                
            }
            else{
    
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0,99,[UIScreen mainScreen].bounds.size.width,140)];
                    [img setBackgroundColor:[UIColor whiteColor]];
                    [self.view addSubview:img];
                    
                    
                    UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(0,99,[UIScreen mainScreen].bounds.size.width,140)];
                    lbl.text =@"No video available.";
                    lbl.font =FONT_Regular(24);
                    lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
                    lbl.numberOfLines=0;
                    lbl.textAlignment =NSTextAlignmentCenter;
                    [self.view addSubview:lbl];
                
            }
        }
        else{
        
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0,99,[UIScreen mainScreen].bounds.size.width,140)];
            [img setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:img];
           
            
            UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(0,99,[UIScreen mainScreen].bounds.size.width,140)];
            lbl.text =@"No video available.";
            lbl.font =FONT_Regular(24);
            lbl.textColor =[UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
            lbl.numberOfLines=0;
            lbl.textAlignment =NSTextAlignmentCenter;
            [self.view addSubview:lbl];
        
        }
        
        _lblracename.text =[NSString stringWithFormat:@"%@",_strRacename];
        _lblracetime.text =[NSString stringWithFormat:@"%@",_strRacetime];
        
        _tblRaceResultView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _lblracesailno.frame =CGRectMake(25,5,78,25);
        _lbltime.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-122,5,65,25);
        _lblraceplace.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-50, 5,45,25);
        _lblraceskipper.frame =CGRectMake(_lblracesailno.frame.size.width+25,5,[UIScreen mainScreen].bounds.size.width-122-100, 25);
    }

    
    if (checkplay) {
        buttonplay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonplay addTarget:self
                   action:@selector(PlayMethod:)
         forControlEvents:UIControlEventTouchUpInside];
        
        buttonplay.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 -18,150,36,36);
        [buttonplay setImage:[UIImage imageNamed:@"playrace"] forState:UIControlStateNormal];
        [self.view addSubview:buttonplay];
    }
    
    

    // RaceResult =[arr objectAtIndex:0];
    
    
    //    (
    //     {
    //         "boat_id" = 4;
    //         identifier = 1;
    //         place = 1;
    //         "race_id" = 1;
    //         sailno = 35656;
    //         skipper = frsf;
    //         time = "0.753300";
    //     },
    //     {
    //         "boat_id" = 5;
    //         identifier = 2;
    //         place = 2;
    //         "race_id" = 1;
    //         sailno = 545;
    //         skipper = dfds;
    //         time = "1.336200";
    //     },
    //     {
    //         "boat_id" = 3;
    //         identifier = 3;
    //         place = 3;
    //         "race_id" = 1;
    //         sailno = 455536;
    //         skipper = rrfd;
    //         time = "1.778400";
    //     },
    //     {
    //         "boat_id" = 2;
    //         identifier = 4;
    //         place = 4;
    //         "race_id" = 1;
    //         sailno = 1234;
    //         skipper = assd;
    //         time = "2.476600";
    //     },
    //     {
    //         "boat_id" = 6;
    //         identifier = 5;
    //         place = 5;
    //         "race_id" = 1;
    //         sailno = 5654;
    //         skipper = errt;
    //         time = "3.078300";
    //     },
    //     {
    //         "boat_id" = 1;
    //         identifier = 6;
    //         place = 6;
    //         "race_id" = 1;
    //         sailno = 1111;
    //         skipper = abc;
    //         time = "3.595000";
    //     }
    //     )
    
    // Do any additional setup after loading the view.
}

#pragma mark - Take Screenshot Examples

- (void)takeFullScreenshot
{
    self.screenshotTaken = [self.tblRaceResultView screenshot];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark Tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arr_raceresult.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return viewTblHeader;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"RaceResultCustomCell";
    
    RaceResultCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        NSArray *arrayNib=[[NSBundle mainBundle]loadNibNamed:@"RaceResultCustomCell" owner:self options:nil];
        cell=[arrayNib objectAtIndex:0];
    }

    if (indexPath.row % 2 ==0) {
        cell.backgroundColor =[UIColor whiteColor];
    }
    else{
        cell.backgroundColor =[UIColor colorWithRed:69.0/255.0 green:108.0/255.0 blue:179.0/255.0 alpha:0.05];
    }
    
    //    @property (strong, nonatomic) IBOutlet UILabel *lblSailNo;
    //    @property (strong, nonatomic) IBOutlet UILabel *lblNo;
    //    @property (strong, nonatomic) IBOutlet UILabel *lblSkipper;
    //    @property (strong, nonatomic) IBOutlet UILabel *lblFinTin;
    //    @property (strong, nonatomic) IBOutlet UILabel *lblPlace;
    
    cell.lblSailNo.text =[NSString stringWithFormat:@"%@",[[arr_raceresult objectAtIndex:indexPath.row]valueForKey:@"sailno"]];
    
    
    //***** now this will become place
   // cell.lblNo.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    cell.lblNo.text =[NSString stringWithFormat:@"%@",[[arr_raceresult objectAtIndex:indexPath.row]valueForKey:@"place"]];
    
    
    cell.lblSkipper.text =[NSString stringWithFormat:@"%@",[[arr_raceresult objectAtIndex:indexPath.row]valueForKey:@"skipper"]];
    
    //***** now this will become points
    
    if ([[[arr_raceresult objectAtIndex:indexPath.row]valueForKey:@"place"]isEqualToString:@"DNF"])
    {
        
          cell.lblPlace.text =[NSString stringWithFormat:@"%d",(int)arr_raceresult.count];
    }
    else
    {
        
        cell.lblPlace.text =[NSString stringWithFormat:@"%@",[[arr_raceresult objectAtIndex:indexPath.row]valueForKey:@"place"]];
        
    }
    
    
  
    
    //float time =[[[arr_raceresult objectAtIndex:indexPath.row]valueForKey:@"time"] floatValue]/1000;
    
    // NSLog(@"%f",time);
    cell.imgtime.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-53,0, 1,35);
    cell.imgskipper.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-125,0,1,35);
    cell.imgsailno.frame =CGRectMake(105,0, 1,35);
    
    cell.lblSailNo.frame =CGRectMake(22,5,83, 25);
    cell.lblSkipper.frame =CGRectMake(cell.imgsailno.frame.origin.x+3, 5, cell.imgskipper.frame.origin.x-cell.imgsailno.frame.origin.x-3, 25);
    cell.lblFinTin.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-122, 5,65, 25);
    cell.lblPlace.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-50, 5, 45, 25);
    

    int totalsecond =[[[arr_raceresult objectAtIndex:indexPath.row]valueForKey:@"time"]intValue];
    
    hours =((int)totalsecond/3600);
    mins = ((int)totalsecond/ 60) % 60;
    sec = (int)totalsecond % 60;
    
    NSLog(@"%02d",sec);
    NSLog(@"%02d",mins);
    NSLog(@"%02d",hours);
    
    cell.lblFinTin.text =[NSString stringWithFormat:@"%02d:%02d:%02d",hours,mins,sec];
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (IBAction)PlayMethod:(UIButton*)sender
{
    if (checkplay) {
    
       [[_moviePlayer moviePlayer] prepareToPlay];
        [[_moviePlayer moviePlayer] play];
        checkplay =NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayer.moviePlayer];
        [buttonplay setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    else{
   
        checkplay = YES;
        [buttonplay setImage:[UIImage imageNamed:@"playrace"] forState:UIControlStateNormal];
        [[_moviePlayer moviePlayer] stop];
    }
  
}
-(void)moviePlayBackDidFinish:(NSNotification*)notification
{
    checkplay = YES;
    [[_moviePlayer moviePlayer] prepareToPlay];
    [buttonplay setImage:[UIImage imageNamed:@"playrace"] forState:UIControlStateNormal];
}

- (IBAction)btnUpperArrow:(id)sender
{
    [_customViewTable setFrame:CGRectMake(0, 140,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [_btnDownArrow setHidden:NO];
    
}

- (IBAction)btnDownArrow:(id)sender
{
    [_customViewTable setFrame:CGRectMake(0, 239,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_btnDownArrow setHidden:YES];
    
}

- (IBAction)btnShareClicked:(id)sender
{
    
    
    self.viewShare.layer.zPosition=1;
    
    NSURL *urlToPDF = [NSURL fileURLWithPath:csvFilePath];
    
    
    //pathToPDF is an nsstring with a path to your file
    
    //
    //    NSMutableArray *itemsToShare = [[NSMutableArray alloc] init];
    //    [itemsToShare addObject:urlToPDF];
    //
    //    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    //    [self presentViewController:controller animated:YES completion:nil];
    
    
    
   // NSArray *objectsToShare = [[NSArray alloc]initWithObjects:urlToPDF, nil];
    //    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    //
    //    [activityVC setExcludedActivityTypes:[NSArray arrayWithObjects:
    //                                            UIActivityTypeCopyToPasteboard,nil]];
    //
    //    activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo,
    //                                         UIActivityTypeMessage,
    //
    //                                         UIActivityTypePrint,
    //                                         UIActivityTypeCopyToPasteboard,
    //                                         UIActivityTypeAssignToContact,
    //                                         UIActivityTypeSaveToCameraRoll,
    //                                         UIActivityTypeAddToReadingList,
    //                                         UIActivityTypePostToFlickr,
    //                                         UIActivityTypePostToVimeo,
    //                                         UIActivityTypePostToTencentWeibo,
    //                                         UIActivityTypeAirDrop];
    //
    //     //activityVC.excludedActivityTypes = excludeActivities;
    //     [self presentViewController:activityVC animated:YES completion:nil];
    
    [self.viewShare setHidden:NO];
    
    CGRect newFrame = self.viewShare.frame;
    newFrame.origin.y = 1500;
    self.viewShare.frame = newFrame;
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.viewShare.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } completion:^(BOOL finished)
     {
         
     }];
    
    
    
}

- (IBAction)btnBackClicked:(id)sender
{
    BOOL tap = NO;
    
    if (DELEGATE.camefrmnotification==YES)
    {
         tap = YES;
        DELEGATE.camefrmnotification=NO;
        UIStoryboard *Mainstorybard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DELEGATE.nav=[Mainstorybard instantiateViewControllerWithIdentifier:@"rootnav"];
        DELEGATE.window.rootViewController=DELEGATE.nav;
        
    }
    else if (DELEGATE.camefrmcompleterace)
    {
        DELEGATE.camefrmcompleterace=NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
//        for (UIViewController *controller in self.navigationController.viewControllers)
//        {
//            if ([controller isKindOfClass:[ViewController class]]) {
//                tap=YES;
//                [self.navigationController popToViewController:controller animated:YES];
//                return;
//            }
//        }
//        if (!tap) {
//            ViewController *addBoatscontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//            [self.navigationController pushViewController:addBoatscontroller animated:YES];
//        }
        
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[CompleteRaceViewController class]]) {
                tap=YES;
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
        if (!tap) {
            CompleteRaceViewController *addBoatscontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"CompleteRaceViewController"];
            [self.navigationController pushViewController:addBoatscontroller animated:YES];
        }
        
        
        
        
    }
}

- (IBAction)clickCancel:(id)sender
{
    
    [self.viewShare setHidden:YES];
}

- (UIImage *)imageWithTableView:(UITableView *)tableView
{
    UIView *renderedView = tableView;
    CGPoint tableContentOffset = tableView.contentOffset;
    UIGraphicsBeginImageContextWithOptions(renderedView.bounds.size, renderedView.opaque, 0.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(contextRef, 0, -tableContentOffset.y);
    [tableView.layer renderInContext:contextRef];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (IBAction)clickFb:(id)sender
{
    
    [self.viewShare setHidden:YES];
    //NSLog(@"Facebook");
    
    
//    UIImage *simage;
//    
//    UIImage *screen=[[UIImage alloc]init];
//    screen=[self capture];
//    
//    
//    NSData *imageData = UIImageJPEGRepresentation(screen, 1.0);
    
    //simage=[UIImage imageWithData:imageData];
    [self takeFullScreenshot];
    

    
//    UIImage  *image;
//    
//    UIGraphicsBeginImageContext(_tblInfoView.contentSize);
//    {
//        CGPoint savedContentOffset = _tblInfoView.contentOffset;
//        CGRect savedFrame = _tblInfoView.frame;
//        
//        _tblInfoView.contentOffset = CGPointZero;
//        _tblInfoView.frame = CGRectMake(0, 0, _tblInfoView.contentSize.width, _tblInfoView.contentSize.height);
//        
//        [_tblInfoView.layer renderInContext: UIGraphicsGetCurrentContext()];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        
//        _tblInfoView.contentOffset = savedContentOffset;
//        _tblInfoView.frame = savedFrame;
//    }
//    
//    
//    /**
//     *  For screenshot of perticular tableview area
//     */
//    
//    UIGraphicsEndImageContext();
//    NSData * data = UIImagePNGRepresentation(image);
//    
//    NSString *strPics=[NSString stringWithFormat:@"%@%@",IMAGE_PATH,[NSString stringWithFormat:@"%@",[[_arrDetails valueForKey:@"image"] objectAtIndex:0]]];
//    
//    UIImage *imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", strPics]]]];
//    
//    UIImage *imageSnap=[UIImage imageWithData:data];
//    
    
    
    
    SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    NSString *initialTextString=[[NSString alloc]init];
    
    initialTextString = @"Race results via 541GO.com : -This is a free app, you can download from here.";
  
    [composeController addImage:self.screenshotTaken];
    
     [composeController setInitialText:initialTextString];
    
    [self presentViewController:composeController animated:YES completion:nil];
    
    
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled)
        {
            
            NSLog(@"delete");
            
        } else
            
        {
            NSLog(@"post");
        }
        
        //    [composeController dismissViewControllerAnimated:YES completion:Nil];
    };
    composeController.completionHandler =myBlock;
    
}

-(UIImage *)capture
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(imageView, nil, nil, nil); //if you need to save
    return imageView;
}

- (IBAction)clickMail:(id)sender
{
    [self.viewShare setHidden:YES];
    NSLog(@"Mail");
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    //[mailComposer setMessageBody:htmlString isHTML:YES];
    NSData *fileData=[NSData dataWithContentsOfFile:csvFilePath];
    
    [mailComposer addAttachmentData:fileData mimeType:@"csv" fileName:[NSString stringWithFormat:@"%@.csv",self.lblracename.text]];
    
    [self presentViewController:mailComposer animated:YES completion:^{
    }];
    
    
    
}

#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}




@end
