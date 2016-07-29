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
#import "NSString+Calculator.h"
#import "ExpressionParser.h"
#import "ComputationDao.h"

@interface MainViewController ()<CalculatorViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *expressionLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIView *historyBoard;
@property (weak, nonatomic) IBOutlet CalView *calView;

@property ComputationDao* computationDao;
@property HistoryViewController* historyController;
@property CalculatorViewController* calculatorController;

@property (nonatomic, strong) NSString* lastExpression;
@property (nonatomic, strong) NSString* curExpression;
@property (nonatomic, strong) NSString* result;
@property CalculatorBrain *brain;
@end

@implementation MainViewController
@synthesize historyController;
@synthesize calculatorController;
@synthesize brain;

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){}
    [self addHistoryTableView];
    
    [self addCalculatorViewController];
    self.computationDao = [ComputationDao singleInstance];
    self.brain = [[CalculatorBrain alloc] init];
}


-(void)addHistoryTableView
{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Other" bundle:nil];
    historyController = [storyBoard instantiateViewControllerWithIdentifier:@"historyID"];

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
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Other" bundle:nil];
    calculatorController = [storyBoard instantiateViewControllerWithIdentifier:@"CalculatorViewController"];

    [self addChildViewController:calculatorController];
    CGRect bounds = self.calView.bounds;
    calculatorController.calculatorDelegate =self;
    calculatorController.view.frame = bounds;

    [self.calView addSubview:calculatorController.view];
    [calculatorController didMoveToParentViewController:self];
}

-(void)useComputation:(Computation *)computation
{
   // self.result = computation.result;
    self.curExpression = computation.expression;
    [calculatorController addOperand:computation.result];
   // [self displayExpression];
   // self.resultLabel.text = computation.result;
}

-(NSString *)currentExpression
{
    return self.curExpression;
}
-(NSString *)currentResult
{
    return self.result;
}

-(void)clearComputation
{
    self.curExpression = @"0";
}

-(void) sendExpression:(NSString *)expression{
    if(!expression) return;
    if(expression.length==0)
    {
        [self clearComputation];
        return;
    }
    
    self.curExpression = expression;
}

-(void) sendResult:(NSString *)result{
    self.result = result;
}

-(void) equal{
    BOOL isEqualToLastExpression = false;
    if([self.result isEqualToString:@"∞"]){
        return;
    }

    if([self.lastExpression isEqualToString: self.curExpression])
        isEqualToLastExpression = true;

    self.lastExpression = self.curExpression;
    self.expressionLabel.text = self.resultLabel.text;

    if(isEqualToLastExpression) return;

    Computation* computation = [[Computation alloc]init];
    computation.date = [[NSDate alloc] init];
    computation.expression = self.lastExpression;
    computation.result = self.result;

    [self.computationDao add:computation];
    [historyController update];
}

-(void)setCurExpression:(NSString *)expression
{
    _curExpression = expression;
    
    [self displayExpression];

    brain.expression = expression;
    double calResult = [brain calculate];
    
    if( calResult == INFINITY||calResult == -INFINITY)
    {
        self.result =@"INFINITY";;
        
        return ;
    }
    if(calResult < 1e-8 && calResult > -1e-8){
        calResult = 0;
    } 
    self.result = [NSString stringWithFormat:@"%.8g",calResult];
}

-(void)setResult:(NSString *)newValue
{
    _result = newValue;
    self.resultLabel.text = newValue;
}


-(void)displayExpression
{

    
    self.expressionLabel.attributedText = [ExpressionParser parseString:self.curExpression fontSize:self.expressionLabel.font.pointSize operatorColor:[UIColor blueColor]];
}


@end
