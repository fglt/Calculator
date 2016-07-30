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

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundLayer.colors = (@[
                                     (id)[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f].CGColor,
                                     (id)[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f].CGColor
                                     ]);
    self.highlightBackgroundLayer.colors = (@[
                                            (id)[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f].CGColor,
                                            (id)[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f].CGColor
                                            
                                    ]);
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
