//
//  CustomModalViewController.h
//  POPDemo
//
//  Created by Simon Ng on 22/12/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomModalViewController : UIViewController<UIWebViewDelegate,UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)btnCloseClicked:(id)sender;

@end
