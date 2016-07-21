//
//  NSString+Calculator.h
//  MyCalculator
//
//  Created by Coding on 5/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorConstants.h"

@interface NSString (Calculator)
-(BOOL)isMathFunction;
-(BOOL)isDigit;
-(BOOL)isBasicOperator;
-(BOOL)isLeftBracket;
-(BOOL)isRightBracket;
-(BOOL)isNumberPI;
-(BOOL)isNumberExp;
-(BOOL)isFactorial;
-(BOOL)isNumberic;
-(BOOL)isInteger;
-(BOOL)isPIOrExp;
-(BOOL)isNumber;
-(BOOL)isBinaryOperator;
-(BOOL)isUnaryOperator;
-(BOOL)isOperator;

///运算符左边必须是数作为操作数（又括号也可以））
-(BOOL)isFunLeftOK;
-(BOOL)isFunNeedRightOperator;
-(BOOL)isTriangleFun;
-(BOOL)isLogFun;

-(double) calWithTwoParm: (double)op1 : (double)op2;
-(double) calWithOneParm:(double)operand;
-(BOOL)containCharacter:(UniChar)ch;
///在字符串两端加上空格
-(NSString*)addSpace;

-(double)getNumber;
@end
