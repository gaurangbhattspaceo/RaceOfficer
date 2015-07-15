//
//  CompleteRaceViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompleteRaceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tblCompleteRace;
@property (strong, nonatomic) NSMutableArray *arrCompleteRace;
- (IBAction)btnBackClicked:(id)sender;
@end
