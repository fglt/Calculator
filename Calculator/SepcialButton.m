//
//  SepcialButton.m
//  Calculator
//
//  Created by Coding on 7/28/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "SepcialButton.h"
#import "UIColor+BFPaperColors.h"

IB_DESIGNABLE
@implementation SepcialButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.backgroundLayer.colors = (@[
                                         (id)[UIColor paperColorOrange400].CGColor,
                                         (id)[UIColor paperColorOrange600].CGColor]);
        self.highlightBackgroundLayer.colors = (@[
                                                  (id)[UIColor paperColorOrange600].CGColor,
                                                  (id)[UIColor paperColorOrange400].CGColor
                                                  ]);

    }
    return self;
}

@end

