//
//  ComputaionCell+ConfigureForComputaion.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//
#import "ComputationCell.h"
@class Computation;

@interface ComputationCell (ConfigureForComputation)
- (void)configureForComputation:(Computation *)computation height:(CGFloat)height;
@end
