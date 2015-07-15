//
//  PopupView.m
//  Tapnsell
//
//  Created by macmini3 on 24/03/15.
//  Copyright (c) 2015 macmini6. All rights reserved.
//

#import "PopupView.h"
#import "RaceDetailsViewController.h"
#import "RaceViewController.h"


@interface PopupView ()

@end

@implementation PopupView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnGotoraceClicked:(id)sender
{
    RaceViewController *raceVC=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceViewController"];
    [self.navigationController pushViewController:raceVC animated:YES];
}

- (IBAction)btnRaceDetailsClicked:(id)sender
{
    RaceDetailsViewController *raceDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"RaceDetailsViewController"];
    [self.navigationController pushViewController:raceDetails animated:YES];
}

- (IBAction)btnCancelClicked:(id)sender;
{
    [self.myCustomView setHidden:YES];
}
@end
