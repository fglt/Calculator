//
//  CalculatorBrain.m
//  MyCalculator
//
//  Created by Coding on 5/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculatorBrain.h"
#import "constants.h"
#import "factorial.h"
#import "NSString+Calculator.h"

@interface CalculatorBrain()
@property NSMutableArray *operators;
@property NSMutableArray *operands;

@end

@implementation CalculatorBrain
@synthesize expression;
@synthesize operators;
@synthesize operands;

-(id) initWithInput:(NSString *)text{
    expression = text;
    operators =[ NSMutableArray array];
    operands =[ NSMutableArray array];
    return  self;
}

- (NSString *)fixInput{
    NSMutableString *result = [NSMutableString stringWithString: expression];
    u_long i;
    int lCount = 0;
    int rCount = 0;
    
    //加乘法 如2(1+2)变为 2*(1+2)
    for(i=1; i<result.length-1; i++){
        unichar c = [result characterAtIndex:i];
        if( (c == ')' && [self isDigital:[result characterAtIndex:i+1]]) || ( c == '(' && [self isDigital:[result characterAtIndex:i-1]] ) )
        {
            [result replaceCharactersInRange:NSMakeRange(i, 1) withString:[self ext:c :NO]];
            i= i+2;
        }
    }
    //在π和℮两边为数字时候加乘法
    for(i=0; i<result.length-1; i++)
    {
        unichar c = [result characterAtIndex:i];
        if( c == [PIAndE characterAtIndex:0]||c == [PIAndE characterAtIndex:1])
        {
            unichar ch = [result characterAtIndex:i+1];
            if( [self isDigital:ch]){
                [result  replaceCharactersInRange:NSMakeRange(i, 1) withString:[self ext:c :NO]];
                i++;
            }
        }
    }
    for(i=1; i<result.length; i++)
    {
        unichar c = [result characterAtIndex:i];
        if( c == [PIAndE characterAtIndex:0]||c == [PIAndE characterAtIndex:1])
        {
            unichar ch = [result characterAtIndex:i-1];
            if( [self isDigital:ch]){
                [result  replaceCharactersInRange:NSMakeRange(i, 1) withString:[self ext:c :YES]];
                i++;
            }
        }
    }
    
    i=0;
    
    //补全括号
    while(i<result.length){
        unichar c = [result characterAtIndex:i];
        if( c == ')' )
        {
            if(rCount == lCount){
                NSString * startc = [result substringToIndex:1];
                [result replaceCharactersInRange:NSMakeRange(0, 1) withString:[@"(" stringByAppendingString:startc] ];
                lCount++;
                i++;
            }
            
            rCount++;
        }else if(c == '('){
            lCount++;
        }
        
        i++;
    }
    while(lCount>rCount){
        [result appendString:@")"];
        rCount++;
    }
    

    return result;
}

-(NSString *) ext:(unichar)ch :(BOOL)isLeft
{
    if(ch== [PIAndE characterAtIndex:0] && isLeft) return @"×π";
    if(ch== [PIAndE characterAtIndex:0] && !isLeft) return @"π×";
    if(ch== [PIAndE characterAtIndex:1] && isLeft) return @"×℮";
    if(ch== [PIAndE characterAtIndex:1] && !isLeft) return @"℮×";
    if(ch== ')' ) return @")×";
    if(ch== '(' ) return @"×(";
    return nil;
}


