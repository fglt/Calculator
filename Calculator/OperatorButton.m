//
//  OperatorButton.m
//  Calculator
//
//  Created by Coding on 7/25/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "OperatorButton.h"

@implementation OperatorButton
+ (OperatorButton *)buttonWithType:(UIButtonType)type
{
    return [super buttonWithType:UIButtonTypeCustom];
}

-(void)attPowString:(NSString*)text
{
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    [attstr addAttribute:NSBaselineOffsetAttributeName value:@8 range:NSMakeRange(1, 1)];
    [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, 1)];
    self.titleLabel.attributedText = attstr;
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
    if (!self.backgroundLayer)
    {
        // Instantiate the gradient layer
        self.backgroundLayer = [CAGradientLayer layer];
        
        // Set the colors
        self.backgroundLayer.colors = (@[
                                     (id)[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f].CGColor,
                                     (id)[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f].CGColor]);
        
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

@implementation SquareButton
- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:@"x2" attributes:nil];
        [attstr addAttribute:NSBaselineOffsetAttributeName value:@8 range:NSMakeRange(1, 1)];
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, 1)];
        self.titleLabel.attributedText = attstr;
    }
    
    return self;
}
@end

@implementation CubeButton
- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:@"x3" attributes:nil];
        [attstr addAttribute:NSBaselineOffsetAttributeName value:@8 range:NSMakeRange(1, 1)];
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, 1)];
        self.titleLabel.attributedText = attstr;
    }
    
    return self;
}
@end

@implementation PowButton

- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:@"xy" attributes:nil];
        [attstr addAttribute:NSBaselineOffsetAttributeName value:@8 range:NSMakeRange(1, 1)];
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, 1)];
        self.titleLabel.attributedText = attstr;
    }
    
    return self;
}
@end


@implementation LogBinaryButton

- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:@"log2" attributes:nil];
        [attstr addAttribute:NSBaselineOffsetAttributeName value:@-8 range:NSMakeRange(3, 1)];
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(3, 1)];
        self.titleLabel.attributedText = attstr;
    }
    
    return self;
}
@end
