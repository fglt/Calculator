//
//  HistoryViewController.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayComputationDataSource.h"
#import "ComputationDao.h"

@protocol HistoryViewControllerDelegate <NSObject>

-(void)useComputation:(Computation*)computation;

@end

@interface HistoryViewController : UITableViewController<UITableViewDelegate>
@property (nonatomic, strong) ArrayComputationDataSource *computationDataSource;
@property (nonatomic, strong) ComputationDao* computationDao;
@property (nonatomic, weak) id<HistoryViewControllerDelegate> historyDelegate;
-(void)update;
@end
