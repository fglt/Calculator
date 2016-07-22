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
    TagOfDivide = 20,
    TagOfMultiply = 21,
    TagOfMinus = 22,
    TagOfAdd = 23,
    TagOfDivide2 = 24,
    TagOfMultiply2 = 25,
    TagOfMinus2 = 26,
    TagOfAdd2 = 27,
    TagOfNumberExp = 31,
    TagOfNumberPI = 32,
    TagOfLeftBracket = 40,
    TagOfRightBracket = 41,
    TagOfLeftBracket2 = 42,
    TagOfRightBracket2 = 43,
    TagOfSignedBit = 90,
    TagOfSignedBit2 = 91,
    TagOfFunScientific = 101,
    TagOfFunSquare = 102,
    TagOfFunCube = 103,
    TagOfFunPower = 104,
    TagOfFunReciprocal = 105,
    TagOfFunRemainder = 106,
    TagOfFunFactorial = 107,
    TagOfFunSquareRoot = 108,
    TagOfFunPowRoot = 109,
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

/**
 @brief:
 +(NSDictionary *)inStackPriorityDictionary;\n
 +(NSDictionary *)outStackPriorityDictionary;\n
 +(NSString*)buttonStringWithTag:(NSUInteger)tag;\n
 +(int)stackPriorityOpOut:(NSString*)opOut OpIn :(NSString*)opIn;\n
 +(int)operatorsType:(NSString*) op;
 */
@interface CalculatorConstants : NSObject

+(NSDictionary *)inStackPriorityDictionary;
+(NSDictionary *)outStackPriorityDictionary;
+(NSString*)buttonStringWithTag:(NSUInteger)tag;
+(int)stackPriorityOpOut:(NSString*)opOut OpIn :(NSString*)opIn;
+(int)operatorsType:(NSString*) op;
@end
