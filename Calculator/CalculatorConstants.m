//
//  CalculatorConstants.m
//  Calculator
//
//  Created by Coding on 7/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculatorConstants.h"
#import "constants.h"

static NSDictionary * inStackPriorityDictionary;
static NSDictionary * outStackPriorityDictionary;
static NSDictionary *buttonTag;
static NSDictionary *operatorsDict;

@implementation CalculatorConstants

-(id)init{
    self = [super init];
    return self;
}

+(NSDictionary *)inStackPriorityDictionary
{
    if(!inStackPriorityDictionary){
        inStackPriorityDictionary = @{LeftBracket:@1, Add:@3, Minius:@3,
                                      Multiply:@5,Divide:@5,FunPercent:@5,
                                      FunSquareRoot:@7,
                                      FunSin:@9, FunCos:@9,FunTan:@9,
                                      FunArcSin:@9,FunArcCos:@9,FunArcTan:@9,
                                      FunSinh:@9, FunCosh:@9,FunTanh:@9,
                                      FunLogDecimal:@9,FunLogE:@9,FunLogBinary:@9,
                                      FunPower:@9,FunPowRoot:@9,
                                      FunFactorial:@11,FunSquare:@11,FunCube:@11,FunReciprocal:@11,
                                      RightBracket:@21
                                      };

    }
    return inStackPriorityDictionary;
}

+(int)stackPriorityOpOut:(NSString*)opOut OpIn :(NSString*)opIn
{
    NSNumber* outp = [CalculatorConstants outStackPriorityDictionary][opOut];
    NSNumber* inp = [CalculatorConstants inStackPriorityDictionary][opIn];
    NSLog(@"operator: %@, %@",outp, inp);
    if(outp && inp)
    {
        return (outp.intValue - inp.intValue);
    }
    
    return  INT_MAX;
}

+(NSDictionary *)outStackPriorityDictionary
{
    if(!outStackPriorityDictionary){
        outStackPriorityDictionary = @{LeftBracket:@20, Add:@2, Minius:@2,
                                       Multiply:@4,Divide:@4,FunPercent:@4,
                                       FunSquareRoot:@6,
                                       FunSin:@8, FunCos:@8,FunTan:@8,
                                       FunArcSin:@8,FunArcCos:@8,FunArcTan:@8,
                                       FunSinh:@8, FunCosh:@8,FunTanh:@8,
                                       FunLogDecimal:@8,FunLogE:@8,FunLogBinary:@8,
                                       FunPower:@8,FunPowRoot:@8,
                                       FunFactorial:@10,FunSquare:@10,FunCube:@10,FunReciprocal:@10,
                                       RightBracket:@0
                                       };
    }
    return outStackPriorityDictionary;
}

+(NSString*)buttonStringWithTag:(NSUInteger)tag
{
    if(!buttonTag){
        buttonTag =  @{@20:Divide,
                       @21:Multiply,
                       @22:Minius,
                       @23:Add,
                       @24:Divide,
                       @25:Multiply,
                       @26:Minius,
                       @27:Add,
                       @31:NumberExp,
                       @32:NumberPI,
                       @40:LeftBracket,
                       @41:RightBracket,
                       @42:LeftBracket,
                       @43:RightBracket,
                       @90:SignedBit,
                       @91:SignedBit,
                       @101:FunScientific,
                       @102:FunSquare,
                       @103:FunCube,
                       @104:FunPower,
                       @105:FunReciprocal,
                       @106:FunPercent,
                       @107:FunFactorial,
                       @108:FunSquareRoot,
                       @109:FunPowRoot,
                       @110:FunLogDecimal,
                       @111:FunLogE,
                       @112:FunLogBinary,
                       @120:FunSin,
                       @121:FunCos,
                       @122:FunTan,
                       @123:FunArcSin,
                       @124:FunArcCos,
                       @125:FunArcTan,
                       @126:FunSinh,
                       @127:FunCosh,
                       @128:FunTanh,
                       };
    }
    
    NSNumber *tagStr = [NSNumber numberWithUnsignedInteger:tag];
    return  buttonTag[tagStr];
}

+(int)operatorsType:(NSString*) op
{
    
    ///规定: 数值1表示： 左操作符：操作符左边必须为操作数 或者右括号 或者 左操作符 一元运算符；
    ///数值3 表示：右操作符：操作符右边必需为操作数 或者 左括号 或者 右操作符 一元运算符；
    if(!operatorsDict){
        operatorsDict =@{Divide:@2,Multiply:@2,Minius:@2,Add:@2,
                         FunSquare:@1,FunCube:@1,FunPower:@2,
                       FunReciprocal:@1, FunPercent:@1,FunFactorial:@1,
                       FunSquareRoot:@3,FunPowRoot:@2,FunLogDecimal:@3,
                       FunLogE:@3,FunLogBinary:@3,FunSin:@3,
                       FunCos:@3,FunTan:@3,FunArcSin:@3,FunArcCos:@3,
                       FunArcTan:@3,FunSinh:@3,FunCosh:@3,FunTanh:@3,
                         LeftBracket:@5,RightBracket:@7
                       };
    }
    return [operatorsDict[op] intValue];
}
@end
