//
//  calButton.h
//  MyCalculator
//
//  Created by Coding on 5/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DigitButton : UIButton

@property (strong,nonatomic) CAGradientLayer *backgroundLayer, *highlightBackgroundLayer;
@property (strong,nonatomic) CALayer *innerGlow;

@end
