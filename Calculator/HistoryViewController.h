//
//  HistoryViewController.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayComputationDataSource.h"

@interface HistoryViewController : UITableViewController
@property (nonatomic, strong) ArrayComputationDataSource *computationDataSource;
@end
