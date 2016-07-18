//
//  CalView.m
//  MyCalculator
//
//  Created by Coding on 7/14/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalView.h"

IB_DESIGNABLE
@implementation CalView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
//        [self drawButton];
//        [self drawInnerGlow];
//        [self drawBackgroundLayer];
//        [self drawHighlightBackgroundLayer];
    }
    
    return self;
}

@end
