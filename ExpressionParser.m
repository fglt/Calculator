//
//  ExpressionParser.m
//  Calculator
//
//  Created by Coding on 7/24/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ExpressionParser.h"

@implementation ExpressionParser

+(NSMutableAttributedString  *)parseString:(NSString*)expression fontSize:(CGFloat)fontHeight operatorColor:(UIColor*)foreColor
{
    NSMutableAttributedString *displyText = [[NSMutableAttributedString alloc] initWithString:@" " attributes:nil];
    
    NSAttributedString *attriSpace = [[NSAttributedString alloc]initWithString:@" " attributes:nil];
    UIFont *helveticaFontLittle = [UIFont fontWithName:@"Helvetica-Bold" size:fontHeight *0.4];
    UIFont *helveticaFontBig = [helveticaFontLittle fontWithSize:fontHeight * 0.7];
    
    NSMutableArray* opArray = arrayFromString(expression);
    long  count = opArray.count;
    
    for(long  i = 0; i < count; i++)
    {
        NSString *  op = opArray[i];
        
        if([op isNumber])
        {
            NSMutableAttributedString * appText = [[NSMutableAttributedString alloc] initWithString:[@" " stringByAppendingString:op] attributes:nil];
            [displyText insertAttributedString:appText atIndex:displyText.length-1];
        }
        else{
            NSMutableAttributedString *attrString;
            
            if([op isEqualToString:FunSquare]|| [op isEqualToString:FunCube] || [op isEqualToString:FunReciprocal]){
                NSString * as ;
                if( [op isEqualToString:FunSquare] ) as = @"2";
                else if([op isEqualToString:FunCube]) as = @"3";
                else as = @"-1";
                NSRange range = NSMakeRange(0, as.length);
                attrString = [[NSMutableAttributedString alloc] initWithString:as attributes:nil];
                [attrString addAttribute:NSBaselineOffsetAttributeName value:@10 range:range];
                [attrString addAttribute:NSFontAttributeName value:helveticaFontLittle range:range];
                [displyText insertAttributedString:attriSpace atIndex:displyText.length-1];
                [attrString addAttribute:NSForegroundColorAttributeName value:foreColor range:range];
                [displyText insertAttributedString:attrString atIndex:displyText.length-1];
            }else if([op isEqualToString:FunLogBinary]){
                NSRange range = NSMakeRange(0, op.length);
                NSRange lastRange = NSMakeRange(op.length -1, 1);
                attrString = [[NSMutableAttributedString alloc] initWithString:op attributes:nil];
                [attrString addAttribute:NSFontAttributeName value:helveticaFontBig range:range];
                [attrString addAttribute:NSFontAttributeName value:helveticaFontLittle range:lastRange];
                [attrString addAttribute:NSForegroundColorAttributeName value:foreColor range:range];
                [displyText insertAttributedString:attriSpace atIndex:displyText.length-1];
                [displyText insertAttributedString:attrString atIndex:displyText.length-1];
            }else if([op isEqualToString:FunPowRoot]){
                NSRange range = NSMakeRange(0, 4);
                NSRange lastRange = NSMakeRange(3, 1);
                NSRange foreRange = NSMakeRange(1, 1);
                attrString = [[NSMutableAttributedString alloc] initWithString:@" x√y" attributes:nil];
                [attrString addAttribute:NSFontAttributeName value:helveticaFontBig range:range];
                [attrString addAttribute:NSFontAttributeName value:helveticaFontLittle range:lastRange];
                [attrString addAttribute:NSFontAttributeName value:helveticaFontLittle range:foreRange];
                [attrString addAttribute:NSForegroundColorAttributeName value:foreColor range:range];
                [attrString addAttribute:NSKernAttributeName value:@-12 range:foreRange];
                [attrString addAttribute:NSBaselineOffsetAttributeName value:@10 range:foreRange];
                [displyText insertAttributedString:attrString atIndex:displyText.length-1];
            }
            else {
                attrString = [[NSMutableAttributedString alloc] initWithString:op attributes:nil];
                NSRange range = NSMakeRange(0, op.length);
                [attrString addAttribute:NSFontAttributeName value:helveticaFontBig range:range];
                [attrString addAttribute:NSForegroundColorAttributeName value:foreColor range:range];
                [displyText insertAttributedString:attriSpace atIndex:displyText.length-1];
                [displyText insertAttributedString:attrString atIndex:displyText.length-1];
            }
        }
    }
    
    
    return displyText;

}


NSMutableArray * arrayFromString(NSString* expression)
{

    NSArray* tempArray = [expression componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@" "]];
    NSMutableArray *opArray = [NSMutableArray arrayWithArray:tempArray];
    
    long  i=0;
    while(i < opArray.count)
    {
        if([opArray[i] isEqualToString:@""])
            [opArray removeObjectAtIndex:i];
        else
            i++;
    }
    return opArray;
    
}

void checkOpArrayLast(NSMutableArray* opArray)
{
    while((opArray.count >0 ) && [opArray.lastObject isOpNeedRightOperand])
    {
        [opArray removeLastObject];
    }
    return ;
}

+(NSMutableArray *) wilCalculateWithString:(NSString*)expression
{
    NSMutableArray* opArray = arrayFromString( expression);
    //clearSpace(opArray);
    checkOpArrayLast(opArray);
    addBracket(opArray);
    addMultiply(opArray);
    
    NSLog(@"array: %@", opArray);
    
    return opArray;
}

