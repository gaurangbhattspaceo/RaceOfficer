//
//  CustomAlertsCX.m
//  RaceControl
//
//  Created by peerbits_10 on 11/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "CustomAlertsCX.h"

@implementation CustomAlertsCX

+(void)ShowAlert:(NSString *)message
{
    DemoContentView *Alertview;
    Alertview=[DemoContentView defaultView];
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.frame = CGRectMake(20, 28, 260, 100);
    descriptionLabel.numberOfLines = 0.;
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textColor = [UIColor blackColor];
    descriptionLabel.font = FONT_Regular(14);
    descriptionLabel.text = message;
    [Alertview addSubview:descriptionLabel];
    
    UILabel *Titlelable = [[UILabel alloc] init];
    Titlelable.frame = CGRectMake(20, 0, 260, 100);
    Titlelable.numberOfLines = 0.;
    Titlelable.textAlignment = NSTextAlignmentCenter;
    Titlelable.backgroundColor = [UIColor clearColor];
    Titlelable.textColor = [UIColor blackColor];
    Titlelable.font = FONT_Bold(20);
    Titlelable.text = @"541GO Race Officer";
    [Alertview addSubview:Titlelable];
    
    [Alertview setDismissHandler:^(DemoContentView *view)
     {
         [CXCardView dismissCurrent];
     }];

    [CXCardView showWithView:Alertview draggable:NO];
}

@end
