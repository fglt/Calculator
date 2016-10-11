//
//  Expression.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "Computation.h"

 NSString* const ComputationDateKey = @"date";
 NSString* const ComputationExpressionKey = @"expression";
 NSString* const ComputationResultKey = @"result";
@implementation Computation


-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];

    _expression = [dict objectForKey:ComputationExpressionKey];
    _date = [dict objectForKey:ComputationDateKey];
    _result = [dict objectForKey:ComputationResultKey];
    
    return  self;
}
- (instancetype)initWithExpression:(NSString *)expression result:(NSString *)result date:(NSDate *)date
{
    self = [super init];
    
    _expression = expression;
    _date = date;
    _result = result;
    
    return  self;

}

+(instancetype)computationWithDictionary:(NSDictionary*) otherDictionary
{
    Computation *compuatation = [[Computation alloc]initWithDictionary:otherDictionary];
    return compuatation;
}

-(NSDictionary*)dictionary
{
    NSDictionary * dict =[ NSDictionary dictionaryWithObjects:@[_date, _expression, _result] forKeys:@[ComputationDateKey, ComputationExpressionKey, ComputationResultKey]];
    return dict;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"<%@: %p, %@>", [self class], self, _expression];
}
@end
