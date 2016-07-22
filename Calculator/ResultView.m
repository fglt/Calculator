//
//  ResultView.m
//  Calculator
//
//  Created by Coding on 7/22/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView

- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    return self;
}
@end
