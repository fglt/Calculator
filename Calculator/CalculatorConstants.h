//
//  CalculatorConstants.h
//  Calculator
//
//  Created by Coding on 7/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    TagOfLogDecimal = 110,
    TagOfLogE = 111,
    TagOfLogBinary = 112,
    TagOfSin = 120,
    TagOfCos = 121,
    TagOfTan = 122,
    TagOfArcSin = 123,
    TagOfArcCos = 124,
    TagOfArcTan = 125,
    TagOfSinh = 126,
    TagOfCosh = 127,
    TagOfTanh = 128,
} functionTag;

@interface CalculatorConstants : NSObject

+(NSDictionary *)inStackPriorityDictionary;
+(NSDictionary *)outStackPriorityDictionary;
+(NSString*)buttonStringWithTag:(NSUInteger)tag;
+(int)stackPriorityOpOut:(NSString*)opOut OpIn :(NSString*)opIn;
+(int)operatorsType:(NSString*) op;
@end
