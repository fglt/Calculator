//
//  SepcialButton.m
//  Calculator
//
//  Created by Coding on 7/28/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "SepcialButton.h"

@implementation SepcialButton

#pragma mark - Layer setters

- (void)drawBackgroundLayer
{
    // Check if the property has been set already
    if (!self.backgroundLayer)
    {
        // Instantiate the gradient layer
        self.backgroundLayer = [CAGradientLayer layer];
        
        // Set the colors
        self.backgroundLayer.colors = (@[
                                         (id)[UIColor colorWithRed:0.90f green:0.7f blue:0.15f alpha:1.00f].CGColor,
                                         (id)[UIColor colorWithRed:0.7f green:0.5f blue:0.0f alpha:1.00f].CGColor]);
        
        // Set the stops
        self.backgroundLayer.locations = (@[@0.0f,@1.0f]);
        
        // Add the gradient to the layer hierarchy
        [self.layer insertSublayer:self.backgroundLayer atIndex:0];
    }
}

- (void)drawHighlightBackgroundLayer
{
    if (!self.highlightBackgroundLayer)
    {
        self.highlightBackgroundLayer = [CAGradientLayer layer];
        self.highlightBackgroundLayer.colors = (@[
                                                  (id)[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f].CGColor,
                                                  (id)[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f].CGColor
                                                  ]);
        self.highlightBackgroundLayer.locations = (@[@0.0f,@1.0f]);
        [self.layer insertSublayer:self.highlightBackgroundLayer atIndex:1];
    }
}

@end

