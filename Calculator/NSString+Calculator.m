//
//  NSString+Calculator.m
//  MyCalculator
//
//  Created by Coding on 5/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "NSString+Calculator.h"
#import "constants.h"
#import "factorial.h"
#import "CalculatorConstants.h"

@implementation NSString (Calculator)

static NSDictionary * binaryOperators;
static NSDictionary * unaryOperators;
static NSDictionary * operatorsDict;

-(BOOL)isLeftBracket
{
    return [self isEqualToString:LeftBracket];
}

-(BOOL)isRightBracket
{
    return [self isEqualToString:RightBracket];
}

-(BOOL)isBasicOperator{
    return [BasicOperation containsString:self];
}

-(BOOL) isDigit
{
    return [Digits containsString:self];
}

-(BOOL)isNumberPI
{
    return [self isEqualToString:NumberPI];
}

-(BOOL)isNumberExp
{
    return [self isEqualToString:NumberExp];
}

-(double) calWithTwoParm: (double)op1 : (double)op2{
    binaryOperator op = [self binaryOperator];
    if(op)
        return op(op1,  op2);
    return NAN;
}

-(double) calWithOneParm:(double)operand{
    unaryOperator op = [self unaryOperator];
    if(op)
        return op(operand);
    return NAN;
}

-(BOOL)containCharacter:(UniChar)ch
{
    for(int i=0; i<self.length; i++)
    {
        if(ch == [self characterAtIndex:i])
            return true;
    }
    return false;
}

-(double)getNumber
{
    if([self isNumberic])
        return self.doubleValue;
    if([self isNumberPI])
        return M_PI;
    if([self isNumberExp])
        return M_E;
    return 0;
}

///在字符串两端加上空格
-(NSString*)addSpace
{
    NSString *space = @" ";
    NSMutableString * tmp = [NSMutableString stringWithString:space];
    [tmp appendString:self];
    [tmp appendString:space];
    return tmp;
}


//判断是否为整数
-(BOOL)isInteger
{
    if (![self isNumberic]) {
        return NO;
    }
    
    int intContent = [self intValue];
    double doubleContent = [self doubleValue];
    if ((doubleContent - intContent == 0))
        return YES;
    return NO;
}

-(BOOL)isNumberic
{
    if([self isEqualToString:Minius]) return false;
    if([self characterAtIndex:0] == '0') return true;
    NSCharacterSet* Digits = [NSCharacterSet characterSetWithCharactersInString:@"0123456789-."];
    NSString *value = [self stringByTrimmingCharactersInSet:Digits];

    if ([value length]!= 0) {//value为ch中除数字之外的字符
        return NO;
    }
    return YES;
}



-(BOOL)isTriangleFun{
    
    static NSDictionary *triFun ;
    if(!triFun){
        triFun = @{FunSin:@1,FunCos:@1,FunTan:@1,
                   FunSinh:@1,FunCosh:@1,FunTanh:@1,
                   FunArcSin:@1,FunArcCos:@1,FunArcTan:@1
                   };
    }
   
    return ([triFun[self] intValue] == 1);
}

-(BOOL)isLogFun{
    static NSDictionary *logFun ;
    if(!logFun){
        logFun = @{FunLogDecimal:@1,FunLogE:@1,FunLogBinary:@1};
    }
    return ([logFun[self] intValue] == 1);
}

-(BOOL)isPIOrExp{
    return [self isEqualToString:NumberPI] || [self isEqualToString:NumberExp];
}

-(BOOL)isNumber
{
    return [self  isNumberic] || [self isPIOrExp];
}

-(BOOL)isBinaryOperator
{
    return  [self operatorsType] == 2;
}

-(BOOL)isUnaryOperator
{
    int i = [self operatorsType];
    return  i == 1 || i == 3;
}

-(BOOL)isOperator{
    int i = [self operatorsType];
    return  (i == 1) || (i == 2 || i == 3);
}

-(BOOL)isOpNeedRightOperand
{
    if([self isBinaryOperator]) return YES;
    int i = [self operatorsType];
    return  i == 3 || i == 5;
}

-(BOOL)isOpNeedLeftOperand
{
    int i = [self operatorsType];
    if([self isBinaryOperator]) return true;
     return  i == 1 || i == 7;
}

