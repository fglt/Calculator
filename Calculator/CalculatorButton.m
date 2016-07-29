//
//  CalculatorButton.m
//  Calculator
//
//  Created by Coding on 7/27/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculatorButton.h"
IB_DESIGNABLE
@implementation CalculatorButton

@synthesize highlightBackgroundLayer;
@synthesize backgroundLayer;

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
        [self drawBackgroundLayer];
        [self drawHighlightBackgroundLayer];
        
        highlightBackgroundLayer.hidden = YES;
        self.titleLabel.font =  [UIFont systemFontOfSize:30 ];
        self.contentMode = UIViewContentModeScaleToFill;
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    }
    
    return self;
}

- (void)layoutSubviews
{
    
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
    
    layer.cornerRadius = 5;
    layer.borderWidth = 1;
    layer.borderColor = [UIColor paperColorGray200].CGColor;
    layer.masksToBounds = YES;
    self.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.titleLabel.minimumScaleFactor = 0.8;
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
                                     (id)[UIColor paperColorGray100].CGColor,
                                     (id)[UIColor paperColorGray300].CGColor]);
        
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
                                             (id)[UIColor paperColorGray300].CGColor,
                                             (id)[UIColor paperColorGray100].CGColor]);
        highlightBackgroundLayer.locations = (@[@0.0f,@1.0f]);
        [self.layer insertSublayer:highlightBackgroundLayer atIndex:1];
    }
}

@end
