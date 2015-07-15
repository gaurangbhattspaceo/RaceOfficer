//
//  RaceDetailVC.m
//  RaceControl
//
//  Created by peerbits_10 on 07/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import "RaceDetailVC.h"
#import "RaceDetailCollectionCell.h"

@interface RaceDetailVC ()

@end

@implementation RaceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.CollectionRaceDetailView registerNib:[UINib nibWithNibName:@"RaceDetailCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"RaceDetailCollectionCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
    
    
}

#pragma mark Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"RaceDetailCollectionCell";
    RaceDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma mark collection view cell delegate

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if ([UIScreen mainScreen].bounds.size.width==375)
    {
        return UIEdgeInsetsMake(10,10,10,10);
    }
    else if([UIScreen mainScreen].bounds.size.width==414)
    {
        return UIEdgeInsetsMake(10,10,10,10);
    }
    else
    {
        return UIEdgeInsetsMake(10,10,10,10);// top, left, bottom, right
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([UIScreen mainScreen].bounds.size.width==375)
    {
        return CGSizeMake(172, 56);
    }
    else if ([UIScreen mainScreen].bounds.size.width==414)
    {
        return CGSizeMake(191, 56);
    }
    else if ([UIScreen mainScreen].bounds.size.height==568)
    {
        return CGSizeMake(145, 56);
    }
    else
    {
        return CGSizeMake(145, 56);
    }
}




#pragma mark button actions
- (IBAction)btnAddBoatClicked:(id)sender
{
    
}


- (IBAction)btnBackClicked:(id)sender
{
    
}
@end
