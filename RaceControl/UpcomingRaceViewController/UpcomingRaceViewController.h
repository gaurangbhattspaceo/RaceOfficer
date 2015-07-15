//
//  UpcomingRaceViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingRaceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (IBAction)btnBackClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblUpComingRace;


///////////////  Custom AlertView ////////////

@property (strong, nonatomic) IBOutlet UIView *myCustomAlertView;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackGroundView;

@property (strong, nonatomic) IBOutlet UIImageView *imgAlertBackGround;
@property (strong, nonatomic) IBOutlet UIImageView *imgCancelView;
@property (strong, nonatomic) IBOutlet UILabel *lblRaceName;
@property (strong, nonatomic) NSMutableArray *arrUpComingRace;


- (IBAction)btnGotoRaceClicked:(id)sender;
- (IBAction)btnRaceDetailClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;

@end
