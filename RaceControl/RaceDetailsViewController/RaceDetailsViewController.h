//
//  RaceDetailsViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface RaceDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSDateFormatter *dateformateDate;
    NSDateFormatter *dateformateTime;
    BOOL FirstTimeEditDate;
    BOOL checkdelete;
    int boattag;
    
    int taptag;
    int expand;
    int count;
    BOOL isSelect;
    
    int startdaterow;
    BOOL firsttimeselected;
}
@property (strong, nonatomic) NSMutableArray *arrBoatList;

@property (strong, nonatomic) IBOutlet UITextField *txtfldRaceName;

@property (strong, nonatomic) IBOutlet UITextField *txtfldRaceDate;


@property (strong, nonatomic) IBOutlet UILabel *lblRaceName;
@property (strong, nonatomic) IBOutlet UILabel *lblRaceDate;

@property (strong, nonatomic) IBOutlet UIButton *btnSave;
@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UITextField *txtStartTime;
@property (strong, nonatomic) IBOutlet UITextField *txtTimeLimit;
@property (strong, nonatomic) IBOutlet UITextField *txtTypeOfRace;
@property (strong, nonatomic) IBOutlet UITextField *txtLocation;

@property (strong, nonatomic) IBOutlet UITableView *tblRaceDetailView;
@property (strong, nonatomic) IBOutlet UILabel *lblnumberofrace;

@property (strong, nonatomic) IBOutlet UIButton *Btnaddboat;


//aberz
@property (strong, nonatomic)NSMutableArray *arrRaceDetails;
@property (strong, nonatomic) NSMutableArray *arrRace;
@property (strong, nonatomic) UIPickerView *pickerRace;

@property (strong, nonatomic)NSString *strID;
@property (strong, nonatomic) UIPickerView *pickerLocation;
@property(strong,nonatomic) UIDatePicker *datePicker1;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)btnEditRaceClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;

- (IBAction)btnBackClicked:(id)sender;


////////Add Boats CustomView /////////
@property (strong, nonatomic) IBOutlet UIView *AddBoatsView;
@property (strong, nonatomic) IBOutlet UIView *AddCustomAddBoatsView;

- (IBAction)btnAddNewBoatClicked:(id)sender;
- (IBAction)btnAddFromExistingClicked:(id)sender;
- (IBAction)btnBackFromCustomViewClicked:(id)sender;
- (IBAction)btnCloseFromCustomView:(id)sender;

////Add New Boats ////////////
@property (strong, nonatomic) IBOutlet UIScrollView *scrollAddNewBoatsView;
@property (strong, nonatomic) IBOutlet UIView *AddNewBoatCustomView;
@property (strong, nonatomic) IBOutlet UITextField *txtBoatName;
@property (strong, nonatomic) IBOutlet UITextField *txtSailNo;
@property (strong, nonatomic) IBOutlet UITextField *txtSkipperName;
@property (strong, nonatomic) IBOutlet UITextField *txtClass;
@property (strong, nonatomic) IBOutlet UITextField *txtBowNo;

@property (nonatomic,strong) NSNumber *raceid;

- (IBAction)btnAddNewBoatsDoneClicked:(id)sender;
- (IBAction)btnAddNewBoatBackClicked:(id)sender;

////////// Add From Existing ///////

@property (strong, nonatomic) IBOutlet UIView *AddExistingBoatView;
@property (strong, nonatomic) IBOutlet UITableView *tblAddExistingView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollAddFromExisting;
@property (strong, nonatomic) IBOutlet UITextField *txtAddExisting;
@property (strong, nonatomic) IBOutlet UIImageView *imgSearchBarAddExisting;
@property (strong, nonatomic) NSMutableArray *arrAddFromExisting;

- (IBAction)btnExistingBackClicked:(id)sender;
- (IBAction)btnExistingDoneClicked:(id)sender;
- (IBAction)customViewSearchBar:(UITextField *)sender;

@end
