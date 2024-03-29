//
//  CustomAlert.m
//  CustomAlert
//
//  Created by Mariya Kholod on 4/23/13.
//  Copyright (c) 2013 Mariya Kholod. All rights reserved.
//

#import "CustomAlert.h"
#define MAX_ALERT_HEIGHT 300.0

@implementation CustomAlert
{
    UIImage *CancelBtnImg;
    UIImage *OtherBtnImg;
}
@synthesize delegate;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)AlertDelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    CGRect frame;
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight)
        frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    else
        frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);

    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = AlertDelegate;
        self.alpha = 0.95;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        UIImage *AlertBg = [UIImage imageNamed:@"imgAlertBackground"];
        
        if ([AlertBg respondsToSelector:@selector(resizableImageWithCapInsets:)])
            
            AlertBg = [[UIImage imageNamed: @"imgAlertBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(40.0, 25.0, 25.0, 25.0)];
        else
            AlertBg = [[UIImage imageNamed: @"imgAlertBackground"] stretchableImageWithLeftCapWidth: 25 topCapHeight: 40];
        
       
        
        
       if (otherButtonTitle.length==0)
        {
            CancelBtnImg = [UIImage imageNamed:@"imgAlertButton"];
            OtherBtnImg = [UIImage imageNamed:@"imgAlertButton"];
        }
        else{
           CancelBtnImg = [UIImage imageNamed:@"imgAlertOKButton"];
           OtherBtnImg = [UIImage imageNamed:@"imgAlertOKButton"];
        }
        
        
        
        UIImageView *AlertImgView = [[UIImageView alloc] initWithImage:AlertBg];
        
        float alert_width = AlertImgView.frame.size.width;
        float alert_height = 5.0;
        
        //add text
        UILabel *TitleLbl;
        UIScrollView *MsgScrollView;
        
        if (title)
        {
            TitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, alert_height, alert_width-20.0, 30.0)];
            TitleLbl.adjustsFontSizeToFitWidth = YES;

            [TitleLbl setFont:FONT_Bold(18)];
            TitleLbl.textAlignment = NSTextAlignmentCenter;
           //TitleLbl.minimumFontSize = 12.0;
            TitleLbl.backgroundColor = [UIColor clearColor];
            TitleLbl.textColor = [UIColor blackColor];
            TitleLbl.text = title;
            
            alert_height += TitleLbl.frame.size.height + 5.0;
        }
        else
            alert_height += 15.0;
        
        if (message)
        {
            float max_msg_height = MAX_ALERT_HEIGHT - alert_height - ((cancelButtonTitle || otherButtonTitle)?(CancelBtnImg.size.height+30.0):30.0);
            
            UILabel *MessageLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, alert_width-40.0, 0.0)];
            MessageLbl.numberOfLines = 0;
            MessageLbl.font = FONT_Regular(14);
            MessageLbl.textAlignment = NSTextAlignmentCenter;
            MessageLbl.backgroundColor = [UIColor clearColor];
            MessageLbl.textColor = [UIColor blackColor];
            MessageLbl.text = message;
            
            [MessageLbl sizeToFit];
            MessageLbl.frame = CGRectMake(10.0, 0.0, alert_width-40.0, MessageLbl.frame.size.height);
            
            while (MessageLbl.frame.size.height>max_msg_height && MessageLbl.font.pointSize>12) {
                MessageLbl.font = [UIFont systemFontOfSize:MessageLbl.font.pointSize-1];
                [MessageLbl sizeToFit];
                MessageLbl.frame = CGRectMake(10.0, 0.0, alert_width-40.0, MessageLbl.frame.size.height);
            }
            
            MsgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10.0, alert_height, alert_width-20.0, (MessageLbl.frame.size.height>max_msg_height)?max_msg_height:MessageLbl.frame.size.height)];
            MsgScrollView.contentSize = MessageLbl.frame.size;
            [MsgScrollView addSubview:MessageLbl];
            
            alert_height += MsgScrollView.frame.size.height + 15.0;
        }
        else
            alert_height += 15.0;
        
        //add buttons
        UIButton *CancelBtn;
        UIButton *OtherBtn;
        
        if (cancelButtonTitle && otherButtonTitle)
        {
            float x_displ = (int)((alert_width-CancelBtnImg.size.width*2)/3.0);
            CancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(x_displ, alert_height, CancelBtnImg.size.width, CancelBtnImg.size.height)];
            [CancelBtn setTag:1000];
            [CancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [CancelBtn.titleLabel setFont:FONT_Bold(18)];
            [CancelBtn setBackgroundImage:CancelBtnImg forState:UIControlStateNormal];
            [CancelBtn addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            OtherBtn = [[UIButton alloc] initWithFrame:CGRectMake(x_displ*2+CancelBtnImg.size.width, alert_height, OtherBtnImg.size.width, OtherBtnImg.size.height)];
            [OtherBtn setTag:1001];
            [OtherBtn setTitle:otherButtonTitle forState:UIControlStateNormal];
            [OtherBtn.titleLabel setFont:FONT_Bold(18)];
            [OtherBtn setBackgroundImage:OtherBtnImg forState:UIControlStateNormal];
            [OtherBtn addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            alert_height += CancelBtn.frame.size.height + 15.0;
        }
        else if (cancelButtonTitle)
        {
            CancelBtn = [[UIButton alloc] initWithFrame:CGRectMake((int)((alert_width-CancelBtnImg.size.width)/2.0), alert_height, CancelBtnImg.size.width, CancelBtnImg.size.height)];
            [CancelBtn setTag:1000];
            [CancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [CancelBtn.titleLabel setFont:FONT_Bold(18)];
            [CancelBtn setBackgroundImage:CancelBtnImg forState:UIControlStateNormal];
            [CancelBtn addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            alert_height += CancelBtn.frame.size.height + 15.0;
        }
        else if (otherButtonTitle)
        {
            OtherBtn = [[UIButton alloc] initWithFrame:CGRectMake((int)((alert_width-OtherBtnImg.size.width)/2.0), alert_height, OtherBtnImg.size.width, OtherBtnImg.size.height)];
            [OtherBtn setTag:1001];
            [OtherBtn setTitle:otherButtonTitle forState:UIControlStateNormal];
            [OtherBtn.titleLabel setFont:FONT_Bold(18)];
            [OtherBtn setBackgroundImage:OtherBtnImg forState:UIControlStateNormal];
            [OtherBtn addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            alert_height += OtherBtn.frame.size.height + 15.0;
        }
        else
            alert_height += 15.0;
        
        //add background
        
        AlertView = [[UIView alloc] initWithFrame:CGRectMake((int)((self.frame.size.width-alert_width)/2.0), (int)((self.frame.size.height-alert_height)/2.0), alert_width, alert_height)];
        AlertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        AlertImgView.frame = AlertView.bounds;
        [AlertView addSubview:AlertImgView];
        
        [self addSubview:AlertView];
        
        if (TitleLbl)
            [AlertView addSubview:TitleLbl];
        
        if (MsgScrollView)
            [AlertView addSubview:MsgScrollView];
        
        if (CancelBtn)
            [AlertView addSubview:CancelBtn];
        
        if (OtherBtn)
            [AlertView addSubview:OtherBtn];
    }
    return self;
}

- (void)onBtnPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    int button_index = button.tag-1000;
    
    if ([delegate respondsToSelector:@selector(customAlertView:clickedButtonAtIndex:)])
        [delegate customAlertView:self clickedButtonAtIndex:button_index];
    
    [self animateHide];
}

- (void)showInView:(UIView*)view
{
    if ([view isKindOfClass:[UIView class]])
    {
        [view addSubview:self];
        [self animateShow];
    }
}

- (void)animateShow
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.2;
    
    [AlertView.layer addAnimation:animation forKey:@"show"];
}

- (void)animateHide
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1);
    CATransform3D scale2 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.0, 0.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.1;
    
    [AlertView.layer addAnimation:animation forKey:@"hide"];
    
    [self performSelector:@selector(removeFromSuperview) withObject:self afterDelay:0.105];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
