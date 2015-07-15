//
//  AccountViewController.m
//  RaceControl
//
//  Created by macmini6 on 06/06/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "AccountViewController.h"
#import "SettingsViewController.h"
#import "TermsAndConditions.h"

@interface AccountViewController () <MFMailComposeViewControllerDelegate>
{
    MFMailComposeViewController *mailComposer;
}

@end

@implementation AccountViewController

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

- (IBAction)btnAccountClicked:(id)sender
{

    
}

- (IBAction)btnTermNConditionClicked:(id)sender
{

    
    TermsAndConditions *settingview=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndConditions"];
    [self.navigationController pushViewController:settingview animated:YES];
    
    
}


- (IBAction)btnAboutUsClicked:(id)sender
{
      
    SettingsViewController *settingview=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [self.navigationController pushViewController:settingview animated:YES];
    
}



- (IBAction)clickSendFeedback:(id)sender
{
    
    //feedback@541go.com

    mailComposer = [[MFMailComposeViewController alloc]init];
 
    mailComposer.mailComposeDelegate = self;
    
     [mailComposer setToRecipients:@[@"feedback@541go.com"]];
 
    [self presentViewController:mailComposer animated:YES completion:^{
    }];
 
    
}

#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}
@end
