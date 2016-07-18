//
//  ComputaionCell+ConfigureForComputaion.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ComputaionCell+ConfigureForComputation.h"

@implementation ComputationCell (ConfigureForComputaion)

- (void)configureForComputation:(Computation *)computation
{
    self.date.text = [self.dateFormatter stringFromDate:computation.date];
    self.expression.text = computation.expression;
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }
    return dateFormatter;
}
@end
