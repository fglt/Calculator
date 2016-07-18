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
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    unsigned units  = NSCalendarUnitDay|NSCalendarUnitMonth;
    NSDateComponents *comp = [calendar components:units fromDate:computation.date];
    NSInteger month = [comp month];
    NSInteger day = [comp day];
    self.date.text = [NSString stringWithFormat:@"%ld\n%ld", month, day];
    NSString * exptext = [NSString stringWithFormat:@"%@\n%@",computation.expression, computation.result];
    self.expression.text = exptext;
    //NSLog(@"%@", self.date.text);
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateIntervalFormatterNoStyle;
        dateFormatter.dateStyle = NSDateIntervalFormatterShortStyle;
    }
    return dateFormatter;
}
@end
