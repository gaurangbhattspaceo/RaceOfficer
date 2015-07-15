//
//  RaceViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaceDetailsViewController.h"
#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "CameraEngine.h"


@class AVPlayer;

@interface RaceViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
 //   NSTimer *timer;
    int secondsLeft;
    int captureplay;
    BOOL ischecktime;
   // MPMoviePlayerController *playerCtrl;
}

@property (nonatomic, strong) NSTimer *racetimeleft;

@property (nonatomic, strong) NSTimer *timerleft;



@property (strong, nonatomic) IBOutlet UIButton *btnRaceComplete;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundTask;



@property (strong, nonatomic) IBOutlet UIView *customCompleteRaceView;

@property (strong, nonatomic) IBOutlet UILabel *lblTotalBoats;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblDuration;
@property (strong, nonatomic) IBOutlet UILabel *lblRaceName;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionRaceView;
@property (strong, nonatomic) IBOutlet UILabel *lbltimeleft;
@property (strong, nonatomic) IBOutlet UILabel *lblnumberofrace;

- (IBAction)btnSetTimeClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnRaceComplete:(id)sender;

@property (strong, nonatomic) NSString *strId;


//////// Custom View For collection /////

@property (strong, nonatomic) IBOutlet UIView *customVIewCollection;
@property (strong, nonatomic) IBOutlet UIButton *btnDownArrow;


- (IBAction)btnUpperArrowClicked:(id)sender;
- (IBAction)btnDownArrowClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnAddVideo;

@property (strong, nonatomic) IBOutlet UIView *view_Video;

///////// Custom View Alert //////////

@property (strong, nonatomic) IBOutlet UILabel *lblCustomRaceName;


- (IBAction)btnShowResultClicked:(id)sender;

- (IBAction)btnCancel:(id)sender;
- (IBAction)clickAddVideo:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnraceresult;

@property (strong, nonatomic) IBOutlet UIButton *btnRecord;

@property (strong, nonatomic) IBOutlet UIButton *btnPause;

@property (strong, nonatomic) IBOutlet UIButton *btnStop;

@property (strong, nonatomic)IBOutlet UILabel *lblduration;

- (IBAction)clickRecord:(UIButton*)sender;
- (IBAction)clickPause:(id)sender;
- (IBAction)clickStop:(id)sender;



@end
