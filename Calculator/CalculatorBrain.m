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

@interface CalculatorBrain()
@property NSMutableArray *operators;
@property NSMutableArray *operands;
@property NSMutableArray *opArray;//包括数和运算符

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

-(void)checkOpArrayLast
{
    while((opArray.count >0 ) && ([opArray.lastObject isFunNeedRightOperator]  || [opArray.lastObject isLeftBracket]))
    {
        [opArray removeLastObject];
    }
    return ;
}

-(void) willCalculate
{
    operators =[ NSMutableArray array];
    operands =[ NSMutableArray array];
    
    NSArray* tempArray = [expression componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@" "]];
    opArray = [NSMutableArray arrayWithArray:tempArray];
    [self clearSpace];
    [self checkOpArrayLast];
    [self addBracket];
    [self addMultiply];
    
    NSLog(@"array: %@", opArray);
}

-(void)addBracket
{
    u_long i = 0;
    
    int lCount = 0;
    int rCount = 0;
    
    while(i < opArray.count)
    {
        if([opArray[i] isEqualToString:RightBracket])
        {
            if(lCount == rCount)
            {
                [opArray insertObject:LeftBracket atIndex:0];
                lCount++;
                i++;
            }
            rCount ++;
        }else if ([opArray[i] isEqualToString:LeftBracket])
        {
            lCount++;
        }
        i++;
    }
    
    while(lCount > rCount)
    {
        [opArray addObject:RightBracket];
        rCount++;
    }
}

-(void) clearSpace
{
    u_long i = 0;

    while(i < opArray.count)
    {
        if([opArray[i] isEqualToString:@""])
            [opArray removeObjectAtIndex:i];
        else
            i++;
    }
}

//在π和℮两边为数字时候加乘法
//加乘法 如2(1+2)变为 2*(1+2)
-(void)addMultiply
{
    if((!opArray) || (opArray.count<=1)) return;
    u_long i = 0;
    while(i < opArray.count - 1){
        NSString * op1 =  opArray[i];
        NSString * op2 =  opArray[i+1];
        if([op1 isNumberic] && ([op2 isLeftBracket] || [op2 isPIOrExp]))
        {
            [opArray insertObject:Multiply atIndex:i+1];
            i++;
        }
        
        if([op1 isRightBracket] && ([op2 isNumberic] || [op2 isPIOrExp]))
        {
            [opArray insertObject:Multiply atIndex:i+1];
            i++;
        }
        if([op1 isPIOrExp] && ([op2 isNumberic] || [op2 isLeftBracket] || [op2 isPIOrExp]))
        {
            [opArray insertObject:Multiply atIndex:i+1];
            i++;
        }
        i++;
    }
}

-(BOOL)check
{
    u_long i = 0;
    u_long length = opArray.count;
    
    while(i < length)
    {
        //如果左括号右边出现乘除法 错误
        //如果右括号左边边出现加减乘除 错误
        //如果左括号右边出现乘除法 错误；如果右括号左边边出现加减乘除 错误
        //如果根号或N方右边不为数字左括号，错误
        
    }
    
    return false;
}

-(double) calculate{

    [self willCalculate];

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
                NSNumber* pri = [CalculatorConstants stackPriorityOpOut:opCurrent OpIn:lastOperator];
                if(!pri){
                    NSLog(@"操作符的优先级查询失败！");
                    return INFINITY;
                }
                if(pri.intValue <= 0)
                {
                    if(![lastOperator isLeftBracket]){
                        [self calculateWithOperator:lastOperator];
                    }
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

    return [[operands lastObject] doubleValue];
}

-(void)calculateWithOperator:(NSString *)operator
{
    double result = 0;
    if([CalculatorConstants operatorsType:operator] == 2)
    {
        if(operands.count <= 1) return ;
        double op1 = [[operands lastObject] doubleValue];
        [operands removeLastObject];
        double op2 = [[operands lastObject] doubleValue];
        [operands removeLastObject];
        result = [operator calWithTwoParm:op2 :op1];
        [operands addObject:[NSNumber numberWithDouble:result]];
    }else if([CalculatorConstants operatorsType:operator] == 1)
    {
        if(operands.count < 1) return ;
        double opd = [[operands lastObject] doubleValue];
        [operands removeLastObject];
        result = [operator calWithOneParm:opd];
        [operands addObject:[NSNumber numberWithDouble:result]];
    }
}

@end

