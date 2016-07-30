//
//  OperatorButton.m
//  Calculator
//
//  Created by Coding on 7/25/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "OperatorButton.h"
#import "UIColor+BFPaperColors.h"
IB_DESIGNABLE
@implementation OperatorButton

- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        self.backgroundLayer.colors = (@[
                                         (id)[UIColor paperColorGray400].CGColor,
                                         (id)[UIColor paperColorGray600].CGColor
                                         ]);
        self.highlightBackgroundLayer.colors = (@[
                                                  (id)[UIColor paperColorGray600].CGColor,
                                                  (id)[UIColor paperColorGray400].CGColor
                                                  ]);

    }
    
    return self;
}

-(void)attPowString:(NSString*)text
{
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    [attstr addAttribute:NSBaselineOffsetAttributeName value:@8 range:NSMakeRange(1, 1)];
    [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, 1)];
    self.titleLabel.attributedText = attstr;
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
        [self  attPowString:@"x2"];
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
       [self  attPowString:@"x3"];
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
       [self  attPowString:@"xy"];
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
