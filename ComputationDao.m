//
//  ComputationDao.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ComputationDao.h"


@implementation ComputationDao
@synthesize delegate;
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

-(void) add:(Computation*)computation
{
    [self.delegate add:computation];
}

-(void) remove:(NSInteger) index
{
    [self.delegate remove:index];
}

-(NSMutableArray *)findAll{
    return [self.delegate findAllComputation];
}

-(void) removeAll{
    [self.delegate removeAll];
}

@end
