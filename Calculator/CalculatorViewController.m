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

@property (nonatomic, strong) NSString* expression;
@property (nonatomic, strong) NSString* lastInput;
@property (nonatomic, strong) NSString* appendStr;

@end

@implementation CalculatorViewController

@synthesize calculatorDelegate;
@synthesize lastInput;

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self configureScrollView];
    [self start];    
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
    lastInput = sender.currentTitle;
    self.appendStr = lastInput;
}

- (IBAction)onClickZero:(UIButton *)sender {
    if(self.expression.length>0)
    {
        lastInput = sender.currentTitle;
        self.appendStr = lastInput;
    }
}

- (IBAction)clickDot:(UIButton *)sender {
    if(_expression.length == 0)
    {
        lastInput = Dot;
        self.appendStr = lastInput;
    }
    
    long i =_expression.length - 1;
    
    UniChar ch = '+';
    while(i >= 0){
        ch = [_expression characterAtIndex:i];
        
        if( (ch != ' ') && (ch != '.'))
            i--;
        else break;
    }
    
    if(i < 0 || ch == ' ')
    {
        lastInput = Dot;
        self.appendStr = lastInput;
    }
}

- (IBAction)clickEqual:(UIButton *)sender {
    if(self.expression.length == 0) return;
    [calculatorDelegate equal];
    _expression = [calculatorDelegate currentResult];
    lastInput = _expression;
}


//点击四则运算以及余数运算
- (IBAction)clickOperator:(UIButton *)sender {
    
    if(self.expression.length == 0)
        return;
    
    if([lastInput isBasicOperator])
    {
        _expression = [_expression substringToIndex:_expression.length-3];
    }
    lastInput = [CalculatorConstants buttonStringWithTag:sender.tag];
    self.appendStr = [lastInput addSpace];

}

- (IBAction)ClickFunction:(UIButton *)sender {
    if([lastInput isLeftBinaryOperator]) return;
    lastInput = [CalculatorConstants buttonStringWithTag:sender.tag];

    self.appendStr = [[lastInput addSpace] stringByAppendingString:@" ( "];
}

- (IBAction)ClickPIOrEXP:(UIButton *)sender {
    lastInput = [CalculatorConstants buttonStringWithTag:sender.tag];
    self.appendStr = [lastInput addSpace];
}

- (IBAction)ClickPowerOrFactorial:(UIButton *)sender {

    if([lastInput isOpNeedRightOperand]) return;

    lastInput = [CalculatorConstants buttonStringWithTag:sender.tag];
    
    self.appendStr = [lastInput addSpace];
}

- (IBAction)ClickSquareRoot:(UIButton *)sender {
    lastInput = [CalculatorConstants buttonStringWithTag:sender.tag];
    self.appendStr = [lastInput addSpace];
}

- (IBAction)ClickLeftBracket:(UIButton *)sender {
    lastInput = [CalculatorConstants buttonStringWithTag:sender.tag];
    self.appendStr = [lastInput addSpace] ;
}

- (IBAction)ClickRightBracket:(UIButton *)sender {
    if(self.expression.length >0){
        lastInput = [CalculatorConstants buttonStringWithTag:sender.tag];
        self.appendStr = [lastInput addSpace];
    }
}

- (IBAction)clearInput:(UIButton *)sender {
    [self start];
}

- (IBAction)onClickButtons:(UIButton *)sender {
    lastInput = [CalculatorConstants buttonStringWithTag:sender.tag];
    self.appendStr = [lastInput addSpace];
}

- (IBAction)deleteLastInput:(UIButton *)sender {
    if(_expression.length>0){
        self.expression = [self.expression substringToIndex:self.expression.length - self.appendStr.length];
        if(self.expression.length == 0)return;
        u_long length = self.expression.length;
        long index = length - 1;
        
        if([_expression characterAtIndex:index] == ' '){
            index--;
            while((index > 0) &&[_expression characterAtIndex:index] != ' '){
                index--;
            }
            _appendStr = [_expression substringWithRange:NSMakeRange(index , length - index)];
            self.lastInput = [self.appendStr substringWithRange:NSMakeRange(1, 1)];
        }else{
            _appendStr = [_expression substringWithRange:NSMakeRange(length - 1, 1)];
            self.lastInput = self.appendStr;
        }
    }
}

////将结果拷贝到粘贴板
//- (IBAction)paste:(UIButton *)sender {
//    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//    pboard.string = self.resultLabel.text;
//}

-(void)start{
    self.expression = @"";
}

-(void)setExpression:(NSString *)newValue
{
    if(_expression != newValue){
        _expression = newValue;
        NSLog(@"_expression: %@", _expression);
        [self.calculatorDelegate sendExpression:_expression];
    }
}


-(void)setAppendStr:(NSString *)appendStr
{
    _appendStr = appendStr;
    self.expression = [self.expression stringByAppendingString:_appendStr];
}
@end
