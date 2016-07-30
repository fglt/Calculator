//
//  BaseView.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "BaseView.h"
#import "CalculateView.h"

@implementation BaseView
@synthesize historyButton;

-(void)awakeFromNib
{
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
}

-(void)layoutSubviews
{
    if(!historyButton){
        [self addHistoryButton];
    }
    UIDevice* device = [UIDevice currentDevice];
    UIUserInterfaceIdiom idiom = [device userInterfaceIdiom];
    BOOL ipad = (idiom == UIUserInterfaceIdiomPad);
    UIDeviceOrientation orientation = [device orientation];
    CGRect bounds = self.bounds ;
    //NSLog(@"bounds: %@",NSStringFromCGRect(bounds));
    self.resultView.frame = CGRectMake(10, 0, bounds.size.width -20, bounds.size.height* 0.2);
    
    switch (orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            if(ipad){
                self.calView.frame = CGRectMake(20, bounds.size.height * 0.2 +10, bounds.size.width - 40, bounds.size.height * 0.4 + 10 );
                self.historyView.frame = CGRectMake(20, bounds.size.height* 0.6 +30, bounds.size.width -40, bounds.size.height * 0.4 - 50);
            }else{
                historyButton.frame =
                self.calView.frame = CGRectMake(10, bounds.size.height * 0.2 +40, bounds.size.width - 20, bounds.size.height * 0.8 - 60 );
                 self.historyView.frame = CGRectMake(-bounds.size.width/2 + 50, bounds.size.height * 0.2 +40, bounds.size.width - 100, bounds.size.height * 0.8 - 100 );
                historyButton.frame =  CGRectMake(10, bounds.size.height * 0.2, 40, 40);
                self.historyView.hidden = YES;
            }
            historyButton.hidden = NO;
            
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            self.calView.frame = CGRectMake(bounds.size.width * 0.5 - 40, bounds.size.height * 0.2 +10, bounds.size.width * 0.5 + 20, bounds.size.height * 0.8 - 30 );
            self.historyView.frame = CGRectMake(20, bounds.size.height* 0.2 +10, bounds.size.width * 0.5 - 80, bounds.size.height * 0.8 - 30);
            historyButton.hidden = YES;
            self.historyView.hidden = NO;
        default:
            break;
            
    }
    
    //修复scrollview 切换设备方向后可能显示不正确的问题；（当显示page2的时候切换显示不正确））
    CalculateView*  view  = [self.calView subviews][0];
    view.scrollView.contentOffset = CGPointZero;
    
//    NSLog(@"layoutSubviews: %@",NSStringFromCGRect( self.calView.frame) );
}

-(void)addHistoryButton{
    historyButton = [[UIButton alloc] init];
    //historyButton.titleLabel.text = @"记录";
    [historyButton setTitle:@"记录" forState:UIControlStateNormal];
    [historyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    historyButton.backgroundColor = [UIColor redColor];
    [historyButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:historyButton];
}

-(void)clickButton
{
    CGRect frame = self.historyView.frame;
    if(self.historyView.hidden){
        self.historyView.hidden = NO;
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.historyView.center = CGPointMake(frame.size.width/2,  self.historyView.center.y) ;
                         }
                         completion:^(BOOL finished){}
         ];
        
    }
    else{
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.historyView.center = CGPointMake(-frame.size.width/2,  self.historyView.center.y);
                         }
                         completion:^(BOOL finished){
            
                             self.historyView.hidden = YES;}
         ];
       
    }
}
@end
