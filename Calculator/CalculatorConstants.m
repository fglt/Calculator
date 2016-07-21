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
                                      Multiply:@5,Divide:@5,FunRemainder:@5,
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
    int result = outp.intValue - inp.intValue;
    return result;
}

+(NSDictionary *)outStackPriorityDictionary
{
    if(!outStackPriorityDictionary){
        outStackPriorityDictionary = @{LeftBracket:@20, Add:@2, Minius:@2,
                                       Multiply:@4,Divide:@4,FunRemainder:@4,
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
        buttonTag =  @{@"20":Divide,
                       @"21":Multiply,
                       @"22":Minius,
                       @"23":Add,
                       @"24":Divide,
                       @"25":Multiply,
                       @"26":Minius,
                       @"27":Add,
                       @"31":NumberExp,
                       @"32":NumberPI,
                       @"40":LeftBracket,
                       @"41":RightBracket,
                       @"42":LeftBracket,
                       @"43":RightBracket,
                       @"90":SignedBit,
                       @"91":SignedBit,
                       @"101":FunScientific,
                       @"102":FunSquare,
                       @"103":FunCube,
                       @"104":FunPower,
                       @"105":FunReciprocal,
                       @"106":FunRemainder,
                       @"107":FunFactorial,
                       @"108":FunSquareRoot,
                       @"109":FunPowRoot,
                       @"110":FunLogDecimal,
                       @"111":FunLogE,
                       @"112":FunLogBinary,
                       @"120":FunSin,
                       @"121":FunCos,
                       @"122":FunTan,
                       @"123":FunArcSin,
                       @"124":FunArcCos,
                       @"125":FunArcTan,
                       @"126":FunSinh,
                       @"127":FunCosh,
                       @"128":FunTanh,
                       };
    }
    
    NSString *tagStr = [NSString stringWithFormat:@"%lu",(u_long)tag];
    return  buttonTag[tagStr];
}

+(int)operatorsType:(NSString*) op
{
    if(!operatorsDict){
        operatorsDict =@{Divide:@2,Multiply:@2,Minius:@2,Add:@2,
                         FunSquare:@1,FunCube:@1,FunPower:@2,
                       FunReciprocal:@1, FunRemainder:@2,FunFactorial:@1,
                       FunSquareRoot:@1,FunPowRoot:@2,FunLogDecimal:@1,
                       FunLogE:@1,FunLogBinary:@1,FunSin:@1,
                       FunCos:@1,FunTan:@1,FunArcSin:@1,FunArcCos:@1,
                       FunArcTan:@1,FunSinh:@1,FunCosh:@1,FunTanh:@1,
                       };
    }
    return [operatorsDict[op] intValue];
}
@end
