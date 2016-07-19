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

@property (weak, nonatomic) IBOutlet UIStackView *stack1;
@property (weak, nonatomic) IBOutlet UIStackView *stack2;

@property (weak, nonatomic) IBOutlet UIScrollView * scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl * pageControl;

@property(nonatomic, strong) UITableView* historyTable;

@end