//×÷
-(BOOL)check
{
    NSString * const ck = @"×÷+-()√^";
    NSString * input = expression;
    
    u_long l = input.length;
    int  i=1;
    
    unichar c;
    
    c = [input characterAtIndex:0];
    
    //如果左括号右边出现乘除法 错误
    if(c == '('){
        unichar nc = [input characterAtIndex:1];
        if( nc == [ck characterAtIndex:1] || nc == [ck characterAtIndex:0] ){
             NSLog(@"check ( ERROR");
            return NO;
           
        }
    }
    c = [input characterAtIndex:l-1];
    //如果右括号左边边出现加减乘除 错误
    if(c == ')'){
        unichar nc = [input characterAtIndex:l-2];
        if( nc == [ck characterAtIndex:0] || nc == [ck characterAtIndex:1] || nc == [ck characterAtIndex:2] || nc == [ck characterAtIndex:3] ){
             NSLog(@"check ) ERROR");
            return NO;
        }
    }
    //如果左括号右边出现乘除法 错误；如果右括号左边边出现加减乘除 错误
    
    while(i < l-1){
        unichar c = [input characterAtIndex:i];
        unichar nc;
        
        if(c == '('){
            nc = [input characterAtIndex:i+1];
            if( nc == [ck characterAtIndex:0] || nc == [ck characterAtIndex:1] ){
                 NSLog(@"check ( ERROR");
                return NO;
            }
        }else if (c == ')'){
            nc = [input characterAtIndex:i-1];
            if( nc == [ck characterAtIndex:0] || nc == [ck characterAtIndex:1] || nc == [ck characterAtIndex:2] || nc == [ck characterAtIndex:3] ){
                 NSLog(@"check ) ERROR");
                return NO;
            }
        }
        
        i++;
    }
    
    //如果根号或N方右边不为数字左括号，错误
    i=0;
    while( i<l-1){
        c = [input characterAtIndex:i];
        
        if( c == [ck characterAtIndex:6] || c == '(' ){
            unichar nc = [input characterAtIndex:i+1];
            if( ![self isRightOKOfSquareOrPower:nc] ){
                 NSLog(@"check 根号或N方右边不为数字左括号 ERROR");
                return NO;
            }
        }
        i++;
    }
    c= [input characterAtIndex:input.length-1];
    if( c == [ck characterAtIndex:6] || c == '('){
        NSLog(@"check 根号或N方右边不为数字左括号 ERROR");

        return NO;
    }
    
    return YES;
}

