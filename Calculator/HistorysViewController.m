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
    NSArray *ta = @[@"7\n7",@"1+2+3"];
    self.array =[NSMutableArray  arrayWithArray:ta];
    self.count = 5;
    [self setupTableView];
    [self setRefresh];
}

- (void)setupTableView
{
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //[self.tableView registerNib:[ComputationCell nib] forCellReuseIdentifier:HistoryCellIdentifier];
}

-(void)setRefresh{
    UIRefreshControl *rc = [ [UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开清空记录"];
    [rc addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
}

-(void)clearHistory
{
    if(self.refreshControl.refreshing)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"清空记录"
                                    message:@"是否清空记录？"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action){
                                    [self.refreshControl endRefreshing];
            
        }];
        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action){
                                        [self.refreshControl endRefreshing];
                                        self.count = 0;
                                        [self.tableView reloadData];
                                        
            
        }];
        
        [alert addAction:noAction];
        [alert addAction:yesAction];
        [self presentViewController:alert animated:true completion:nil];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComputationCell *cell = [tableView dequeueReusableCellWithIdentifier:          HistoryCellIdentifier];
//    if(cell == nil)
//    {
//        cell = [[ComputationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HistoryCellIdentifier];
//    }

    cell.date.text = @"7\n17";
    cell.expression.text = @"1+2+3\n6";
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"cellSelectedController"];

    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    // configure the Popover presentation controller
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    UIView *view = [tableView cellForRowAtIndexPath:indexPath];
    popController.sourceView = view;
    popController.sourceRect = view.bounds;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * indexPaths = [NSArray arrayWithObject:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete ) {
        // Delete the row from the data source
        if(indexPath.row>0){
            self.count--;
            [   tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [tableView reloadData];
        }
    }
}

//-(void)popover
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MainStoryBoardName bundle:nil];
//    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:FileTableNavigationID];
//    
//    CGFloat maxH = MIN(480, ([self.drawingDataSource.pathBL allPathFiles].count + 1) * 50);
//    controller.preferredContentSize = CGSizeMake(200, maxH);
//    // present the controller
//    // on iPad, this will be a Popover
//    // on iPhone, this will be an action sheet
//    controller.modalPresentationStyle = UIModalPresentationPopover;
//    [self presentViewController:controller animated:YES completion:nil];
//    
//    // configure the Popover presentation controller
//    UIPopoverPresentationController *popController = [controller popoverPresentationController];
//    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    popController.barButtonItem = sender;
//    
//    popController.delegate = self;
//
//}
@end
