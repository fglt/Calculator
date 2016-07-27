//
//  CalculatorButton.m
//  Calculator
//
//  Created by Coding on 7/27/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculatorButton.h"

@implementation CalculatorButton

@synthesize highlightBackgroundLayer;
@synthesize backgroundLayer;
@synthesize innerGlow;
+ (CalculatorButton *)buttonWithType:(UIButtonType)type
{
    return [super buttonWithType:UIButtonTypeCustom];
}

- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        [self drawButton];
        [self drawInnerGlow];
        [self drawBackgroundLayer];
        [self drawHighlightBackgroundLayer];
        
        highlightBackgroundLayer.hidden = YES;
        self.titleLabel.font =  [UIFont systemFontOfSize:25 ];
    }
    
    return self;
}

- (void)layoutSubviews
{
    // Set inner glow frame (1pt inset)
    innerGlow.frame = CGRectInset(self.bounds, 1, 1);
    
    // Set gradient frame (fill the whole button))
    backgroundLayer.frame = self.bounds;
    
    // Set inverted gradient frame
    highlightBackgroundLayer.frame = self.bounds;
    
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted
{
    // Disable implicit animation
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    // Hide/show inverted gradient
    highlightBackgroundLayer.hidden = !highlighted;
    [CATransaction commit];
    
    [super setHighlighted:highlighted];
}

#pragma mark - Layer setters

- (void)drawButton
{
    // Get the root layer (any UIView subclass comes with one)
    CALayer *layer = self.layer;
    
    layer.cornerRadius = 10;
    layer.borderWidth = 1;
    layer.borderColor = [UIColor colorWithRed:0.77f green:0.43f blue:0.00f alpha:1.00f].CGColor;
    layer.masksToBounds = YES;
}

- (void)drawBackgroundLayer
{
    // Check if the property has been set already
    if (!backgroundLayer)
    {
        // Instantiate the gradient layer
        backgroundLayer = [CAGradientLayer layer];
        
        // Set the colors
        backgroundLayer.colors = (@[
                                     (id)[UIColor colorWithRed:0.94f green:0.82f blue:0.52f alpha:1.00f].CGColor,
                                     (id)[UIColor colorWithRed:0.91f green:0.55f blue:0.00f alpha:1.00f].CGColor]);
        
        // Set the stops
        backgroundLayer.locations = (@[@0.0f,@1.0f]);
        
        // Add the gradient to the layer hierarchy
        [self.layer insertSublayer:backgroundLayer atIndex:0];
    }
}

- (void)drawHighlightBackgroundLayer
{
    if (!highlightBackgroundLayer)
    {
        highlightBackgroundLayer = [CAGradientLayer layer];
        highlightBackgroundLayer.colors = (@[
                                              (id)[UIColor colorWithRed:0.91f green:0.55f blue:0.00f alpha:1.00f].CGColor,
                                              (id)[UIColor colorWithRed:0.94f green:0.82f blue:0.52f alpha:1.00f].CGColor
                                              ]);
        highlightBackgroundLayer.locations = (@[@0.0f,@1.0f]);
        [self.layer insertSublayer:highlightBackgroundLayer atIndex:1];
    }
}

- (void)drawInnerGlow
{
    if (!innerGlow)
    {
        // Instantiate the innerGlow layer
        innerGlow = [CALayer layer];
        
        innerGlow.cornerRadius= 4;
        innerGlow.borderWidth = 1;
        innerGlow.borderColor = [[UIColor whiteColor] CGColor];
        innerGlow.opacity = 0.5;
        
        [self.layer insertSublayer:innerGlow atIndex:2];
    }
}

@end
