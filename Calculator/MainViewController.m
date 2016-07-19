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

@property ComputationDao* computationDao;
@property HistoryViewController* historyController;

@property (nonatomic, strong) NSString* lastExpression;
@property CalculatorBrain *brain;
@end

@implementation MainViewController
@synthesize historyController;
@synthesize brain;

-(BOOL) prefersStatusBarHidden
{
    return YES;
}
-(void) viewDidLoad
{
    [super viewDidLoad];

    [self addHistoryTableView];
    [self addCalculatorViewController];
    self.computationDao = [ComputationDao singleInstance];
    self.brain = [[CalculatorBrain alloc] init];
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
    
    NSLog(@"calView: %@", NSStringFromCGRect(bounds));
    NSLog(@"calView: %@", NSStringFromCGRect(self.historyBoard.bounds));
}

-(void)useComputation:(Computation *)computation
{
    self.expressionLabel.text = computation.expression;
    self.resultLabel.text = computation.result;
}

-(NSString *)currentExpression
{
    return self.expressionLabel.text;
}
-(NSString *)currentResult
{
    return self.resultLabel.text;
}

-(void) sendExpression:(NSString *)expression{
    self.expressionLabel.text = expression;
    brain.expression = expression;
    double result = [brain calculate];
    if( result == INFINITY||result == -INFINITY)
    {
        self.resultLabel.text =@"😀";;

        return ;
    }
    self.resultLabel.text = [ [NSNumber numberWithDouble:result] stringValue];
}

-(void) sendResult:(NSString *)result{
    self.resultLabel.text = result;
}

-(void) equal{
    BOOL isEqualToLastExpression = false;
    if([self.resultLabel.text isEqualToString:@"∞"]){
        return;
    }

    if([self.lastExpression isEqualToString: self.expressionLabel.text])
        isEqualToLastExpression = true;

    self.lastExpression = self.expressionLabel.text;
    self.expressionLabel.text = self.resultLabel.text;

    if(isEqualToLastExpression) return;

    Computation* computation = [[Computation alloc]init];
    computation.date = [[NSDate alloc] init];
    computation.expression = self.lastExpression;
    computation.result = self.resultLabel.text;

    [self.computationDao add:computation];
    [historyController update];
}
@end
