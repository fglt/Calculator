//
//  NSString+Calculator.h
//  MyCalculator
//
//  Created by Coding on 5/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorConstants.h"


///规定: 数值1表示： 左操作符：操作符左边必须为操作数 或者右括号 或者 左操作符 一元运算符；
///数值3 表示：右操作符：操作符右边必需为操作数 或者 左括号 或者 右操作符 一元运算符；
@interface NSString (Calculator)
-(BOOL)isDigit;
-(BOOL)isBasicOperator;
-(BOOL)isLeftBracket;
-(BOOL)isRightBracket;
-(BOOL)isNumberPI;
-(BOOL)isNumberExp;
-(BOOL)isPIOrExp;
-(BOOL)isFactorial;
///是否是数，不包括PI 和自然数e
-(BOOL)isNumberic;
-(BOOL)isInteger;
///是否是数，包括PI 和自然数e
-(BOOL)isNumber;
-(BOOL)isBinaryOperator;
-(BOOL)isUnaryOperator;
-(BOOL)isOperator;

///左括号 和需要右边数作为操作数的运算符
-(BOOL)isOpNeedRightOperand;

-(BOOL)isOpNeedLeftOperand;
///是否是一元右操作符（包括左括号））
-(BOOL) isLeftBinaryOperator;
///是否是一元左操作符（包括右括号））
-(BOOL) isRightBinaryOperator;

-(BOOL)isTriangleFun;
-(BOOL)isLogFun;

-(double) calWithTwoParm: (double)op1 : (double)op2;
-(double) calWithOneParm:(double)operand;
-(BOOL)containCharacter:(UniChar)ch;
///在字符串两端加上空格
-(NSString*)addSpace;

-(double)getNumber;
@end
