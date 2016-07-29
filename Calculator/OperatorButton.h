//
//  OperatorButton.h
//  Calculator
//
//  Created by Coding on 7/25/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorButton.h"

@interface OperatorButton : CalculatorButton
-(void)attPowString:(NSString*)text;
@end

@interface SquareButton : OperatorButton

@end

@interface CubeButton : OperatorButton
@end

@interface PowButton : OperatorButton
@end

@interface LogBinaryButton : OperatorButton
@end