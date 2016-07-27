//
//  CalculatorButton.h
//  Calculator
//
//  Created by Coding on 7/27/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorButton : UIButton
@property (strong,nonatomic) CAGradientLayer *backgroundLayer, *highlightBackgroundLayer;
@property (strong,nonatomic) CALayer *innerGlow;
- (void)drawInnerGlow;
- (void)drawHighlightBackgroundLayer;
- (void)drawBackgroundLayer;
- (void)drawButton;
@end
