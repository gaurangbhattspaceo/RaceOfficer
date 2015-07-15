//
//  SettingsViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIViewControllerTransitioningDelegate>





@property (strong, nonatomic) IBOutlet UILabel *lblVersion;
@property (strong, nonatomic) IBOutlet UILabel *lblVersionsLogo;

- (IBAction)btnBackClicked:(id)sender;
//- (IBAction)btnAccountClicked:(id)sender;
- (IBAction)btnTermNConditionClicked:(id)sender;
- (IBAction)btnAboutUsClicked:(id)sender;




@end
