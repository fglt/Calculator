//
//  ExpressionLabel.h
//  Calculator
//
//  Created by Coding on 7/20/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ContentAlignmentTOP = 0,
    ContentAlignmentCENTER ,
    ContentAlignmentDOWN
} ContentAlignment;


@interface ExpressionLabel : UILabel
@property (nonatomic) ContentAlignment contentAlignment;
@end
