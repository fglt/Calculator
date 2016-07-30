//
//  ExpressionParser.h
//  Calculator
//
//  Created by Coding on 7/24/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressionParser : NSObject
//@property (nonatomic, strong) NSString* expressioin;

+(NSMutableAttributedString  *)parseString:(NSString*)expression font:(UIFont*)font operatorColor:(UIColor*)color;

+(NSMutableAttributedString  *)parse2String:(NSString*)expression font:(UIFont*)font operatorColor:(UIColor*)foreColor;

+(NSMutableArray *) wilCalculateWithString:(NSString*)expression;
@end
