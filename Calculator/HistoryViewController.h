//
//  HistoryViewController.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Computation;

@protocol HistoryViewControllerDelegate <NSObject>

-(void)useComputation:(Computation*)computation;

@end

@interface HistoryViewController : UITableViewController
@property (nonatomic, weak) id<HistoryViewControllerDelegate> historyDelegate;
-(void)update;
@end
