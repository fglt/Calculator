//
//  ExpressionParser.m
//  Calculator
//
//  Created by Coding on 7/24/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ExpressionParser.h"
#import "NSString+Calculator.h"
#import "constants.h"

@implementation ExpressionParser

+(NSMutableAttributedString  *)parseString:(NSString*)expression font:(UIFont*)font operatorColor:(UIColor*)foreColor
{
    NSMutableAttributedString *displyText = [[NSMutableAttributedString alloc] initWithString:@" " attributes:nil];
    
    NSAttributedString *attriSpace = [[NSAttributedString alloc]initWithString:@" " attributes:nil];
    UIFont *fontLittle = [font  fontWithSize:font.pointSize *0.6];

    
    NSMutableArray* opArray = arrayFromString(expression);
    long  count = opArray.count;
    
    for(long  i = 0; i < count; i++)
    {
        NSString *  op = opArray[i];
        
        if([op isNumber])
        {
            NSMutableAttributedString * appText = [[NSMutableAttributedString alloc] initWithString:[@" " stringByAppendingString:op] attributes:nil];
            [appText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, op.length)];
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
                [attrString addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:font.pointSize/2] range:range];
                [attrString addAttribute:NSFontAttributeName value:fontLittle range:range];
                [displyText insertAttributedString:attriSpace atIndex:displyText.length-1];
                [attrString addAttribute:NSForegroundColorAttributeName value:foreColor range:range];
                [displyText insertAttributedString:attrString atIndex:displyText.length-1];
            }else if([op isEqualToString:FunLogBinary]){
                NSRange range = NSMakeRange(0, op.length);
                NSRange lastRange = NSMakeRange(op.length -1, 1);
                attrString = [[NSMutableAttributedString alloc] initWithString:op attributes:nil];
                [attrString addAttribute:NSFontAttributeName value:font range:range];
                [attrString addAttribute:NSFontAttributeName value:fontLittle range:lastRange];
                [attrString addAttribute:NSForegroundColorAttributeName value:foreColor range:range];
                [displyText insertAttributedString:attriSpace atIndex:displyText.length-1];
                [displyText insertAttributedString:attrString atIndex:displyText.length-1];
            }else if([op isEqualToString:FunPowRoot]){
                NSRange range = NSMakeRange(0, 4);
                NSRange lastRange = NSMakeRange(3, 1);
                NSRange foreRange = NSMakeRange(1, 1);
                attrString = [[NSMutableAttributedString alloc] initWithString:@" x√y" attributes:nil];
                [attrString addAttribute:NSFontAttributeName value:font range:range];
                [attrString addAttribute:NSFontAttributeName value:fontLittle range:lastRange];
                [attrString addAttribute:NSFontAttributeName value:fontLittle range:foreRange];
                [attrString addAttribute:NSForegroundColorAttributeName value:foreColor range:range];
                [attrString addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:-sqrt(font.pointSize)-2] range:NSMakeRange(1, 2)];
                [attrString addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:sqrt(font.pointSize)+3] range:foreRange];
                [displyText insertAttributedString:attrString atIndex:displyText.length-1];
            }
            else {
                attrString = [[NSMutableAttributedString alloc] initWithString:op attributes:nil];
                NSRange range = NSMakeRange(0, op.length);
                [attrString addAttribute:NSFontAttributeName value:font range:range];
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
    
//    NSLog(@"array: %@", opArray);
    
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


+(NSMutableAttributedString  *)parse2String:(NSString*)expression font:(UIFont*)font operatorColor:(UIColor*)foreColor
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
            
            u_long curPosition = displyText.length - 1;
            NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
            UIImage *img = [ExpressionParser image2WithHeight:font string:op];
            attachment.image = img;
            attachment.bounds = CGRectMake(0, 0, img.size.width , img.size.height);
            NSAttributedString *imgText = [NSAttributedString attributedStringWithAttachment:attachment];
            
            [displyText insertAttributedString:attriSpace atIndex:displyText.length-1];
            [displyText insertAttributedString:imgText atIndex:displyText.length-1];
            [displyText addAttribute:NSBaselineOffsetAttributeName value:@-3 range:NSMakeRange(curPosition+1 , imgText.length)];
        }
    }
    
    return displyText;
    
}

+(UIImage*)imageWithHeight:(UIFont*)font string:(NSString*)string
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
    
    CGRect textFrame;
    
    textFrame = [attrString boundingRectWithSize:CGSizeMake(200, font.pointSize) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    
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


+(UIImage*)image2WithHeight:(UIFont*)font string:(NSString*)string
{
//    static NSMutableArray *array ;
//    if(!array){
//        array =[NSMutableArray array];
//    }

    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:string
                                           attributes:@{ NSFontAttributeName: font} ];
    
    //    [attrString addAttributes:@{NSBaselineOffsetAttributeName:@(5),NSFontAttributeName: [UIFont boldSystemFontOfSize:17]} range:(NSRange){3,2}];
    
    CGRect textFrame;
    
    textFrame = [attrString boundingRectWithSize:CGSizeMake(200, font.pointSize) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    //图片宽度不小于28.
    textFrame = CGRectMake(0, 0, MAX(textFrame.size.width, 28), textFrame.size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:textFrame];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 1;
    label.attributedText = attrString;
    label.backgroundColor = [UIColor greenColor];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    [label setTextAlignment:NSTextAlignmentCenter];
    
    // 1.开启上下文，第二个参数是是否不透明（opaque）NO为透明，这样可以防止占据额外空间（例如圆形图会出现方框），第三个为伸缩比例，0.0为不伸缩。
    UIGraphicsBeginImageContextWithOptions(textFrame.size, NO, 0.0);
    // 2.将控制器view的layer渲染到上下文
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
//    if(![array containsObject:string]){
//        [array addObject:string];
//        [ExpressionParser saveImageToFile:string image:newImage];
//    }
    return newImage;
}

+(void)saveImageToFile:(NSString *)path image:(UIImage *)image
{
    
    NSString * home = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    // Create paths to output images
    NSString * fp = [home stringByAppendingPathComponent:path];
    NSString  * pngPath = [fp stringByAppendingPathExtension:@"png"];
    NSString  *jpgPath = [fp stringByAppendingPathExtension:@"jpg"];
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:jpgPath atomically:YES];
    
    // Write image to PNG
    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
    //UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    // Let's check to see if files were successfully written...
    
    // Create file manager
//    NSError *error;
//    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // Write out the contents of home directory to console
//    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:home error:&error]);
}

@end
