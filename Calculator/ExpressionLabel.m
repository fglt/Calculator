//
//  ExpressionLabel.m
//  Calculator
//
//  Created by Coding on 7/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ExpressionLabel.h"


@implementation ExpressionLabel


-(void) awakeFromNib
{
    [super awakeFromNib];
    self.contentAlignment = ContentAlignmentRight;
}

-(void)setContentAlignment:(ContentAlignment)contentAlignment
{
    _contentAlignment = ContentAlignmentRight;
    [self setNeedsDisplay];
}

-(void) drawRect:(CGRect)rect
{
    NSTextContainer *container = [[NSTextContainer alloc]initWithSize:rect.size];
    NSLayoutManager *manager = [[NSLayoutManager alloc] init];
    [manager addTextContainer:container];
    NSTextStorage* storage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    [storage addLayoutManager:manager];
    CGRect frame = [manager usedRectForTextContainer:container];
    CGPoint point = [self alignOffsetViewSize:rect.size:CGRectIntegral(frame).size];
    NSRange glyphRange = [manager glyphRangeForTextContainer:container];
    [manager drawBackgroundForGlyphRange:glyphRange atPoint:point];
    [manager drawGlyphsForGlyphRange:glyphRange atPoint:point];
}

-(CGPoint) alignOffsetViewSize:(CGSize) viewSize :( CGSize)containerSize
{
    CGFloat xMargin = viewSize.width - containerSize.width;
    CGFloat yMargin = viewSize.height - containerSize.height;
    switch (self.contentAlignment) {
        case ContentAlignmentTop:
            return CGPointMake(MAX(xMargin / 2, 0), 0);
        case ContentAlignmentCenter:
            return CGPointMake(MAX(xMargin / 2, 0), MAX(yMargin / 2, 0));
        case ContentAlignmentDown:
            return CGPointMake(MAX(xMargin / 2, 0), MAX(yMargin, 0));
        case ContentAlignmentLeft:
            return CGPointMake(0,  MAX(yMargin / 2, 0));
        case ContentAlignmentRight:
            return CGPointMake( MAX(xMargin, 0), MAX(yMargin / 2, 0));

        default:
            break;
    }
    
    return CGPointMake(0,0);
}
@end
