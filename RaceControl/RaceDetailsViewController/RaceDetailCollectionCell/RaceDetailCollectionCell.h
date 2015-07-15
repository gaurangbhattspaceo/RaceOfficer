//
//  RaceDetailCollectionCell.h
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaceDetailCollectionCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgFlag;

@property (strong, nonatomic) IBOutlet UILabel *lblRank;
@property (strong, nonatomic) IBOutlet UILabel *lblBoatNo;


@property (strong, nonatomic) IBOutlet UIButton *btnRacer;


@end
