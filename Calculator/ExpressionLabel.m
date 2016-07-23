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
    self.contentAlignment = ContentAlignmentTOP;
}

-(void)setContentAlignment:(ContentAlignment)contentAlignment
{
    _contentAlignment = contentAlignment;
    [self setNeedsDisplay];
}

-(void) drawRect:(CGRect)rect
{
    NSTextContainer *container = [[NSTextContainer alloc]initWithSize:rect.size];
    NSLayoutManager *manager = [[NSLayoutManager alloc] init];
    [manager addTextContainer:container];
    NSTextStorage* storage = [[NSTextStorage alloc] initWithString:self.attributedText.string];
    [storage addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,self.attributedText.length/2)];
    [storage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.attributedText.length/2,self.attributedText.length - self.attributedText.length/2)];

    [storage addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, self.attributedText.length/2)];
    [storage addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0] range:NSMakeRange(self.attributedText.length/2, self.attributedText.length - self.attributedText.length/2)];

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
        case ContentAlignmentTOP:
            return CGPointMake(MAX(xMargin / 2, 0), 0);
        case ContentAlignmentCENTER:
            return CGPointMake(MAX(xMargin / 2, 0), MAX(yMargin / 2, 0));
        case ContentAlignmentDOWN:
            return CGPointMake(MAX(xMargin / 2, 0), MAX(yMargin, 0));
        default:
            break;
    }
    
    return CGPointMake(0,0);
}
@end
