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
        self.layer.cornerRadius = 8;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    }
    //[self addView];
    return self;
}

@end
