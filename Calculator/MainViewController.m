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

@interface MainViewController ()<CalculatorViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *expressionLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIView *historyBoard;
@property (weak, nonatomic) IBOutlet CalView *calView;

@property ComputationDao* computationDao;
@property HistoryViewController* historyController;

@property (nonatomic, strong) NSString* lastExpression;
@property (nonatomic, strong) NSString* curExpression;
@property (nonatomic, strong) NSString* result;
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
   // self.result = computation.result;
    self.curExpression = computation.expression;
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

    self.expressionLabel.attributedText = [ExpressionParser parse2String:self.curExpression fontSize:self.expressionLabel.font.pointSize operatorColor:[UIColor blueColor]];
}


@end
