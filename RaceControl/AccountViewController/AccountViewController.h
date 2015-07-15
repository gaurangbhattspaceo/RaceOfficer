//
//  AccountViewController.h
//  RaceControl
//
//  Created by macmini6 on 06/06/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFMailComposeViewController+Recipient.h"

@interface AccountViewController : UIViewController<UIViewControllerTransitioningDelegate>


@property (strong, nonatomic) IBOutlet UILabel *lblVersion;
@property (strong, nonatomic) IBOutlet UILabel *lblVersionsLogo;

- (IBAction)clickSendFeedback:(id)sender;


@end
