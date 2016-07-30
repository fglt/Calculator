//
//  ResultView.m
//  Calculator
//
//  Created by Coding on 7/22/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ResultView.h"

IB_DESIGNABLE
@implementation ResultView

- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.resultLabel.textAlignment = NSTextAlignmentRight;
    self.experssionLabel.textAlignment = NSTextAlignmentRight;
    return self;
}

-(void)layoutSubviews{
    self.experssionLabel.frame = CGRectMake(10, 0, self.frame.size.width -20, self.frame.size.height * 0.6);
    self.resultLabel.frame = CGRectMake(10, self.frame.size.height * 0.6, self.frame.size.width -20, self.frame.size.height * 0.4);
}
@end
