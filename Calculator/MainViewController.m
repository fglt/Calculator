//
//  MainViewController.m
//  MyCalculator
//
//  Created by Coding on 7/13/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "MainViewController.h"
#import "constants.h"
#import "CalculatorBrain.h"
#import "HistoryViewController.h"
#import "ClearHistoryController.h"
#import "CalculatorViewController.h"
#import "CalView.h"

@interface MainViewController ()<CalculatorViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *expressionLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIView *historyBoard;
@property (weak, nonatomic) IBOutlet CalView *calView;

@property CalculatorBrain *brain;
@property ComputationDao* computationDao;
@property HistoryViewController* historyController;

@property (nonatomic, strong) NSString* expression;
@property (nonatomic, strong) NSString* lastExpression;
@property BOOL isFirstInput;
@property BOOL isDotOK;
@property BOOL isINFINITY;
@property BOOL isComputable;
@end

@implementation MainViewController
@synthesize historyController;
@synthesize isFirstInput;
@synthesize isDotOK;
@synthesize isINFINITY;
@synthesize isComputable;
@synthesize brain;
//@synthesize expression;

-(BOOL) prefersStatusBarHidden
{
    return YES;
}
-(void) viewDidLoad
{
    [super viewDidLoad];
    [self addHistoryTableView];
    
}

-(void)addHistoryTableView
{
    
    UIStoryboard *mainStoryBoard = self.storyboard;
    historyController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"historyID"];

   // 用下面这句代替上面是错误的！！！！！导致computationCell创建失败！！！
//    HistorysViewController *history = [[HistorysViewController alloc]init];
    [self addChildViewController:historyController];
    CGRect bounds = self.historyBoard.bounds;
    historyController.historyDelegate =self;
    historyController.view.frame = bounds;
    historyController.view.backgroundColor = [UIColor grayColor];
    historyController.view.layer.cornerRadius = 10;
    self.historyTable = (UITableView*)historyController.view;
    [self.historyBoard addSubview:historyController.view];
    [historyController didMoveToParentViewController:self];
}

-(void)addCalculatorViewController
{
    UIStoryboard *mainStoryBoard = self.storyboard;
    CalculatorViewController* calViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"CalculatorViewController"];

    [self addChildViewController:calViewController];
    CGRect bounds = self.calView.bounds;
    calViewController.calculatorDelegate =self;
    calViewController.view.frame = bounds;
    [self.calView addSubview:calViewController.view];
    [calViewController didMoveToParentViewController:self];
}


//-(void)changeResult:(NSString*)result
//{
//    
//}
//-(void)changeExpression:(NSString*)expression
//{
//    
//}
//
//-(NSString *)currentExpression
//{
//    
//}
//-(NSString *)currentResult
//{
//    
//}
//-(void) sendExpression:(NSString *)expression{
//    
//}
//-(void) sendResult:(NSString *)result{
//    
//}
//-(void) equal{
//    
//}
@end
