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
    
    if(self.expression.length==0)
        return;
    
    NSString *text = _expression;
    
   // NSString * sub = [text substringFromIndex:text.length-1];

//    if([FourArithmeticOperation containsString:sub])
//    {
//        text = [text substringToIndex:text.length-1];
//    }
    
    if([FourArithmeticOperation containCharacter:[text characterAtIndex:text.length-1]])
    {
        text = [text substringToIndex:text.length-1];
    }
//    _expression = text;
//    [self addOperationToExpression:sender.currentTitle];
    self.expression = [text stringByAppendingString:sender.currentTitle];
    isDotOK = true;
}

- (IBAction)ClickFunction:(UIButton *)sender {
    self.expression = [ [_expression stringByAppendingString:sender.currentTitle] stringByAppendingString:LeftBracket];
    
//    NSString *tmp = [sender.currentTitle stringByAppendingString:LeftBracket];
//    [self addOperationToExpression:tmp];
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

//符号位button处理
- (IBAction)onClickSignBit:(UIButton *)sender {

}

- (IBAction)onClickScientificNotation:(UIButton *)sender {
    
}


- (IBAction)onClickSquare:(UIButton *)sender {
    
}

- (IBAction)onClickCube:(UIButton *)sender {
    
}

//倒数
- (IBAction)reciprocal:(id)sender {
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

-(void) addOperationToExpression:(NSString*)operation
{
   
    self.expression = [self.expression stringByAppendingString:operation];
    
//    static NSString* space = @" ";
//    NSString * tmp =  [space stringByAppendingString:operation];
//    tmp = [tmp stringByAppendingString:space];
//    self.expression =  [self.expression stringByAppendingString:tmp];
}

@end
