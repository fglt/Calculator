//
//  calButton.m
//  MyCalculator
//
//  Created by Coding on 5/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "DigitButton.h"
IB_DESIGNABLE
@implementation DigitButton


+ (DigitButton *)buttonWithType:(UIButtonType)type
{
    return [super buttonWithType:UIButtonTypeCustom];
}


#pragma mark - Layer setters

- (void)drawButton
{
    [super drawButton];
    // Get the root layer (any UIView subclass comes with one)
    CALayer *layer = self.layer;
    layer.borderColor = [UIColor colorWithRed:0.77f green:0.77f blue:0.77f alpha:1.00f].CGColor;
}

@end
