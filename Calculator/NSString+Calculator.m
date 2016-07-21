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

@implementation NSString (Calculator)

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

-(BOOL) isMathFunction{
    unichar uc= [self characterAtIndex:0];
    return (uc >='a'&& uc<='z');
}

-(BOOL)isNumberPI
{
    return [self isEqualToString:NumberPI];
}

-(BOOL)isNumberExp
{
    return [self isEqualToString:NumberExp];
}

-(BOOL)isFactorial{
    return [self isEqualToString:FunFactorial];
}

//@"+-×÷"
//FunSquare:@1,FunCube:@1,FunPower:@2,
//FunReciprocal:@1, FunRemainder:@2,FunFactorial:@1,
//FunSquareRoot:@1,FunPowRoot:@2,FunLogDecimal:@1,
//FunLogE:@1,FunLogBinary:@1,FunSin:@1,
//FunCos:@1,FunTan:@1,FunArcSin:@1,FunArcCos:@1,
//FunArcTan:@1,FunSinh:@1,FunCosh:@1,FunTanh:@1,
-(double) calWithTwoParm: (double)op1 : (double)op2{
    if([self isEqualToString:Multiply]){
        return  op1 * op2;
    }else if([self isEqualToString:Divide]){
        return  op1 / op2;;
    }else if([self isEqualToString:Add]){
        return  op1 + op2;;
    }else if([self isEqualToString:Minius]){
        return  op1 - op2;;
    }else if([self isEqualToString:FunPower]){
        return pow(op1, op2);
    }else if([self isEqualToString:FunRemainder]){
        return (long long) op1 % (long long)op2;;
    }else if([self isEqualToString:FunPowRoot]){
        return pow(op2, 1 / op1);
    }
    return 0;
}

-(double) calWithOneParm:(double)operand{
    double  num=0;
    if( [self isEqualToString:FunSin]){
        num = sin(operand);
    }else if( [self isEqualToString:FunCos]){
        num = cos(operand);
    }else if( [self isEqualToString:FunTan]){
        num = tan(operand);
    }if( [self isEqualToString:FunArcSin]){
        num = asin(operand);
    }else if( [self isEqualToString:FunArcCos]){
        num = acos(operand);
    }else if( [self isEqualToString:FunArcTan]){
        num = atan(operand);
    }else if( [self isEqualToString:FunSinh]){
        num = sinh(operand);
    }else if( [self isEqualToString:FunCosh]){
        num = cosh(operand);
    }else if( [self isEqualToString:FunTanh]){
        num = tanh(operand);
    }else if( [self isEqualToString:FunLogDecimal]){
        num = log10(operand);
    }else if( [self isEqualToString:FunLogE]){
        num = log(operand);
    }else if( [self isEqualToString:FunLogBinary]){
        num = log2(operand);
    }else if( [self isEqualToString: FunSquareRoot]){
        num = sqrt(operand);
    }else if( [self isEqualToString:FunSquare]){
        num = operand * operand;
    }else if( [self isEqualToString:FunCube]){
        num = operand * operand * operand;
    }else if( [self isEqualToString: FunReciprocal]){
        num = 1 / operand;
    }else if( [self isEqualToString:FunFactorial]){
        num = factorial2(operand);
    }
    
    return num;
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

///在字符串两端加上空格
-(NSString*)addSpace
{
    NSString *space = @" ";
    NSMutableString * tmp = [NSMutableString stringWithString:space];
    [tmp appendString:self];
    [tmp appendString:space];
    return tmp;
}


-(BOOL)isFunLeftOK
{
    return [self isDigit] || [self isNumberExp]
    || [self isNumberPI] || [self isRightBracket] || [self isEqualToString:Dot];
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
    NSCharacterSet* Digits = [NSCharacterSet decimalDigitCharacterSet];
    NSString *value = [self stringByTrimmingCharactersInSet:Digits];

    if ([value length]!= 0) {//value为ch中除数字之外的字符
        if (!([value isEqualToString:Dot]^[value isEqualToString:Minius])) {//value中包含.或者-可能为小数或者负数
            NSLog(@"Not Numberic! %@",value);
            return NO;
        }
    }
    return YES;
}

-(BOOL)isFunNeedRightOperator
{
    if([self isBasicOperator]) return YES;
    if([self isTriangleFun]) return YES;
    if([self isLogFun]) return YES;
    if([self isEqualToString:FunPower]) return YES;
    if([self isEqualToString:FunPowRoot])return YES;
    if([self isEqualToString:FunSquareRoot]) return YES;
    return NO;
}

-(BOOL)isTriangleFun{
    
    static NSDictionary *triFun ;
    if(!triFun){
        triFun = @{FunSin:@1,FunCos:@1,FunTan:@1,
                   FunSinh:@1,FunCosh:@1,FunTanh:@1,
                   FunArcSin:@1,FunArcCos:@1,FunArcTan:@1
                   };
    }
   
    return ((int)triFun[self] == 1);
}

-(BOOL)isLogFun{
    static NSDictionary *logFun ;
    if(!logFun){
        logFun = @{FunLogDecimal:@1,FunLogE:@1,FunLogBinary:@1};
    }
    return ((int)logFun[self] == 1);
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
    
    return true;
}
-(BOOL)isUnaryOperator
{
    return true;
}

-(BOOL)isOperator{
    int i = [CalculatorConstants operatorsType:self];
    return  (i == 1) || (i == 2);
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
@end
