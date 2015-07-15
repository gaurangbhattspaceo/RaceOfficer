//
//  CreateNewRacesViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 06/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRMonthPicker.h"

@interface CreateNewRacesViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSDateFormatter *dateformateDate;
    NSDateFormatter *dateformateTime;
    NSString *curruntcountrycode;
    BOOL firsttimeselected;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIPickerView *pickerRace;
@property (strong, nonatomic) NSMutableArray *arrRace;

@property (strong, nonatomic) IBOutlet UITextField *txtRaceName;
@property (strong, nonatomic) IBOutlet UITextField *txtDate;
@property (strong, nonatomic) IBOutlet UITextField *txtTime;
@property (strong, nonatomic) IBOutlet UITextField *txtTimeLimit;
@property (strong, nonatomic) IBOutlet UITextField *txtTypeofRace;
@property (strong, nonatomic) IBOutlet UITextField *txtLocation;
//@property (strong, nonatomic) NSMutableArray *arrPickerArray;


@property(strong,nonatomic) UIDatePicker *datePicker1;
@property(strong,nonatomic) UIDatePicker *datePicker2;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnNextClicked:(id)sender;

@end
