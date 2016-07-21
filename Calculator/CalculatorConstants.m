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
                                      SquareRoot:@7,
                                      FunTriangle:@9, FunLogs:@9,Power:@9,FunPowRoot:@9,
                                      Factorial:@11,FunSquare:@11,FunCube:@11,FunReciprocal:@11,
                                      RightBracket:@21
                                      };

    }
    return inStackPriorityDictionary;
}

+(u_long)inStackPriorityOpFirst:(NSString*)op1 OpSecond :(NSString*)op2
{
    return ((u_long)[CalculatorConstants inStackPriorityDictionary][op1]) - ((u_long)[CalculatorConstants inStackPriorityDictionary][op2]);
}

+(NSDictionary *)outStackPriorityDictionary
{
    if(!outStackPriorityDictionary){
        outStackPriorityDictionary = @{LeftBracket:@0, Add:@3, Minius:@3,
                                       Multiply:@5,Divide:@5,FunRemainder:@5,
                                       SquareRoot:@7,
                                       FunTriangle:@9, FunLogs:@9,Power:@9,FunPowRoot:@9,
                                       Factorial:@11,FunSquare:@11,FunCube:@11,FunReciprocal:@11,
                                       RightBracket:@21
                                       };
    }
    return outStackPriorityDictionary;
}

+(u_long)outStackPriorityOpFirst:(NSString*)op1 OpSecond :(NSString*)op2
{
    return ((u_long)[CalculatorConstants outStackPriorityDictionary][op1]) - ((u_long)[CalculatorConstants outStackPriorityDictionary][op2]);
}
@end
