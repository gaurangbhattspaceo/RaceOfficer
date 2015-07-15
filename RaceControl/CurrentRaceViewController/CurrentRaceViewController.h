//
//  CurrentRaceViewController.h
//  RaceControl
//
//  Created by macmini6 on 04/06/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentRaceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

}
@property (strong, nonatomic) IBOutlet UITableView *tblCurrentRaceView;
@property (strong, nonatomic) NSMutableArray *arrCurrentRace;

@property (strong, nonatomic) IBOutlet UIView *myCustomAlertView;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackGroundView;

@property (strong, nonatomic) IBOutlet UIImageView *imgAlertBackGround;
@property (strong, nonatomic) IBOutlet UIImageView *imgCancelView;
@property (strong, nonatomic) IBOutlet UILabel *lblRaceName;

- (IBAction)clickRefresh:(id)sender;


@end
