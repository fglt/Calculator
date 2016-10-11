//
//  Expression.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
extern  NSString* const ComputationDateKey ;
extern  NSString* const ComputationExpressionKey;
extern  NSString* const ComputationResultKey ;

@interface Computation : NSObject
@property (nonatomic,copy) NSString* expression;
@property (nonatomic,copy) NSString* result;
@property (nonatomic,strong) NSDate* date;

-(instancetype)initWithDictionary:(NSDictionary*) otherDictionary;
- (instancetype)initWithExpression:(NSString *)expression result:(NSString *)result date:(NSDate *)date;
- (instancetype)initWithExpression:(NSString *)expression result:(NSString *)result;
+(instancetype)computationWithDictionary:(NSDictionary*) otherDictionary;
-(NSDictionary*)dictionary;
@end


@protocol ComputationDelegate <NSObject>

@required
-(NSMutableArray*) findAllComputation;
-(void) removeAtIndex:(NSInteger)index;
-(void) addComputation:(Computation*)computation;
-(void) removeAll;

@end
