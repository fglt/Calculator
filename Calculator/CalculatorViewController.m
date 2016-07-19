//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Coding on 7/19/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "ComputationDao.h"
#import "constants.h"


static NSString * const ErrorMessage = @"ERROR";
@interface CalculatorViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIStackView *stack1;
@property (strong, nonatomic) IBOutlet UIStackView *stack2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property CalculatorBrain *brain;
@property ComputationDao* computationDao;

@property BOOL isFirstInput;
@property BOOL isDotOK;
@property BOOL isINFINITY;
@end

@implementation CalculatorViewController
@synthesize isFirstInput;
@synthesize isDotOK;
@synthesize isINFINITY;
@synthesize brain;

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    CGRect scrollFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-20);
    
    //如果没有此句，scrollview 疑问？
    self.scrollView.frame = scrollFrame;
    self.scrollView.contentSize = CGSizeMake(scrollFrame.size.width * 2, scrollFrame.size.height);
    
    _stack1.frame = CGRectMake(0 , 0, scrollFrame.size.width, scrollFrame.size.height);
    
    _stack2.frame = CGRectMake( scrollFrame.size.width, 0, scrollFrame.size.width, scrollFrame.size.height);
    //
    NSLog(@"%f, %f, %f , %f ",scrollFrame.origin.x, scrollFrame.origin.y, scrollFrame.size.width, scrollFrame.size.height);
    
    [self.scrollView addSubview:self.stack1];
    [self.scrollView addSubview:self.stack2];
    
    [self start];    
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
    NSString *text;
    
    if (isFirstInput){
        if(isINFINITY){
            text =DefalultOfInput ;
            isINFINITY = false;
        }
        isFirstInput = false;
        text = sender.currentTitle ;
        
    }else{
        NSString * tmp = [self.calculatorDelegate currentResult];
        text = [tmp stringByAppendingString:sender.currentTitle] ;
        
    }
    
    [self.calculatorDelegate sendResult:text];
}
- (IBAction)clickDot:(UIButton *)sender {
    NSString * text;
    if(isINFINITY){
        text =DefalultOfInput ;
        isINFINITY = false;
    }
    if(isDotOK){
        text =[[self.calculatorDelegate currentResult] stringByAppendingString:Dot];
        isDotOK = false;
        isFirstInput = false;
    }
    
    [self.calculatorDelegate sendResult:text];
}

- (IBAction)clickEqual:(UIButton *)sender {
    //calculator
    //save
    NSString * current = [self.calculatorDelegate currentResult];
    
    if(isFirstInput) return;
    current = [current stringByAppendingString:@"="];
    if(current.length ==1 ) return;
    brain = [[ CalculatorBrain alloc] initWithInput:current];
    double result = [brain calculate];
    
    if( result == INFINITY||result == -INFINITY)
    {
        [self.calculatorDelegate sendResult: ErrorMessage];
        isINFINITY =true;
        isFirstInput = true;
    }else{
        current = [ [NSNumber numberWithDouble:result] stringValue];
        isFirstInput = false;
        Computation* computation = [[Computation alloc]init];
        computation.date = [[NSDate alloc] init];
        computation.expression = [self.calculatorDelegate currentExpression];
        computation.result = current;
        [self.calculatorDelegate sendResult:current];
        [self.computationDao add:computation];
        [self.calculatorDelegate updateHistory];
        //[historyController update];
    }
    
    //NSLog(operands);
}

- (IBAction)clickOperator:(UIButton *)sender {
    
    if(isFirstInput){
        if( [sender.currentTitle isEqualToString:Add]||[sender.currentTitle isEqualToString:Minius]){
            //self.input.text = sender.currentTitle;
            [self.calculatorDelegate sendResult:sender.currentTitle];
            isFirstInput = false;
        }
        return;
    }
    
   // NSString *text = self.input.text;
    NSString *text =[self.calculatorDelegate currentResult];
    
    NSString * sub = [text substringFromIndex:text.length-1];
    if([Operatorstr containsString:sub])
    {
        text = [text substringToIndex:text.length-1];
        
    }
    
   // self.input.text = [text stringByAppendingString:sender.currentTitle];
    [self.calculatorDelegate sendResult:[text stringByAppendingString:sender.currentTitle]];
    isDotOK = true;
    
}

