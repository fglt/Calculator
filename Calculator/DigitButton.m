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

@end
