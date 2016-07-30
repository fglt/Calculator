//
//  SepcialButton.m
//  Calculator
//
//  Created by Coding on 7/28/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "SepcialButton.h"

@implementation SepcialButton

#pragma mark - Layer setters

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.backgroundLayer.colors = (@[
                                         (id)[UIColor colorWithRed:0.90f green:0.7f blue:0.15f alpha:1.00f].CGColor,
                                         (id)[UIColor colorWithRed:0.7f green:0.5f blue:0.0f alpha:1.00f].CGColor]);
        self.highlightBackgroundLayer.colors = (@[
                                                  (id)[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f].CGColor,
                                                  (id)[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f].CGColor
                                                  ]);

    }
    return self;
}

@end

