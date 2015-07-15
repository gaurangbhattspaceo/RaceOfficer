//
//  RaceResultController.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <Social/Social.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@class AVPlayer;
@interface RaceResultController : UIViewController<MFMailComposeViewControllerDelegate>

{
    //UIImage *image;
    //    int hours = minutes / 60.0;
    
    
    int mins,sec,hours;
    BOOL checkplay;
}

@property (strong, nonatomic) IBOutlet UIView *viewTblHeader;


@property (strong, nonatomic) IBOutlet UIImageView *imgback1;
@property (strong, nonatomic) IBOutlet UIImageView *imgback2;
@property(nonatomic,strong)NSString *gettedCsvPath;

@property (strong, nonatomic) IBOutlet UITableView *tblRaceResultView;
@property (strong, nonatomic) IBOutlet UIButton *btnDownArrow;
@property (strong, nonatomic) IBOutlet UILabel *lblracename;
@property (strong, nonatomic) IBOutlet UILabel *lblracetime;

@property (strong, nonatomic) NSString *strRacename;
@property (strong, nonatomic) NSString *strRacetime;

@property (strong, nonatomic) IBOutlet UILabel *lblracesailno;
@property (strong, nonatomic) IBOutlet UILabel *lblraceskipper;
@property (strong, nonatomic) IBOutlet UILabel *lbltime;
@property (strong, nonatomic) IBOutlet UILabel *lblraceplace;


- (IBAction)btnUpperArrow:(id)sender;
- (IBAction)btnDownArrow:(id)sender;
- (IBAction)btnShareClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;



//// Custom View Table /////



@property (strong, nonatomic) NSString *RaceId;
@property (strong, nonatomic) IBOutlet UIView *customViewTable;

@property (strong, nonatomic) IBOutlet UIView *viewShare;
- (IBAction)clickCancel:(id)sender;

- (IBAction)clickFb:(id)sender;

- (IBAction)clickMail:(id)sender;
@property (retain, nonatomic) MPMoviePlayerViewController *moviePlayer;

@end
