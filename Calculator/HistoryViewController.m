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

@interface HistoryViewController  () <CellSelectedControllerDelegate,UIPopoverPresentationControllerDelegate,ClearHistoryControllerDelegate>

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
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"清空记录"
//                                                                       message:@"是否清空记录？"
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No"
//                                                           style:UIAlertActionStyleCancel
//                                                         handler:^(UIAlertAction *action){
//                                                             [self.refreshControl endRefreshing];
//                                                             
//                                                         }];
//        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes"
//                                                            style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction *action){
//                                                              [self.refreshControl endRefreshing];
//                                                              [self.computationDataSource deleteAll];
//                                                              [self.tableView reloadData];
//                                                              
//                                                              
//                                                          }];
//        
//        [alert addAction:noAction];
//        [alert addAction:yesAction];
        
        ClearHistoryController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ClearHistory"];
        
        controller.delegate = self;
        controller.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:controller animated:YES completion:nil];
        UIPopoverPresentationController *popController = [controller popoverPresentationController];
        popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
        popController.delegate = self;
        popController.sourceView = self.tableView;
        popController.sourceRect = self.tableView.bounds;
        
    }
}


- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    if(self.refreshControl.refreshing){
        [self.refreshControl endRefreshing];
    }
}

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
    [self.historyDelegate changeResult:com.result];
}

-(void)useExpressionAtIndex:(NSIndexPath*)indexPath
{
    Computation* com = [self.computationDataSource itemAtIndexPath:indexPath];
    [self.historyDelegate changeExpression:com.expression ];
}

#pragma mark - ClearHistoryDelegate
-(void)clearTable
{
    [self.refreshControl endRefreshing];
    [self.computationDataSource deleteAll];
    [self.tableView reloadData];
}
@end
