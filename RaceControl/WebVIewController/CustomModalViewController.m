//
//  CustomModalViewController.m
//  POPDemo
//
//  Created by Simon Ng on 22/12/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "CustomModalViewController.h"

@interface CustomModalViewController ()

@end

@implementation CustomModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Round corner
    self.view.layer.cornerRadius = 8.f;
    NSString *fullURL = kUrlWebsite;
    
     if ([Validate isConnectedToNetwork])
     {
         [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",fullURL]]]];
     }
     else{
         [CustomAlertsCX ShowAlert:@"Please check your internet connection"];
     }
   
}

- (IBAction)btnCloseClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

    [MBProgressHUD showHUDAddedTo:[DELEGATE window] animated:YES].detailsLabelText = @"Please Wait...";
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [MBProgressHUD hideAllHUDsForView:[DELEGATE window] animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

     [MBProgressHUD hideAllHUDsForView:[DELEGATE window] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
