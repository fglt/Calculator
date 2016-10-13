 //
//  CalculatorViewController.m
//  Calculator
//
//  Created by Coding on 7/19/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculatorViewController.h"
#import "constants.h"
#import "NSString+Calculator.h"
#import "CalculatorConstants.h"
#import "CalculateView.h"
#import "CalculatorBrain.h"
#import "Computation.h"
#import "ComputationDao.h"


static NSString * const ErrorMessage = @"ERROR";

@interface CalculatorViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet CalculateView *calView;
@end

@interface CalculatorViewController ()
@property (nonatomic, strong) NSMutableArray *operatorsArray;
@property (nonatomic, strong) NSString *expression;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) Computation *computation;
@property CalculatorBrain *brain;
@property ComputationDao *computationDao;
@property BOOL isEqualed;
@end

@implementation CalculatorViewController

//@synthesize calculatorDelegate;
@synthesize operatorsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureScrollView];
    
    [self  start];
    self.brain = [[CalculatorBrain alloc] init];
    self.computationDao = [ComputationDao singleInstance];
}

- (void)start{
    operatorsArray = [NSMutableArray array];
    self.isEqualed = NO;
}

- (void)configureScrollView
{
    self.calView.scrollView.delegate = self;    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.calView.pageControl.currentPage = offset.x / scrollView.frame.size.width ;
}
- (IBAction)changePage:(UIPageControl *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        NSInteger whichPage = self.calView.pageControl.currentPage;
        self.calView.scrollView.contentOffset = CGPointMake(self.calView.scrollView.frame.size.width * whichPage, 0);
    }];
}

- (IBAction)clickDigit:(UIButton *)sender {
    if(self.isEqualed){
        if([[operatorsArray lastObject] isNumberic])
        [operatorsArray removeAllObjects];
        self.isEqualed = NO;
    }
    [self addNumericString:sender.currentTitle];
    [self calculate];
}

- (IBAction)onClickZero:(UIButton *)sender {
    if(self.isEqualed){
        if([[operatorsArray lastObject] isNumberic])
            [operatorsArray removeAllObjects];
        self.isEqualed = NO;
    }
    NSString *lastOp = [operatorsArray lastObject];
    if([lastOp isNumberic] && ([lastOp doubleValue] == 0) && ( ![lastOp containCharacter:'.']))
    {
        return ;
    }
    
    [self addNumericString:sender.currentTitle];
    [self calculate];
}