void addBracket(NSMutableArray* opArray)
{
    u_long i = 0;
    
    int lCount = 0;
    int rCount = 0;
    
    while(i < opArray.count)
    {
        if([opArray[i] isEqualToString:RightBracket])
        {
            if(lCount == rCount)
            {
                [opArray insertObject:LeftBracket atIndex:0];
                lCount++;
                i++;
            }
            rCount ++;
        }else if ([opArray[i] isEqualToString:LeftBracket])
        {
            lCount++;
        }
        i++;
    }
    
    while(lCount > rCount)
    {
        [opArray addObject:RightBracket];
        rCount++;
    }
}

void clearSpace(NSMutableArray* opArray)
{
    u_long i = 0;
    
    while(i < opArray.count)
    {
        if([opArray[i] isEqualToString:@""])
            [opArray removeObjectAtIndex:i];
        else
            i++;
    }
}

//在π和℮两边为数字时候加乘法
//加乘法 如2(1+2)变为 2*(1+2)
void addMultiply(NSMutableArray* opArray)
{
    if((!opArray) || (opArray.count<=1)) return;
    u_long i = 0;
    while(i < opArray.count - 1){
        NSString * op1 =  opArray[i];
        NSString * op2 =  opArray[i+1];
        if([op1 isNumberic] && ([op2 isLeftBracket] || [op2 isPIOrExp]))
        {
            [opArray insertObject:Multiply atIndex:i+1];
            i++;
        }
        
        if([op1 isRightBracket] && ([op2 isNumberic] || [op2 isPIOrExp]))
        {
            [opArray insertObject:Multiply atIndex:i+1];
            i++;
        }
        if([op1 isPIOrExp] && ([op2 isNumberic] || [op2 isLeftBracket] || [op2 isPIOrExp]))
        {
            [opArray insertObject:Multiply atIndex:i+1];
            i++;
        }
        i++;
    }
}


+(NSMutableAttributedString  *)parse2String:(NSString*)expression fontSize:(CGFloat)fontHeight operatorColor:(UIColor*)foreColor
{
    
    NSMutableAttributedString *displyText = [[NSMutableAttributedString alloc] initWithString:@" " attributes:nil];
    NSAttributedString *attriSpace = [[NSAttributedString alloc]initWithString:@" " attributes:nil];
    
    NSMutableArray* opArray = arrayFromString(expression);
    long  count = opArray.count;
    
    for(long  i = 0; i < count; i++)
    {
        NSString *  op = opArray[i];
        
        if([op isNumber])
        {
            NSMutableAttributedString * appText = [[NSMutableAttributedString alloc] initWithString:[@" " stringByAppendingString:op] attributes:nil];
            [displyText insertAttributedString:appText atIndex:displyText.length-1];
        }
        else{
            NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
            UIImage *img = [ExpressionParser image2WithHeight:fontHeight string:op];
            attachment.image = img;
            attachment.bounds = CGRectMake(0, 0, img.size.width , img.size.height);
            NSAttributedString *imgText = [NSAttributedString attributedStringWithAttachment:attachment];
            [displyText insertAttributedString:attriSpace atIndex:displyText.length-1];
            [displyText insertAttributedString:imgText atIndex:displyText.length-1];
        }
    }
    
    return displyText;
    
}

+(UIImage*)imageWithHeight:(CGFloat)height string:(NSString*)string
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:height *0.6]}];
    
    CGRect textFrame;
    
    textFrame = [attrString boundingRectWithSize:CGSizeMake(200, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
    //图片宽度不小于28.
    textFrame = CGRectMake(0, 0, MAX(textFrame.size.width, 28), textFrame.size.height);
    // 1.开启上下文，第二个参数是是否不透明（opaque）NO为透明，这样可以防止占据额外空间（例如圆形图会出现方框），第三个为伸缩比例，0.0为不伸缩。
    UIGraphicsBeginImageContextWithOptions(textFrame.size, NO, 0.0);
    
    CATextLayer *layer = [CATextLayer layer];
    layer.bounds = textFrame;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.string = attrString;
    layer.contentsScale = 2.0f;
    layer.wrapped = YES;
    layer.cornerRadius = 5;
    layer.alignmentMode = kCAAlignmentCenter;
    
    // 2.将控制器view的layer渲染到上下文
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


+(UIImage*)image2WithHeight:(CGFloat)height string:(NSString*)string
{
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:string
                                           attributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:height *0.7 ] } ];
    
    //    [attrString addAttributes:@{NSBaselineOffsetAttributeName:@(5),NSFontAttributeName: [UIFont boldSystemFontOfSize:17]} range:(NSRange){3,2}];
    
    CGRect textFrame;
    
    textFrame = [attrString boundingRectWithSize:CGSizeMake(200, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    //图片宽度不小于28.
    textFrame = CGRectMake(0, 0, MAX(textFrame.size.width, 28), textFrame.size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:textFrame];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 1;
    label.attributedText = attrString;
    label.backgroundColor = [UIColor greenColor];
    label.layer.cornerRadius = 5;
    [label setTextAlignment:NSTextAlignmentCenter];
    
    // 1.开启上下文，第二个参数是是否不透明（opaque）NO为透明，这样可以防止占据额外空间（例如圆形图会出现方框），第三个为伸缩比例，0.0为不伸缩。
    UIGraphicsBeginImageContextWithOptions(textFrame.size, NO, 0.0);
    // 2.将控制器view的layer渲染到上下文
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
