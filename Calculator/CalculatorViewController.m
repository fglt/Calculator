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


static NSString * const ErrorMessage = @"ERROR";

@interface CalculatorViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIStackView *stack1;
@property (strong, nonatomic) IBOutlet UIStackView *stack2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
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
    self.scrollView.delegate = self;
    //CGRect scrollFrame = CGRectMake(0, 0, 492, 477);
    CGRect scrollFrame = CGRectMake(0, 0, self.view.frame.size.width * 0.5 - 20, self.view.frame.size.height * 0.7 - 60);
    
    self.scrollView.frame = scrollFrame;
    self.scrollView.contentSize = CGSizeMake(scrollFrame.size.width * 2, scrollFrame.size.height);
    
    _stack1.frame = CGRectMake(0 , 0, scrollFrame.size.width, scrollFrame.size.height);
    
    _stack2.frame = CGRectMake( scrollFrame.size.width, 0, scrollFrame.size.width, scrollFrame.size.height);
    //
    NSLog(@"scrollFrame: %@",NSStringFromCGRect(scrollFrame));
    
    [self.scrollView addSubview:self.stack1];
    [self.scrollView addSubview:self.stack2];
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = (offset.x + self.scrollView.frame.size.width/2)/ self.scrollView.frame.size.width ;
}
- (IBAction)changePage:(UIPageControl *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * whichPage, 0);
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
