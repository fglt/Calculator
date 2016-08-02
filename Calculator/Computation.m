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
@synthesize expression;
@synthesize result;
@synthesize date;

-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];

    expression = [dict objectForKey:ComputationExpressionKey];
    date = [dict objectForKey:ComputationDateKey];
    result = [dict objectForKey:ComputationResultKey];
    
    return  self;
}

+(instancetype)computationWithDictionary:(NSDictionary*) otherDictionary
{
    Computation *compuatation = [[Computation alloc]initWithDictionary:otherDictionary];
    return compuatation;
}

-(NSDictionary*)dictionary
{
    NSDictionary * dict =[ NSDictionary dictionaryWithObjects:@[self.date, self.expression, self.result] forKeys:@[ComputationDateKey, ComputationExpressionKey, ComputationResultKey]];
    return dict;
}
@end
