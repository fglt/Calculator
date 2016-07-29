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

static NSString * const ErrorMessage = @"ERROR";

@interface CalculatorViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet CalculateView *calView;
@end

@interface CalculatorViewController ()
@property (nonatomic, strong) NSMutableArray* operatorsArray;
@end

@implementation CalculatorViewController

@synthesize calculatorDelegate;
@synthesize operatorsArray;

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self configureScrollView];
    [self  start];
}

-(void) start{
    operatorsArray = [NSMutableArray array];
}

-(void)configureScrollView
{

    self.calView.scrollView.delegate = self;    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
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
    [self changeLastObejctWithAppend:sender.currentTitle];
    [self calculate];
}

- (IBAction)onClickZero:(UIButton *)sender {
    
    NSString *lastOp = [operatorsArray lastObject];
    if([lastOp isNumberic])
    {
        if([lastOp doubleValue] == 0)
        {
            if( ![lastOp containCharacter:'.'])
                return ;
        }
    }
    
    [self changeLastObejctWithAppend:sender.currentTitle];
    [self calculate];
}

/**
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickDot:(UIButton *)sender {

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
    [calculatorDelegate equal];
    [operatorsArray removeAllObjects];
    [operatorsArray addObject:[calculatorDelegate currentResult]];
}


//点击四则运算以及余数运算
- (IBAction)clickOperator:(UIButton *)sender {
    
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

    [operatorsArray addObject:[CalculatorConstants buttonStringWithTag:sender.tag]];
    [self calculate];
}

- (IBAction)clearInput:(UIButton *)sender {
    [self  start];
    [self calculate];
}

- (IBAction)onClickButtons:(UIButton *)sender {
    
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


-(void) calculate
{
    NSString * expression = [operatorsArray componentsJoinedByString:@" "];
    [self.calculatorDelegate sendExpression:expression];
}


-(void)changeLastObejctWithAppend:(NSString*)input
{
     NSString * op = [operatorsArray lastObject];
    if([op isNumberic]){
        [operatorsArray removeLastObject];
        [operatorsArray addObject:[op stringByAppendingString:input]];
    }else{
        [operatorsArray addObject:input];
    }
}

-(void)addOperand:(NSString*)operand
{
    [operatorsArray removeAllObjects];
    [operatorsArray addObject:operand];
}
@end
