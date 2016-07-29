//
//  ComputaionCell+ConfigureForComputaion.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ComputaionCell+ConfigureForComputation.h"

@implementation ComputationCell (ConfigureForComputaion)

- (void)configureForComputation:(Computation *)computation height:(CGFloat)height{
    //NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
//    unsigned units  = NSCalendarUnitDay|NSCalendarUnitMonth;
//    NSDateComponents *comp = [self.calendar components:units fromDate:computation.date];
//    NSInteger month = [comp month];
//    NSInteger day = [comp day];
//    self.date.text = [NSString stringWithFormat:@"%ld/%ld", (long)day, (long)month];
   self.date.text = [self.dateFormatter stringFromDate:computation.date];
    self.result.text = computation.result;

    NSMutableAttributedString * attexp = [ExpressionParser parseString:computation.expression fontSize:height operatorColor:[UIColor greenColor]];
//    NSAttributedString * attriResult = [[NSAttributedString alloc] initWithString:[@"\n" stringByAppendingString:computation.result]];
//    [ex insertAttributedString:attriResult atIndex:ex.length-1];
    self.expression.attributedText = attexp;   //NSLog(@"%@", self.date.text);
}

-(NSCalendar*)calendar
{
    static NSCalendar* calendar;
    if(!calendar)
    {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return calendar;
}
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.timeStyle = NSDateIntervalFormatterShortStyle;
//        dateFormatter.dateStyle = NSDateIntervalFormatterShortStyle;
        [dateFormatter setDateFormat:@"MM/dd hh:mm"];
    }
    return dateFormatter;
}


@end