- (IBAction)ClickFunction:(UIButton *)sender {
    
    NSString *text = [sender.currentTitle stringByAppendingString:LeftBracket];
    if(isFirstInput){
        //self.input.text = [sender.currentTitle stringByAppendingString:LeftBracket];
        isFirstInput = NO;
        
    }else{
//        self.input.text = [ [self.input.text stringByAppendingString:sender.currentTitle] stringByAppendingString:LeftBracket];
        text = [[self.calculatorDelegate currentResult] stringByAppendingString:text];
    }
    [self.calculatorDelegate sendResult:text];
}

- (IBAction)ClickPIOrEXP:(UIButton *)sender {
    NSString *text;
    if(isFirstInput){
        text = sender.currentTitle ;
    }else
        text =  [[self.calculatorDelegate currentResult] stringByAppendingString:sender.currentTitle] ;
    isFirstInput =false;
    [self.calculatorDelegate sendResult:text];
}

- (IBAction)ClickPowerOrFactorial:(UIButton *)sender {
    NSString *  const jc = @"09)";
    NSString * text = [self.calculatorDelegate currentResult];
    unichar  c = [text characterAtIndex:text.length-1];
    
    if( c == [jc characterAtIndex:2] || ( c>= '0'&& c<='9') ){
        text = [text stringByAppendingString:sender.currentTitle];
        //self.input.text = [self.input.text stringByAppendingString:sender.currentTitle];
        [self.calculatorDelegate sendResult:text];
    }
}

//改动：当最先输入时候修正
- (IBAction)ClickSquare:(UIButton *)sender {
    NSString * text;
    if(isFirstInput){
        text = sender.currentTitle;
        isFirstInput = false;
    }else
        text =  [[self.calculatorDelegate currentResult] stringByAppendingString:sender.currentTitle] ;
    
    [self.calculatorDelegate sendResult:text];
}


- (IBAction)ClickLeftBracket:(UIButton *)sender {
    NSString * text;
    if(isFirstInput){
        text = LeftBracket;
        isFirstInput = false;
    }else
        text = [[self.calculatorDelegate currentResult] stringByAppendingString:LeftBracket];
    [self.calculatorDelegate sendResult:text];
    isDotOK = true;
    
}
- (IBAction)ClickRightBracket:(UIButton *)sender {
    NSString *text;
    if(!isFirstInput){
        text = [[self.calculatorDelegate currentResult] stringByAppendingString:RightBracket];
        [self.calculatorDelegate sendResult:text];
    }
    isDotOK = true;
}

- (IBAction)clearInput:(UIButton *)sender {
    NSString *text;
    [self start];
    text = DefalultOfInput;
    [self.calculatorDelegate sendResult:text];
    [self.calculatorDelegate sendExpression:@""];
}


- (IBAction)deleteLastChar:(UIButton *)sender {
    NSString *text = [self.calculatorDelegate currentResult];
    u_long l = text.length;
    
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
    
    text = [text substringToIndex:l];
    
    [self.calculatorDelegate sendResult:text];
}


-(void)start{
    isFirstInput = true;
    isDotOK = true;
    isINFINITY = false;
}

-(void)changeResult:(NSString*)result
{
    [self.calculatorDelegate sendResult: result];
    isFirstInput = false;
}

-(void)changeExpression:(NSString*)expression
{
    //self.lastExpression.text = expression;
    [self.calculatorDelegate sendExpression:expression];
}


-(void)setText:(NSString *)text
{
    self.text = text;
}

@end