/**
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickDot:(UIButton *)sender {
    if(self.isEqualed){
        if([[operatorsArray lastObject] isNumberic])
            [operatorsArray removeAllObjects];
        self.isEqualed = NO;
    }

    NSString *op = [operatorsArray lastObject];

    if([op characterAtIndex:0] == '.'){
        return;
    }
    if(isdigit([op characterAtIndex:0]))
    {
        if([op containCharacter:'.']) return;
        NSString * op = [operatorsArray lastObject];

        [operatorsArray removeLastObject];
        [operatorsArray addObject:[op stringByAppendingString:Dot]];
        [self calculate];
        return;
    }
        
    [operatorsArray addObject:Dot];
    [self calculate];
}

- (IBAction)clickEqual:(UIButton *)sender {

    if(operatorsArray.count == 0) return;
    self.isEqualed = YES;
    if([self.result isEqualToString:@"∞"]){
        [operatorsArray removeAllObjects];
        return;
    }
    Computation* computation = [[Computation alloc]initWithExpression:self.expression result:self.result date:[NSDate date]];
    self.expression = self.result;

    [self.computationDao addComputation:computation];
    self.computation = computation;

    [operatorsArray removeAllObjects];
    [operatorsArray addObject:self.result];
    
}


//点击四则运算以及余数运算
- (IBAction)clickOperator:(UIButton *)sender {
    //if(self.isEqualed) self.isEqualed = NO;
    if(operatorsArray.count == 0 ) return;
    NSString * lastop = [operatorsArray lastObject];
    NSString * inputOP = [CalculatorConstants buttonStringWithTag:sender.tag];
    if([lastop isBasicOperator]){
        [operatorsArray removeLastObject];
        [operatorsArray addObject:inputOP];
        [self calculate];
        return;
    }
    if([lastop isOpNeedRightOperand]) return;
    [operatorsArray addObject:inputOP];
    [self calculate];
}

- (IBAction)ClickPIOrEXP:(UIButton *)sender {
    //if(self.isEqualed) self.isEqualed = NO;
    [operatorsArray addObject:[CalculatorConstants buttonStringWithTag:sender.tag]];
    [self calculate];
}

- (IBAction)clearInput:(UIButton *)sender {
    [self  start];
    [self calculate];
}
- (IBAction)onClickRand:(UIButton *)sender {
    if(self.isEqualed){
        [operatorsArray removeAllObjects];
        self.isEqualed = NO;
    }
    int randx = arc4random()%1000;
    
    if(operatorsArray.count ==0 || [[operatorsArray lastObject] isOpNeedRightOperand]  ){
        [operatorsArray addObject:[NSString stringWithFormat:@"%g",randx/(double)1000]];
        [self calculate];
    }
}

- (IBAction)onClickButtons:(UIButton *)sender {
    //if(self.isEqualed) self.isEqualed = NO;
    NSString * send = [CalculatorConstants buttonStringWithTag:sender.tag];
    BOOL isAdd = false;
    NSString * lastInput = [operatorsArray lastObject];
    if(!lastInput || lastInput.length == 0)
    {
        if([send isRightUnaryOperator])
            isAdd = true;
    }else{
        
        if([lastInput isNumber])
        {
            if([send  isOpNeedLeftOperand])
                isAdd = true;
        }else if([lastInput isOpNeedRightOperand]){
            
            if(![send isOpNeedLeftOperand])
                isAdd = true;
        }else if([send isOpNeedLeftOperand])
        {
            isAdd = true;
        }
    }
   
    if(isAdd){
        [operatorsArray addObject:send];
        [self calculate];
    }

}

- (IBAction)deleteLastInput:(UIButton *)sender {

    if(operatorsArray.count>0){
        [operatorsArray removeLastObject];
        [self calculate];
    }
}


- (void)calculate
{
    self.expression = [operatorsArray componentsJoinedByString:@" "];
    _brain.expression = self.expression;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        double calResult = [_brain calculate];
        if(calResult < 1e-8 && calResult > -1e-8){
            calResult = 0;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if( calResult == INFINITY||calResult == -INFINITY)
            {
                self.result =@"∞";;
                
                return ;
            }
            
            self.result = [NSString stringWithFormat:@"%.8g",calResult];
        });
    });
    //[self.calculatorDelegate sendExpression:expression];
}


- (void)addNumericString:(NSString*)input
{
     NSString * op = [operatorsArray lastObject];
    if([op isNumberic]){
        [operatorsArray removeLastObject];
        if([op doubleValue] == 0 && ![op containsString:@"."]){
            [operatorsArray addObject:input];
        }else{
            [operatorsArray addObject:[op stringByAppendingString:input]];
        }
    }else if(![op isLeftUnaryOperator]){
        [operatorsArray addObject:input];
    }
}
//
//- (void)addOperand:(NSString*)operand
//{
//    [operatorsArray removeAllObjects];
//    [operatorsArray addObject:operand];
//}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"computation"]){
        Computation *computation =[change objectForKey:@"new"];
        self.expression = computation.expression;
        self.result = computation.result;
        [operatorsArray removeAllObjects];
         NSArray* tempArray = [self.expression componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@" "]];
        
        [operatorsArray addObjectsFromArray:tempArray] ;
    }
}

//#pragma mark - HistoryViewContorller
//
//- (void)useComputation:(Computation*)computation
//{
//    self.expression = computation.expression;
//    [operatorsArray removeAllObjects];
//    [operatorsArray addObject:computation.result];
//    self.result = computation.result;
//}

@end
