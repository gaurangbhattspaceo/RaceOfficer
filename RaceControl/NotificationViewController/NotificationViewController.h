//
//  NotificationViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaceDetailsViewController.h"
#import "RaceViewController.h"

@interface NotificationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tblNotificationView;
@property (strong, nonatomic) NSMutableArray *arrUpComingNotification;


- (IBAction)btnBackClicked:(id)sender;

@end
