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


static NSString * const ErrorMessage = @"ERROR";
static NSDictionary *buttonTag;
@interface CalculatorViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIStackView *stack1;
@property (strong, nonatomic) IBOutlet UIStackView *stack2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSString* expression;

@property BOOL isDotOK;

@end

@implementation CalculatorViewController

@synthesize isDotOK;

+(NSString*)buttonStringWithTag:(NSUInteger)tag
{
    if(!buttonTag){
        buttonTag =  @{@"20":@"/",
                       @"21":@"*",
                       @"22":@"-",
                       @"23":@"+",
                       @"24":@"/",
                       @"25":@"*",
                       @"26":@"-",
                       @"27":@"+",
                       @"110":FunLogDecimal,
                       @"111":FunLogE,
                       @"112":FunLogBinary,
                       @"120":FunSin,
                       @"121":FunCos,
                       @"122":FunTan,
                       @"123":FunArcSin,
                       @"124":FunArcCos,
                       @"125":FunArcTan,
                       @"126":FunSinh,
                       @"127":FunCosh,
                       @"128":FunTanh,
                       };
    }
    
    NSString *tagStr = [NSString stringWithFormat:@"%lu",(u_long)tag];
    return  buttonTag[tagStr];
}

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

    self.expression = [self.expression stringByAppendingString:sender.currentTitle] ;
}

- (IBAction)onClickZero:(UIButton *)sender {
    if(self.expression.length>0)
        self.expression = [self.expression stringByAppendingString:sender.currentTitle] ;
}

- (IBAction)clickDot:(UIButton *)sender {
    if(isDotOK){
        _expression =[self.expression stringByAppendingString:Dot];
        isDotOK = false;
    }
}

- (IBAction)clickEqual:(UIButton *)sender {
    if(self.expression.length == 0) return;
    [self.calculatorDelegate equal];
    _expression = [self.calculatorDelegate  currentResult];
}

- (IBAction)clickOperator:(UIButton *)sender {
    
    if(self.expression.length == 0)
        return;
    
    NSString *text = _expression;
    if([FourArithmeticOperation containCharacter:[text characterAtIndex:text.length-1]])
    {
        text = [text substringToIndex:text.length-1]; 
    }

    NSString * appendStr = [CalculatorViewController buttonStringWithTag:sender.tag];
    self.expression = [text stringByAppendingString:appendStr];
    isDotOK = true;
}

- (IBAction)ClickFunction:(UIButton *)sender {
//    self.expression = [ [_expression stringByAppendingString:sender.currentTitle] stringByAppendingString:LeftBracket];
    NSString * appendStr = [CalculatorViewController buttonStringWithTag:sender.tag];
    self.expression = [ [_expression stringByAppendingString:appendStr] stringByAppendingString:LeftBracket];
    
}

- (IBAction)ClickPIOrEXP:(UIButton *)sender {
    self.expression =  [_expression stringByAppendingString:sender.currentTitle];
}

- (IBAction)ClickPowerOrFactorial:(UIButton *)sender {
    
    NSString *  const jc = @"09)";
    NSString * text = self.expression;
    unichar  c = [text characterAtIndex:text.length-1];
    
    if([FourArithmeticOperation containCharacter:c]){
        text = [text substringToIndex:text.length-1];
        self.expression = [text stringByAppendingString:sender.currentTitle];
    }
    if( c == [jc characterAtIndex:2] || ( c>= '0'&& c<='9') ){
        self.expression = [self.expression stringByAppendingString:sender.currentTitle];
    }
}

//改动：当最先输入时候修正
- (IBAction)ClickSquareRoot:(UIButton *)sender {
    self.expression = [self.expression stringByAppendingString:sender.currentTitle] ;
}


- (IBAction)ClickLeftBracket:(UIButton *)sender {

    self.expression = [self.expression stringByAppendingString:LeftBracket];
    
    isDotOK = true;
}

- (IBAction)ClickRightBracket:(UIButton *)sender {
    if(self.expression.length >0)
        self.expression = [self.expression stringByAppendingString:RightBracket];
    isDotOK = true;
}

- (IBAction)clearInput:(UIButton *)sender {
    [self start];
}


- (IBAction)onClickbuttons:(UIButton *)sender {
}

- (IBAction)deleteLastChar:(UIButton *)sender {
    NSString *text = self.expression;
    u_long l = text.length;
    
    if(l == 0) return;
    if(l ==1){
        [self start];
        return ;
    }
    
    unichar c  = [text characterAtIndex:l-1];
    if( c=='.')
        isDotOK = true;
    if(c == '(')
    {
        unichar fc = [text characterAtIndex:l-2];
        if (fc == 'n' && [text characterAtIndex:l-3]=='l')
            l = l-3;
        else if( fc =='g' || fc== 's' || fc == 'n' )
            l=l-4;
        else l=l-1;
    }else l=l-1;
    
    self.expression = [text substringToIndex:l];
}

////将结果拷贝到粘贴板
//- (IBAction)paste:(UIButton *)sender {
//    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//    pboard.string = self.resultLabel.text;
//}

-(void)start{
    isDotOK = true;
    self.expression = @"";
}

-(void)setExpression:(NSString *)newValue
{
    if(_expression != newValue){
        _expression = newValue;
        [self.calculatorDelegate sendExpression:_expression];
    }
}


@end
