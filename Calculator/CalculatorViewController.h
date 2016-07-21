//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Coding on 7/19/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    TagOfLogDecimal = 110,
    TagOfLogE = 111,
    TagOfLogBinary = 112,
    TagOfSin = 120,
    TagOfCos = 121,
    TagOfTan = 122,
    TagOfArcSin = 123,
    TagOfArcCos = 124,
    TagOfArcTan = 125,
    TagOfSinh = 126,
    TagOfCosh = 127,
    TagOfTanh = 128,
} functionTag;

@protocol CalculatorViewControllerDelegate <NSObject>

-(NSMutableString *)currentExpression;
-(NSString *)currentResult;
-(void) sendExpression:(NSString *)expression;
-(void) sendResult:(NSString *)result;
-(void) equal;
@end

@interface CalculatorViewController : UIViewController
@property (nonatomic, weak) id<CalculatorViewControllerDelegate>calculatorDelegate;
@end


