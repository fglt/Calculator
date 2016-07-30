//
//  ComputaionCell+ConfigureForComputaion.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ComputaionCell+ConfigureForComputation.h"
#import "Computation.h"
#import "ExpressionParser.h"

@implementation ComputationCell (ConfigureForComputaion)

- (void)configureForComputation:(Computation *)computation font:(UIFont*)font{

    self.date.text = [self.dateFormatter stringFromDate:computation.date];
        NSMutableAttributedString * attributedString = [ExpressionParser parseString:computation.expression font:font operatorColor:[UIColor greenColor]];
    self.expression.attributedText = attributedString;
    
    self.result.text = computation.result;
   // [self layoutIfNeeded];
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.timeStyle = NSDateIntervalFormatterShortStyle;
//        dateFormatter.dateStyle = NSDateIntervalFormatterShortStyle;
        [dateFormatter setDateFormat:@"MM/dd \nhh:mm"];
    }
    return dateFormatter;
}


@end
