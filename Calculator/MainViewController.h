//
//  MainViewController.h
//  MyCalculator
//
//  Created by Coding on 7/13/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Computation.h"
#import "ComputationDao.h"
#import "HistoryViewController.h"

@interface MainViewController : UIViewController<UIScrollViewDelegate, HistoryViewControllerDelegate>

@property(nonatomic, strong) UITableView* historyTable;

@end
