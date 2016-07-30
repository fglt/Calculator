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
    //NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
//    unsigned units  = NSCalendarUnitDay|NSCalendarUnitMonth;
//    NSDateComponents *comp = [self.calendar components:units fromDate:computation.date];
//    NSInteger month = [comp month];
//    NSInteger day = [comp day];
//    self.date.text = [NSString stringWithFormat:@"%ld/%ld", (long)day, (long)month];
    self.date.text = [self.dateFormatter stringFromDate:computation.date];
        NSMutableAttributedString * attributedString = [ExpressionParser parseString:computation.expression font:font operatorColor:[UIColor greenColor]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    [paragraphStyle setLineSpacing:0];//调整行间距
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [paragraphStyle setHeadIndent:6];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    self.expression.attributedText = attributedString;
    
    self.result.text = computation.result;
    [self layoutIfNeeded];

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
        [dateFormatter setDateFormat:@"MM/dd \nhh:mm"];
    }
    return dateFormatter;
}


@end
