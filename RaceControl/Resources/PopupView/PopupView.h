//
//  PopupView.h
//  Tapnsell
//
//  Created by macmini3 on 24/03/15.
//  Copyright (c) 2015 macmini6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblRaceName;
@property (strong, nonatomic) IBOutlet UIButton *btn_close;
@property (strong, nonatomic) IBOutlet UIButton *btn_gotorace;
@property (strong, nonatomic) IBOutlet UIButton *btn_racedetail;

@property (strong, nonatomic) IBOutlet UIView *myCustomView;
- (IBAction)btnGotoraceClicked:(id)sender;
- (IBAction)btnRaceDetailsClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;
@end
