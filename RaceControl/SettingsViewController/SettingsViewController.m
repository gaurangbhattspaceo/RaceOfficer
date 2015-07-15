//
//  SettingsViewController.m
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "SettingsViewController.h"
#import "CustomModalViewController.h"
#import "DismissingAnimationController.h"
#import "PresentingAnimationController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lblVersion.text=buildVersion();
    _lblVersionsLogo.text=[NSString stringWithFormat:@"Version %@",buildVersion()];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Button Actions

- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


//Abrez

- (IBAction)btnRateUsClicked:(id)sender
{
    if ([Validate isConnectedToNetwork]) {
        
        NSString* url = [NSString stringWithFormat: @"https://itunes.apple.com/app/id%@",linkid];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
    else{
        [CustomAlertsCX ShowAlert:@"Please check your internet connection"];
    }

}

- (IBAction)btnTermNConditionClicked:(id)sender
{
    CustomModalViewController *modalVC = [[CustomModalViewController alloc]initWithNibName:@"CustomModalViewController" bundle:nil];
    modalVC.transitioningDelegate = self;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:modalVC animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitionDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PresentingAnimationController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissingAnimationController alloc] init];
}

- (IBAction)btnAboutUsClicked:(id)sender
{
    CustomModalViewController *modalVC = [[CustomModalViewController alloc]initWithNibName:@"CustomModalViewController" bundle:nil];
    modalVC.transitioningDelegate = self;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:modalVC animated:YES completion:nil];
    
}

- (IBAction)btnlikeusonfacebook:(id)sender
{
    
     if ([Validate isConnectedToNetwork])
     {

         NSURL *facebookURL = [NSURL URLWithString:@"fb://profile/372450759594082"];
         if ([[UIApplication sharedApplication] canOpenURL:facebookURL])
         {
             [[UIApplication sharedApplication] openURL:facebookURL];
             
         } else
         {
             NSString* url = [NSString stringWithFormat: @"https://www.facebook.com/541GO"];
             [[UIApplication sharedApplication] openURL: [NSURL URLWithString:url]];
         }
         
     
         
     }
     else
     {
         [CustomAlertsCX ShowAlert:@"Please check your internet connection"];
     }
}
@end
