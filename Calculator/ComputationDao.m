//
//  ComputationDao.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ComputationDao.h"


@implementation ComputationDao

static ComputationDao* singleInstance;

+(ComputationDao*) singleInstance
{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        singleInstance = [[self alloc] init];
        singleInstance.delegate = [[HistoryPlistDelegate alloc]init];
    });
    return singleInstance;
}

-(void) addComputation:(Computation*)computation
{
    [_delegate addComputation:computation];
}

-(void) removeAtIndex:(NSInteger) index
{
    [_delegate removeAtIndex:index];
}

-(NSMutableArray *)findAll{
    return [_delegate findAllComputation];
}

-(void) removeAll{
    [_delegate removeAll];
}

@end
