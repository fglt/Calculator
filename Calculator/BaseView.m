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


-(void)awakeFromNib
{
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
}

-(void)layoutSubviews
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGRect bounds = self.bounds ;
    self.resultView.frame = CGRectMake(10, 0, bounds.size.width -20, bounds.size.height* 0.2);
    switch (orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            self.calView.frame = CGRectMake(20, bounds.size.height * 0.2 +10, bounds.size.width - 40, bounds.size.height * 0.4 + 10 );
            self.historyView.frame = CGRectMake(20, bounds.size.height* 0.6 +30, bounds.size.width -40, bounds.size.height * 0.4 - 50);
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            self.historyView.frame = CGRectMake(20, bounds.size.height* 0.2 +10, bounds.size.width * 0.5 - 80, bounds.size.height * 0.8 - 30);
            self.calView.frame = CGRectMake(bounds.size.width * 0.5 - 40, bounds.size.height * 0.2 +10, bounds.size.width * 0.5 + 20, bounds.size.height * 0.8 - 30 );
           
        default:
            break;
    }
    
    //修复scrollview 切换设备方向后可能显示不正确的问题；（当显示page2的时候切换显示不正确））
    CalculateView*  view  = [self.calView subviews][0];
    view.scrollView.contentOffset = CGPointZero;
    
//    NSLog(@"layoutSubviews: %@",NSStringFromCGRect( self.calView.frame) );
}
@end
