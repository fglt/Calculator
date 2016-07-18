//
//  HistorysViewController.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "HistorysViewController.h"
#import "ComputationCell.h"


static NSString * const HistoryCellIdentifier = @"HistoryCell";

@implementation HistorysViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[ComputationCell nib] forCellReuseIdentifier:HistoryCellIdentifier];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ComputationCell *cell = [tableView dequeueReusableCellWithIdentifier:          HistoryCellIdentifier];
//    if(cell == nil)
//    {
//        cell = [[ComputationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HistoryCellIdentifier];
//    }
    ComputationCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier forIndexPath:indexPath];
    cell.date.text = @"7\n17";
    cell.expression.text = @"1+2+3\n6";
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