///是否是一元左操作符（包括右括号））
-(BOOL) isLeftUnaryOperator
{
     int i = [self operatorsType];
    return  i == 1 || i == 7;
}

///是否是一元右操作符（包括左括号））
-(BOOL) isRightUnaryOperator
{
    int i = [self operatorsType];
    return  i == 3 || i == 5;
}


-(binaryOperator)binaryOperator
{
    if(!binaryOperators)
    {
        
        binaryOperator opAdd  = ^(double a, double b){ return a + b; };
        binaryOperator opMinus  = ^(double a, double b){ return a - b; };
        binaryOperator opMultiply  = ^(double a, double b){ return a * b; };
        binaryOperator opDivide  = ^(double a, double b){ return a / b; };
        binaryOperator opPow  = ^(double a, double b){ return pow( a , b); };
        binaryOperator opScientist  = ^(double a, double b){ return a * pow( 10 , b); };
        binaryOperator opPowRoot  = ^(double a, double b){ return pow( a , 1 / b); };
        
        binaryOperators =@{Divide:opDivide,Multiply:opMultiply,Minius:opMinus,Add:opAdd,
                           FunPower:opPow,FunPowRoot:opPowRoot,FunScientific:opScientist};
    }
    
    return binaryOperators[self];
}

-(unaryOperator)unaryOperator
{
    if(!unaryOperators)
    {
        unaryOperator opSin  = ^(double a){ return sin(a); };
        unaryOperator opCos  = ^(double a){ return cos(a); };
        unaryOperator opTan  = ^(double a){ return tan(a); };
        unaryOperator opAsin  = ^(double a){ return asin(a); };
        unaryOperator opAcos  = ^(double a){ return acos(a); };
        unaryOperator opAtan  = ^(double a){ return atan(a); };
        unaryOperator opSinh  = ^(double a){ return sinh(a); };
        unaryOperator opCosh  = ^(double a){ return cosh(a); };
        unaryOperator opTanh  = ^(double a){ return tanh(a); };
        unaryOperator oplog2  = ^(double a){ return log2(a); };
        unaryOperator opln  = ^(double a){ return log(a); };
        unaryOperator oplog10  = ^(double a){ return log10(a); };
        unaryOperator opSquare  = ^(double a){ return a * a; };
        unaryOperator opCube  = ^(double a){ return a * a * a; };
        unaryOperator opReciprocal  = ^(double a){ return 1.0 / a; };
        unaryOperator opPercent  = ^(double a){ return  a / 100.0; };
        unaryOperator opFactorial  = ^(double a){ return factorial(a); };
        unaryOperator opSquareRoot  = ^(double a){ return sqrt(a); };
        
        unaryOperators =@{FunSin:opSin,FunCos:opCos,FunTan:opTan,
                          FunArcSin:opAsin,FunArcCos:opAcos,FunArcTan:opAtan,
                          FunSinh:opSinh,FunCosh:opCosh,FunTanh:opTanh,
                          FunLogBinary:oplog2, FunLogE:opln, FunLogDecimal:oplog10,
                          FunSquare:opSquare,FunCube:opCube,FunReciprocal:opReciprocal,
                          FunPercent:opPercent,FunFactorial:opFactorial,FunSquareRoot:opSquareRoot
                          };
    }
    
    return unaryOperators[self];
}

-(int)operatorsType
{
    ///规定: 数值1表示： 左操作符：操作符左边必须为操作数 或者右括号 或者 左操作符 一元运算符；
    ///数值3 表示：右操作符：操作符右边必需为操作数 或者 左括号 或者 右操作符 一元运算符；
    if(!operatorsDict){
        operatorsDict =@{Divide:@2,Multiply:@2,Minius:@2,Add:@2,
                         FunScientific:@2,FunPower:@2,FunPowRoot:@2,
                         FunSquare:@1,FunCube:@1,FunReciprocal:@1, FunPercent:@1,FunFactorial:@1,
                         FunSquareRoot:@3,FunLogDecimal:@3,FunLogE:@3,FunLogBinary:@3,
                         FunSin:@3,FunCos:@3,FunTan:@3,FunArcSin:@3,FunArcCos:@3,
                         FunArcTan:@3,FunSinh:@3,FunCosh:@3,FunTanh:@3,
                         LeftBracket:@5,RightBracket:@7
                         };
    }
    return [operatorsDict[self] intValue];
}
@end