-(BOOL) isRightOKOfSquareOrPower:(unichar)c
{
    NSString *ck = @".(sctl√℮π+-";
    if(c>='0'&&c<='9') return YES;
    //return (c>='0'&&c<='9') || c=='.' || c== '(' || c=='s' || c== 'c'|| c=='t'|| c=='l'|| [@"√" characterAtIndex:0];
    for(int i=0; i<ck.length; i++){
        if(c == [ck characterAtIndex:i])
            return YES;
    }
    return NO;
}
-(double) calculate{
    
    double result =0;
    
    BOOL expressionOK = [self check];
    
    if(!expressionOK)
        return INFINITY;
    
    NSString *input = [self fixInput];
    
    NSLog(@"input: %@",input);
    u_long len = input.length;
    NSString *ch;
    NSString *operator;

    u_long oprCount, opdCount;
    u_long i =0;
    
    u_long  lastIndex = 0;
    
    BOOL isOpNegative = true;//数字能否有符号位
    BOOL isNegative = false ;//数字符号位为-
    
    for(; i<len; ++i){
        if(isOpNegative){
            NSString *tmpch = [input substringWithRange:NSMakeRange(i, 1)];
            if([tmpch isEqualToString:Add] )
                i++;
            else if([tmpch isEqualToString:Minius] ){
                i++;
                isNegative = true;
            }
            isOpNegative = false;
        }
        ch = [input substringWithRange:NSMakeRange(i, 1)];
        u_long oprCount ;
        
        if( [ch isDigit]||[ch isEqualToString:Dot]){
            lastIndex = [input lastLocationForNumberStartAt: i];
            NSString *tmp = [input substringWithRange:NSMakeRange(i, lastIndex-i+1)];
            if(isNegative){
                tmp = [Minius stringByAppendingString:tmp];
                isNegative = false;
            }
            NSNumber *number =  [ NSNumber numberWithDouble:[tmp doubleValue]];
            [operands addObject:number];
            i = lastIndex;
        }else if([ch isOperator]) {
            oprCount = [operators count];
            while( oprCount>0 && (![ (operator=[operators objectAtIndex:oprCount-1]) isEqualToString: LeftBracket]) && [ch priorityCompareTo:operator]<=0){
                double num = [self calWithOperator:operator];
                [operands addObject: [NSNumber numberWithDouble:num] ] ;
                [operators removeLastObject];
                oprCount--;
            }
            
            [operators addObject:ch];
        }else if([ch isEqualToString:LeftBracket] ){
            isOpNegative = true;
            [operators addObject:ch];
        }else if([ch isEqualToString:RightBracket] ){
           
            
            while( (oprCount =[operators count]) >0 && ![( operator = [operators objectAtIndex:oprCount-1]) isEqualToString:LeftBracket])
            {
                [operators removeLastObject];
                double num = [self calWithOperator:operator];
                [operands addObject: [NSNumber numberWithDouble:num] ] ;
            }
            if([operator isEqualToString:LeftBracket])
                [operators removeLastObject];
        }else if( [ch isEqualToString:@"π"] ){
            [operands addObject:[NSNumber numberWithDouble:M_PI] ];
        }else if( [ch isEqualToString:@"℮"] ){
            [operands addObject:[NSNumber numberWithDouble:M_E] ];
        }else if( [ch isEqualToString:@"!"] ){
            opdCount = [operands count];
            double num = [[operands objectAtIndex:opdCount-1] doubleValue];
            [operands removeLastObject];
            num = [[NSString stringWithFormat:@"%f", factorial(num)] doubleValue];
            NSLog(@"num: %e", num);
            [operands addObject:[NSNumber numberWithDouble:num] ];
        }else if( [ch isEqualToString:@"^"]){
            [operators addObject:ch];
            isOpNegative = true;
        }else if( [ch isEqualToString:@"√"]){
            [operators addObject:ch];
        }else if( [ch isMathFunction]){
            int x = 2;
            if([ch isEqualToString:@"s"]){
                [operators addObject:@"sin"];
                isOpNegative = true;
            }
            else if([ch isEqualToString:@"c"]){
                [operators addObject:@"cos"];
                isOpNegative = true;
            }
            else if([ch isEqualToString:@"t"]){
                [operators addObject:@"tan"];
                isOpNegative = true;
            }
            else if([ch isEqualToString:@"l"]){
                unichar  nextc = [input characterAtIndex:i+1];
                
                if( nextc == 'n')
                {
                    [operators addObject:@"ln"];
                    x=1;
                }else{
                    [operators addObject:@"log"];
                }
            }
            i=i+x;
        }
        else {
            NSLog(@"calculat: ERROE");
            return INFINITY;
        }
    }
    
    oprCount =[operators count];
    while (oprCount>0){
        double num;
        operator = [operators objectAtIndex:oprCount-1];
        [operators removeLastObject];
        oprCount--;
        
        num = [self calWithOperator:operator];
        
        [operands addObject: [NSNumber numberWithDouble:num] ] ;
        
    }
    
    opdCount = [operands count];
    result = [[operands objectAtIndex:opdCount-1] doubleValue];
    
    return result;
    
}

-(double) calWithOperator:(NSString *)operator
{
    
    double num = 0;
    u_long opdCount = [operands count];
    
    if([operator isEqualToString: @"√"] || [operator isMathFunction]){
        double num1 = [[operands objectAtIndex:opdCount-1] doubleValue];
        [operands removeLastObject];
        num = [operator calWithOneParm:num1];
        
    }else if( [operator isEqualToString: @"^"] || [operator isOperator]){
        
        if(opdCount>=2){
            double num2 = [[operands objectAtIndex:opdCount-1] doubleValue];
            [operands removeLastObject];
            double num1 = [[operands objectAtIndex:opdCount-2] doubleValue];
            [operands removeLastObject];
            num = [operator calWithTwoParm:num1 :num2];
        }else if(opdCount==1){
            num = [[operands objectAtIndex:0] doubleValue];
        }else{
            num = 0;
        }
    }
    
    return num;
}


-(BOOL)isDigital:(unichar)ch
{
    return (ch>='0'&&ch<='9') || ch=='.'|| ch == [PIAndE characterAtIndex:0]|| ch == [PIAndE characterAtIndex:1];
}

@end

