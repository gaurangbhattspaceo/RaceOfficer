//
//  TermsAndConditions.m
//  RaceControl
//
//  Created by Peerbits MacMini9 on 01/07/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "TermsAndConditions.h"

@interface TermsAndConditions ()

@end

@implementation TermsAndConditions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
                    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"terms" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:nil];
                    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickBack:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
