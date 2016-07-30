//
//  CalView.m
//  MyCalculator
//
//  Created by Coding on 7/14/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalBoardView.h"

IB_DESIGNABLE
@implementation CalBoardView


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
    
    return self;
}



@end
