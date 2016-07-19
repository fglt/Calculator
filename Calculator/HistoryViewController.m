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
#import "CellSelectedControllerViewController.h"
#import "ClearHistoryController.h"

static NSString * const HistoryCellIdentifier = @"HistoryCell";

@interface HistoryViewController  () <CellSelectedControllerDelegate,ClearHistoryControllerDelegate>

@end

@implementation HistoryViewController
@synthesize computationDao;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self setRefresh];
}

- (void)setupTableView
{
    self.computationDao = [ComputationDao singleInstance];

    TableViewCellConfigureBlock configureCell = ^(ComputationCell *cell, Computation *computation) {
        [cell configureForComputation:computation];
    };
    self.computationDataSource = [[ArrayComputationDataSource alloc]initWithCellIdentifier:HistoryCellIdentifier configureCellBlock:configureCell];
    self.tableView.dataSource = self.computationDataSource;
    self.tableView.delegate = self;
   
}

-(void)setRefresh{
    UIRefreshControl *rc = [ [UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开清空记录"];
    [rc addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
}


#pragma mark - 下拉清空historyTable
-(void)clearHistory
{
    if(self.refreshControl.refreshing)
    {
        ClearHistoryController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ClearHistory"];
        
        controller.delegate = self;
        controller.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:controller animated:YES completion:nil];
        UIPopoverPresentationController *popController = [controller popoverPresentationController];
        popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
        popController.sourceView = self.tableView;
        popController.sourceRect = CGRectMake(self.tableView.bounds.size.width/4 ,self.tableView.bounds.size.height/4,self.tableView.bounds.size.width/2, self.tableView.bounds.size.height/2);
        [self.refreshControl endRefreshing];
        
    }
}


//- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
//{
//    if(self.refreshControl.refreshing){
//        [self.refreshControl endRefreshing];
//    }
//}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellSelectedControllerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"cellSelectedController"];
    
    controller.delegate = self;
    controller.indexPath = indexPath;
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    // configure the Popover presentation controller
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    UIView *view = [self.tableView cellForRowAtIndexPath:indexPath];
    popController.sourceView = view;
    popController.sourceRect = view.bounds;
}

-(void)update
{
    [self.computationDataSource update];
    [self.tableView reloadData];
}


#pragma mark - CellSelectedControllerDelegate

-(void)deleteCellAtIndex:(NSIndexPath*)indexPath
{
    [self.computationDataSource delete:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)useResultAtIndex:(NSIndexPath*)indexPath
{
    Computation* com = [self.computationDataSource itemAtIndexPath:indexPath];
    Computation *newCom = [[Computation alloc]init];
    newCom.expression = com.result;
    newCom.result = com.result;
    [self.historyDelegate useComputation:newCom];
}

-(void)useExpressionAtIndex:(NSIndexPath*)indexPath
{
    Computation* com = [self.computationDataSource itemAtIndexPath:indexPath];
    Computation *newCom = [[Computation alloc]init];
    newCom.expression = com.expression;
    newCom.result = com.result;
    [self.historyDelegate useComputation:com];
}

#pragma mark - ClearHistoryDelegate
-(void)clearTable
{
    [self.refreshControl endRefreshing];
    [self.computationDataSource deleteAll];
    [self.tableView reloadData];
}
@end
