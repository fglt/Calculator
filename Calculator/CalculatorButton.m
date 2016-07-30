//
//  CalculatorButton.m
//  Calculator
//
//  Created by Coding on 7/27/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculatorButton.h"
#import "UIColor+BFPaperColors.h"
IB_DESIGNABLE
@implementation CalculatorButton

-(void)drawButton{
    self.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.titleLabel.minimumScaleFactor = 0.5;
    self.titleLabel.font =  [UIFont systemFontOfSize:35 ];
    self.contentMode = UIViewContentModeScaleToFill;
    [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    CALayer *layer = self.layer;
    
    layer.cornerRadius = 5;
    layer.borderWidth = 1;
    layer.borderColor = [UIColor paperColorGray200].CGColor;
    layer.masksToBounds = YES;
}

-(instancetype) init{
    self = [super init];
    if(self){
        [self drawButton];
        [self drawBackgroundLayer];
        [self drawHighlightBackgroundLayer];
    
        _highlightBackgroundLayer.hidden = YES;
    }
    return self;
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
        
        _highlightBackgroundLayer.hidden = YES;
       }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self drawButton];
        [self drawBackgroundLayer];
        [self drawHighlightBackgroundLayer];
        
        _highlightBackgroundLayer.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    // Set gradient frame (fill the whole button))
    _backgroundLayer.frame = self.bounds;
    // Set inverted gradient frame
    _highlightBackgroundLayer.frame = self.bounds;
    
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted
{
    // Disable implicit animation
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    // Hide/show inverted gradient
    _highlightBackgroundLayer.hidden = !highlighted;
    [CATransaction commit];
    
    [super setHighlighted:highlighted];
}

#pragma mark - Layer setters

- (void)drawBackgroundLayer
{
    // Check if the property has been set already
    if (!_backgroundLayer)
    {
        // Instantiate the gradient layer
        _backgroundLayer = [CAGradientLayer layer];
        
        // Set the colors
        _backgroundLayer.colors = (@[
                                     (id)[UIColor paperColorGray100].CGColor,
                                     (id)[UIColor paperColorGray300].CGColor]);
        
        // Set the stops
       _backgroundLayer.locations = (@[@0.0f,@1.0f]);
        
        // Add the gradient to the layer hierarchy
        [self.layer insertSublayer:_backgroundLayer atIndex:0];
    }
}

- (void)drawHighlightBackgroundLayer
{
    if (!_highlightBackgroundLayer)
    {
        _highlightBackgroundLayer = [CAGradientLayer layer];
        _highlightBackgroundLayer.colors = (@[
                                             (id)[UIColor paperColorGray300].CGColor,
                                             (id)[UIColor paperColorGray100].CGColor]);
        _highlightBackgroundLayer.locations = (@[@0.0f,@1.0f]);
        [self.layer insertSublayer:_highlightBackgroundLayer atIndex:1];
    }
}

@end
