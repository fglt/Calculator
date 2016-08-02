//
//  ComputationDao.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryPlistDelegate.h"

@interface ComputationDao : NSObject
@property(strong, nonatomic) id<ComputationDelegate> delegate;
+(ComputationDao*) singleInstance;

-(void) addComputation:(Computation*)computation;
-(void) removeAtIndex:(NSInteger) index;
-(NSMutableArray *)findAll;
-(void) removeAll;

- (id)init NS_UNAVAILABLE;
@end
