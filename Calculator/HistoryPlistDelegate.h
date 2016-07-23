//
//  HistoryPlistDelegate.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Computation.h"

@interface HistoryPlistDelegate : NSObject<ComputationDelegate>
@property (nonatomic, strong) NSMutableArray* computations;
@property (nonatomic, strong) NSString * historyPath;
@end
