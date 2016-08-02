//
//  HistoryPlistDelegate.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "HistoryPlistDelegate.h"


static NSString* const HistoryFileName = @"history.plist";
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
        Computation* com = [Computation computationWithDictionary:dict];
        [coms addObject:com];
    }
    return coms;
}

-(void) removeAtIndex:(NSInteger)index
{
    [computations removeObjectAtIndex:index];
    [computations writeToFile:historyPath atomically:true];
}

-(void) addComputation:(Computation*)computation{
    NSDictionary *dict = [ computation dictionary];
    [computations addObject:dict];
    [computations writeToFile:historyPath atomically:true];
}

-(void) removeAll{
    [computations removeAllObjects];
    [computations writeToFile:historyPath atomically:true];
}
@end
