//
//  HistoryViewController.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "HistoryViewController.h"
#import "ComputationCell.h"
#import "ArrayComputationDataSource.h"
#import "Computation.h"
#import "ComputaionCell+ConfigureForComputation.h"

static NSString * const HistoryCellIdentifier = @"HistoryCell";

@interface HistoryViewController  () <UITableViewDelegate>

@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView
{
    NSMutableArray *computations = [NSMutableArray arrayWithCapacity:10];
    TableViewCellConfigureBlock configureCell = ^(ComputationCell *cell, Computation *computation) {
        [cell configureForComputation:computation];
    };
    self.computationDataSource = [[ArrayComputationDataSource alloc]initWithItems:computations cellIdentifier:HistoryCellIdentifier configureCellBlock:configureCell];
    self.tableView.dataSource = self.computationDataSource;
    self.tableView.delegate = self;
   
}

//#pragma mark UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 5;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ComputationCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier];
//    if(cell == nil)
//    {
//        cell = [[ComputationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HistoryCellIdentifier];
//    }
//    
//ComputationCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier forIndexPath:indexPath];
//cell.date.text = @"7\n17";
//cell.expression.text = @"1+2+3\n6";
//    return cell;
//}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
}
@end
