//
//  ComputationDao.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Computation.h"
#import "HistoryPlistDelegate.h"

@interface ComputationDao : NSObject
@property(strong, nonatomic) id<ComputationDelegate> delegate;
+(ComputationDao*) singleInstance;

-(void) add:(Computation*)computation;
-(void) remove:(NSInteger) index;
-(NSMutableArray *)findAll;
-(void) removeAll;
@end
