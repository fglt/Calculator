//
//  Expression.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Computation : NSObject
@property NSString* expression;
@property NSString* result;
@property NSDate* date;

@end

@protocol ComputationDelegate <NSObject>

@required
-(NSMutableArray*) findAllComputation;
-(void) remove:(NSInteger)index;
-(void) add:(Computation*)computation;
-(void) removeAll;

@end