//
//  RaceDetailVC.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaceDetailVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblRaceName;
@property (strong, nonatomic) IBOutlet UILabel *lblBoats;
@property (strong, nonatomic) IBOutlet UILabel *lblLimitTime;


@property (strong, nonatomic) IBOutlet UICollectionView *CollectionRaceDetailView;

- (IBAction)btnAddBoatClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

@end
