//
//  NSString+Calculator.m
//  MyCalculator
//
//  Created by Coding on 5/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "NSString+Calculator.h"
#import "constants.h"

@implementation NSString (Calculator)

-(BOOL)isOperator{
    return [Operatorstr containsString:self];
}

-(BOOL) isDigit
{
    return [Digits containsString:self];
}

-(BOOL) isMathFunction{
    unichar uc= [self characterAtIndex:0];
    return (uc >='a'&& uc<='z');
}

//@"+-×÷"
-(double) calWithTwoParm: (double)op1 : (double)op2{
    if([self isEqualToString:Multiply]){
        return  op1 * op2;
        
    }else if([self isEqualToString:Divide]){
        return  op1 / op2;;
    }else if([self isEqualToString:Add]){
        return  op1 + op2;;
    }else if([self isEqualToString:Minius]){
        return  op1 - op2;;
    }else if([self isEqualToString:@"^"]){
        return pow(op1, op2);
    }
    return 0;
}

-(double) calWithOneParm:(double)operand{
    double  num=0;
    if( [self isEqualToString:@"sin"]){
        num = sin(operand);
    }else if( [self isEqualToString:@"cos"]){
        num = cos(operand);
    }else if( [self isEqualToString:@"tan"]){
        num = tan(operand);
    }else if( [self isEqualToString:@"log"]){
        num = log10(operand);
    }else if( [self isEqualToString:@"ln"]){
        num = log(operand);
    }else if([self isEqualToString: @"√"]){
        num = sqrt(operand);
    }
    
    return num;
}

-(u_long) lastLocationForNumberStartAt:(u_long)start{
    u_long i =start;
    
    for(; i<self.length; i++){
        unichar c = [self characterAtIndex:i];
        if( !( (c>='0'&&c<='9')|| c=='.') )
            break;
    }
    return i-1;
}

- (int) priorityCompareTo : (NSString *)op2{
    if( [self isEqualToString:Add] || [self isEqualToString:Minius])
    {
        if([op2 isEqualToString:Add] || [op2 isEqualToString:Minius])
            return 0;
        return -1;
    }else if( [self isEqualToString:Multiply] || [self isEqualToString:Divide]){
        if([op2 isEqualToString:Multiply] || [op2 isEqualToString:Divide])
            return 0;
        if( [op2 isEqualToString:@"^"])
            return -1;
        if([op2 isEqualToString:Add] || [op2 isEqualToString:Minius])
            return 1;
        return -1;
    }
    return -1;
}

@end
