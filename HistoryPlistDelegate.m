//
//  HistoryPlistDelegate.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "HistoryPlistDelegate.h"

static NSString* const HistoryFileName = @"history.plist";
static NSString* const DateKey = @"date";
static NSString* const ExpressionKey = @"expression";
static NSString* const ResultKey = @"result";

@implementation HistoryPlistDelegate
@synthesize computations;
@synthesize historyPath;


-(id)init{
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    historyPath = [dir stringByAppendingPathComponent:HistoryFileName];
    NSFileManager *manager = [ NSFileManager defaultManager];
    BOOL  fileExits = [manager fileExistsAtPath:historyPath];
    if(fileExits){
        computations = [NSMutableArray arrayWithContentsOfFile:historyPath];
    }
    
    if(computations  == nil)
        computations = [NSMutableArray array];
    
    return self;
}

-(NSMutableArray*) findAllComputation
{
    NSMutableArray<Computation*> *coms = [NSMutableArray arrayWithCapacity:20];
    for(NSDictionary* dict in computations)
    {
        Computation* com = [[Computation alloc] init];
        com.date = [dict objectForKey:DateKey];
        com.expression = [dict objectForKey:ExpressionKey];
        com.result = [dict objectForKey:ResultKey];
        [coms addObject:com];
    }
    return coms;
}

-(void) remove:(NSInteger)index
{
    [computations removeObjectAtIndex:index];
    [computations writeToFile:historyPath atomically:true];
}

-(void) add:(Computation*)computation{
    NSDictionary *dict = [ NSDictionary dictionaryWithObjects:@[computation.date, computation.expression, computation.result] forKeys:@[DateKey, ExpressionKey, ResultKey]];
    [computations addObject:dict];
    [computations writeToFile:historyPath atomically:true];
}

-(void) removeAll{
    [computations removeAllObjects];
    [computations writeToFile:historyPath atomically:true];
}
@end
