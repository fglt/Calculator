//
//  HistoryBoardView.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "HistoryBoardView.h"

@implementation HistoryBoardView
- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

@end
