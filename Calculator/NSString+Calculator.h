//
//  NSString+Calculator.h
//  MyCalculator
//
//  Created by Coding on 5/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Calculator)
-(BOOL)isMathFunction;
-(BOOL)isDigit;
-(BOOL)isOperator;
-(double) calWithTwoParm: (double)op1 : (double)op2;
-(double) calWithOneParm:(double)operand;
-(u_long) lastLocationForNumberStartAt:(u_long)start;
- (int) priorityCompareTo : (NSString *)op2;
@end
