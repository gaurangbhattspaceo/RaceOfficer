//
//  AddBoatsViewController.h
//  RaceControl
//
//  Created by peerbits_10 on 06/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaceViewController.h"

@interface AddBoatsViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    int taptag;
    int expand;
    int count;
    BOOL isSelect;
}


- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnDoneClicked:(id)sender;
- (IBAction)btnAddBoatsClicked:(id)sender;
- (IBAction)SearchBarChnage:(UITextField *)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imgSearchBackGround;
@property (strong, nonatomic) NSMutableArray *arrBoatList;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (strong, nonatomic) IBOutlet UITableView *tblAddRaceView;
@property (strong, nonatomic) NSMutableArray *arrBoat;



////////Add Boats CustomView /////////

@property (strong, nonatomic) IBOutlet UIView *AddBoatsView;
@property (strong, nonatomic) IBOutlet UIView *AddCustomAddBoatsView;
@property (strong, nonatomic) IBOutlet UIImageView *imgHeader;

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

//@property (nonatomic,assign) NSString *raceid;




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


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) IBOutlet UIView *viewAlert;
@property (strong, nonatomic) IBOutlet UIButton *btnToHome;
@property (strong, nonatomic) IBOutlet UIButton *btnRaceDetails;
- (IBAction)clickBackToHome:(id)sender;
- (IBAction)clickRaceDetails:(id)sender;

@end
