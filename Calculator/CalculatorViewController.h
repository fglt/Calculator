//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Coding on 7/19/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalculatorViewControllerDelegate <NSObject>

-(NSString *)currentExpression;
-(NSString *)currentResult;
-(void) sendExpression:(NSString *)expression;
-(void) sendResult:(NSString *)result;
-(void) equal;
@end

@interface CalculatorViewController : UIViewController
@property (nonatomic, weak) id<CalculatorViewControllerDelegate>calculatorDelegate;
@end
