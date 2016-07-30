//
//  HistoryViewController.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "HistoryViewController.h"
#import "ArrayComputationDataSource.h"
#import "ComputationDao.h"
#import "ComputaionCell+ConfigureForComputation.h"
#import "CellSelectedControllerViewController.h"
#import "ClearHistoryController.h"
#import "ExpressionParser.h"


static NSString * const HistoryCellIdentifier = @"HistoryCell";
static CGFloat  expressionFontSize = 17;

@interface HistoryViewController  () <CellSelectedControllerDelegate,ClearHistoryControllerDelegate>
@property (nonatomic, strong) ComputationCell* estCell;
@end

@implementation HistoryViewController
@synthesize computationDao;
@synthesize estCell;
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
        [cell configureForComputation:computation font:[UIFont systemFontOfSize:expressionFontSize]];
    };
    self.computationDataSource = [[ArrayComputationDataSource alloc]initWithCellIdentifier:HistoryCellIdentifier configureCellBlock:configureCell];
    self.tableView.dataSource = self.computationDataSource;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight= 60;
    self.estCell  = (ComputationCell*)[self.tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier];
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
        UIDevice* device = [UIDevice currentDevice];
        UIUserInterfaceIdiom idiom = [device userInterfaceIdiom];
        BOOL ipad = (idiom == UIUserInterfaceIdiomPad);
        if(ipad){
            ClearHistoryController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ClearHistoryController"];
            
            controller.delegate = self;
            controller.modalPresentationStyle = UIModalPresentationPopover;
            [self presentViewController:controller animated:YES completion:nil];
            UIPopoverPresentationController *popController = [controller popoverPresentationController];
            popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
            popController.sourceView = self.tableView;
            popController.sourceRect = CGRectMake(self.tableView.bounds.size.width/4 ,self.tableView.bounds.size.height/4,self.tableView.bounds.size.width/2, self.tableView.bounds.size.height/2);
        }else{
            UIAlertController* actionSheet = [[UIAlertController alloc] init];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                handler:^(UIAlertAction *action){
                                                                     
                }];
            UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive
                handler:^(UIAlertAction *action){
                    [self  clearTable];
                } ];
            [actionSheet addAction:cancelAction];
            [actionSheet addAction:deleteAction];
            [self presentViewController:actionSheet animated:TRUE completion:nil];
        }
        
        [self.refreshControl endRefreshing];
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        CellSelectedControllerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"cellSelectedController"];
        
        controller.delegate = self;
        controller.indexPath = indexPath;
        controller.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:controller animated:YES completion:nil];
        
        // configure the Popover presentation controller
        UIPopoverPresentationController *popController = [controller popoverPresentationController];
        //popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
        UIView *view = [self.tableView cellForRowAtIndexPath:indexPath];
        popController.sourceView = view;
        popController.sourceRect = view.bounds;
    }else{
        UIAlertController* actionSheet = [[UIAlertController alloc] init];
        UIAlertAction* cancelAction =
        [UIAlertAction actionWithTitle:@"取消"
                                 style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action){
                                    }];
        UIAlertAction* deleteAction =
        [UIAlertAction actionWithTitle:@"删除"
                                 style:UIAlertActionStyleDestructive
                               handler:^(UIAlertAction *action){
                                    [self deleteCellAtIndex:indexPath];
                                    } ];
         UIAlertAction* useExpressionAction =
        [UIAlertAction actionWithTitle:@"使用表达式"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action){
                                   [self useExpressionAtIndex:indexPath];
                               } ];
        UIAlertAction* useResultAction =
        [UIAlertAction actionWithTitle:@"使用结果"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action){
                                   [self useResultAtIndex:indexPath];
                               } ];
        [actionSheet addAction:cancelAction];
        [actionSheet addAction:deleteAction];
        [actionSheet addAction:useExpressionAction];
        [actionSheet addAction:useResultAction];
        [self presentViewController:actionSheet animated:TRUE completion:nil];

    }
    
}

-(void)update
{
    [self.computationDataSource update];
    [self.tableView reloadData];
}

-(CGFloat)cellWidth{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    Computation* computation = [self.computationDataSource itemAtIndexPath:indexPath];
//    [estCell configureForComputation:computation font:[UIFont systemFontOfSize:expressionFontSize]];
//     estCell.expression.preferredMaxLayoutWidth = tableView.frame.size.width * 0.8 - 25;
////    CGSize size = [estCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
////    CGFloat height = size.height+1;
//    CGFloat height = estCell.expression.frame.size.height + estCell.result.frame.size.height + 1;
//    NSLog(@"%f",self.tableView.frame.size.width);
  //  ComputationCell * cell = [self.tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier];
//    [cell configureForComputation:computation height:28];
    //CGFloat height = estCell.expression.frame.size.height + estCell.result.frame.size.height+2;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    });
//    
//    NSMutableAttributedString* attrString = [ExpressionParser parseString:computation.expression font:[UIFont systemFontOfSize:20] operatorColor:[UIColor greenColor]];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setAlignment:NSTextAlignmentRight];
//    [paragraphStyle setLineSpacing:0];//调整行间距
//    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
//    
//    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrString.length)];
//    CGRect textFrame;
//    
//    textFrame = [attrString boundingRectWithSize:CGSizeMake((self.tableView.frame.size.width-2)* 0.875 -15, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading context:nil];
//    
//   CGFloat height = textFrame.size.height + 21 + 1;
    return 60;

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
