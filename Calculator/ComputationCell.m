//
//  ComputationCell.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ComputationCell.h"

@implementation ComputationCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.result.font = [UIFont systemFontOfSize:20];
    self.expression.font = [UIFont systemFontOfSize:17];
 
    // Initialization code
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self= [super initWithCoder:aDecoder];
    self.result.font = [UIFont systemFontOfSize:20];
    self.expression.font = [UIFont systemFontOfSize:17];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
