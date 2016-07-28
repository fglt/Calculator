//
//  CalculatorButton.h
//  Calculator
//
//  Created by Coding on 7/27/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+BFPaperColors.h"

@interface CalculatorButton : UIButton
@property (strong,nonatomic) CAGradientLayer *backgroundLayer, *highlightBackgroundLayer;

- (void)drawHighlightBackgroundLayer;
- (void)drawBackgroundLayer;
- (void)drawButton;
@end
