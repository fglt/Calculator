//
//  CalculatorBrain.h
//  MyCalculator
//
//  Created by Coding on 5/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(id) initWithInput:(NSString *)text;
-(double) calculate;
@property NSString * expression;
@end
