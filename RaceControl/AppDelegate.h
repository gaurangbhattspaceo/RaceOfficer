//
//  AppDelegate.h
//  RaceControl
//
//  Created by peerbits_10 on 06/05/15.
//  Copyright (c) 2015 Peerbits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    PopupView *Popup;
    BOOL checknotificationsound;
    NSTimer *timer;
    int checkcounttime;
}




@property(nonatomic,assign)BOOL backToHome;
@property(nonatomic,strong)NSString *videopath;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *tokenstring;
@property(nonatomic,assign) BOOL camefrmnotification;
@property(nonatomic,assign) BOOL camefrmcompleterace;
@property(nonatomic,assign)int Notificationtimetamp;

@property (strong, nonatomic) NSString *Raceid;
@property (strong, nonatomic) NSString *QUERY_IDENTIFIER;
@property (strong, nonatomic) NSString *COREIDENTIFIER;
@property (strong, nonatomic) NSDateFormatter *dateformateDate;
@property(nonatomic,strong)UINavigationController *nav;


-(NSString*)trimWhiteSpaces:(NSString*)text;
-(NSString *)convertDateToStringwith3charchter:(NSDate *)Date;
-(NSMutableArray *)convertToArray:(NSArray *)Data;
-(NSString *)convertDateToString:(NSDate *)Date;
-(NSString *)convertDateTotime:(NSDate *)Date;
-(NSString *)convertDateToStringformat:(NSDate *)Date;
-(NSString *)convertDateToFullStringformat:(NSDate *)Date;
- (BOOL)isSameDay:(NSDate*)date45 otherDay:(NSDate*)date46;
@end

