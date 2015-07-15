//
//  ViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 06/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    NSMutableDictionary *dictTemp;
    NSMutableDictionary *Dictmain;
    NSMutableArray *arrUser;
   // NSMutableArray *copyListArray;
    NSMutableArray *arrAddFromExisting;

}
- (IBAction)btnCreateNewRaceClicked:(id)sender;
- (IBAction)btnUpcomingRacesClicked:(id)sender;
- (IBAction)btnCompleteRacesClicked:(id)sender;

- (IBAction)btnSettingsClicked:(id)sender;
- (IBAction)btnNotificationClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imgnotificationbg;
@property (strong, nonatomic) IBOutlet UILabel *lblnotification;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@end

