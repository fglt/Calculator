//
//  BaseView.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView


-(void)awakeFromNib
{
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
}
@end
