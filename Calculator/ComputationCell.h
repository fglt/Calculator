//
//  ComputationCell.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComputationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *expression;
@property (weak, nonatomic) IBOutlet UILabel *result;

@end
