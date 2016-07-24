//
//  CalculatorBrain.m
//  MyCalculator
//
//  Created by Coding on 5/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculatorBrain.h"
#import "constants.h"

#import "NSString+Calculator.h"
#import "CalculatorConstants.h"
#import "ExpressionParser.h"

@interface CalculatorBrain()
@property (nonatomic) NSMutableArray *operators;
@property (nonatomic) NSMutableArray *operands;
@property (nonatomic) NSMutableArray *opArray;//包括数和运算符

@end

@implementation CalculatorBrain
@synthesize expression;
@synthesize operators;
@synthesize operands;
@synthesize opArray;


-(id)init{
    self = [super init];
    operators =[ NSMutableArray array];
    operands =[ NSMutableArray array];
    
    return self;
}

-(id) initWithInput:(NSString *)text{
    self =  [self init];
    expression = text;
    return  self;
}

-(double) calculate{

    opArray = [ExpressionParser wilCalculateWithString:self.expression];

    while( opArray.count > 0)
    {
        NSString * opCurrent = opArray[0];
        
        if([opCurrent isNumberic])
        {
            [operands addObject:[NSNumber numberWithDouble:opCurrent.doubleValue]];

        }else if([opCurrent isNumberPI]){
            [operands addObject:[NSNumber numberWithDouble:M_PI]];
        }else if([opCurrent isNumberExp]){
            [operands addObject:[NSNumber numberWithDouble:M_E]];
        }else{
            NSString* lastOperator;
            while((operators.count>0))
            {
                lastOperator = [operators lastObject];
               int priority = [CalculatorConstants stackPriorityOpOut:opCurrent OpIn:lastOperator];
                if(priority == INT_MAX){
                    NSLog(@"操作符的优先级查询失败！");
                    return INFINITY;
                }
                if(priority <= 0)
                {
                    
                    //修复一个bug：遇到左括号 必须退出while循环
                    if([lastOperator isLeftBracket]) {
                        [operators removeLastObject];
                        break;
                    }

                    [self calculateWithOperator:lastOperator];
                    
                    [operators removeLastObject];
                }else break;
            }
            if( [opCurrent isOperator] || [opCurrent isLeftBracket])
                [operators addObject:opCurrent];
        }
        [opArray removeObjectAtIndex:0];
    }
    
    while (operators.count > 0){
        NSString* lastOperator = [operators lastObject];
        [operators removeLastObject];

        [self calculateWithOperator:lastOperator];
    }
    
    double result = [[operands lastObject] doubleValue];

    [operators removeAllObjects];
    [operands removeAllObjects];
    
    return result;
}

-(void)calculateWithOperator:(NSString *)operator
{
    double result = 0;
    if([operator isBinaryOperator])
    {
        if(operands.count <= 1) return ;
        double op1 = [[operands lastObject] doubleValue];
        [operands removeLastObject];
        double op2 = [[operands lastObject] doubleValue];
        [operands removeLastObject];
        result = [operator calWithTwoParm:op2 :op1];
        [operands addObject:[NSNumber numberWithDouble:result]];
    }else if([operator isUnaryOperator])
    {
        if(operands.count < 1) return ;
        double opd = [[operands lastObject] doubleValue];
        [operands removeLastObject];
        result = [operator calWithOneParm:opd];
        [operands addObject:[NSNumber numberWithDouble:result]];
    }
}

@end

