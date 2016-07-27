//
//  CalculateView.m
//  Calculator
//
//  Created by Coding on 7/27/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculateView.h"
IB_DESIGNABLE
@implementation CalculateView
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    // Custom drawing methods
    if (self)
    {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 12;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    }
    //[self addView];
    return self;
}

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        self.clipsToBounds = YES;
//        self.layer.cornerRadius = 12;
//        self.layer.borderWidth = 2;
//        self.layer.borderColor = [UIColor grayColor].CGColor;
//        self.layer.backgroundColor = [UIColor darkGrayColor].CGColor;
//    }
//    //[self addView];
//    return self;
//    
//}
//
//-(void)addView
//{
//    CGRect bounds = self.bounds;
//    CGRect srcFrame  = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height - 20);
//    CGRect pageFrame = CGRectMake(bounds.origin.x, bounds.origin.y + srcFrame.size.height, bounds.size.width, 20);
//    _scrollView = [[UIScrollView alloc]initWithFrame:srcFrame];
//    _pageControl = [[UIPageControl alloc] initWithFrame:pageFrame];
//    _scrollView.backgroundColor = [UIColor redColor];
//    _scrollView.contentSize = CGSizeMake(srcFrame.size.width * 2, srcFrame.size.height);
//    [self addSubview:_scrollView];
//    [self addSubview:_pageControl];
//}

//-(void)layoutSubviews
//{
//    if(!_scrollView){
//        [self addView];
//    }
//}
@end
