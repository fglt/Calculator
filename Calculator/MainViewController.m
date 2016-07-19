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

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *expressionLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIView *historyBoard;
@property CalculatorBrain *brain;
@property ComputationDao* computationDao;
@property HistoryViewController* historyController;

@property (nonatomic, strong) NSString* expression;
@property BOOL isFirstInput;
@property BOOL isDotOK;
@property BOOL isINFINITY;
@end

@implementation MainViewController
@synthesize historyController;
@synthesize isFirstInput;
@synthesize isDotOK;
@synthesize isINFINITY;
@synthesize brain;
@synthesize expression;

-(BOOL) prefersStatusBarHidden
{
    return YES;
}
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.computationDao = [ComputationDao singleInstance];
    self.scrollView.delegate = self;
    CGFloat scrollWidth = self.view.frame.size.width * 0.5 - 20;
    CGFloat scrollHeight = self.view.frame.size.height * 0.7 - 60;
    CGFloat scrollx = self.view.frame.size.width * 0.5 ;
    CGFloat scrolly = self.view.frame.size.height * 0.3 + 20 ;
    
    
    //如果没有此句，scrollview 疑问？
    self.scrollView.frame = CGRectMake(scrollx, scrolly, scrollWidth, scrollHeight);
    CGRect  scrollFrame = self.scrollView.frame;
    self.scrollView.contentSize = CGSizeMake(scrollFrame.size.width * 2, scrollFrame.size.height);

    _stack1.frame = CGRectMake(0 , 0, scrollFrame.size.width, scrollFrame.size.height);

    _stack2.frame = CGRectMake( scrollFrame.size.width, 0, scrollFrame.size.width, scrollFrame.size.height);
    //
        NSLog(@"%f, %f, %f , %f ",scrollFrame.origin.x, scrollFrame.origin.y, scrollFrame.size.width, scrollFrame.size.height);
    
    [self.scrollView addSubview:self.stack1];
    [self.scrollView addSubview:self.stack2];

    [self start];
    [self addHistoryTableView];
    
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


-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = (offset.x + self.scrollView.frame.size.width/2)/ self.scrollView.frame.size.width ;
    //NSLog(@"offset: %f", offset.x);
    //NSLog(@"offset: %ld",  (long)self.pageControl.currentPage);
}
- (IBAction)changePage:(UIPageControl *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * whichPage, 0);
    }];
}

- (IBAction)clickDigit:(UIButton *)sender {
    
    if (isFirstInput){
        if(isINFINITY){
            self.resultLabel.text =DefalultOfInput ;
            isINFINITY = false;
        }
        isFirstInput = false;
        self.resultLabel.text = sender.currentTitle ;
        
    }else{
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:sender.currentTitle] ;
        
    }
}
- (IBAction)clickDot:(UIButton *)sender {
    if(isINFINITY){
        self.resultLabel.text =DefalultOfInput ;
        isINFINITY = false;
    }
    if(isDotOK){
        self.resultLabel.text =[self.resultLabel.text stringByAppendingString:Dot];
        isDotOK = false;
        isFirstInput = false;
    }
}

- (IBAction)clickEqual:(UIButton *)sender {
    //calculator
    //save
    
    if(isFirstInput) return;
    self.expressionLabel.text = [self.resultLabel.text stringByAppendingString:@"="];
    if(self.resultLabel.text.length ==1 ) return;
    brain = [[ CalculatorBrain alloc] initWithInput:self.resultLabel.text];
    double result = [brain calculate];
    
    if( result == INFINITY||result == -INFINITY)
    {
        self.resultLabel.text = @"ERROR";
        isINFINITY =true;
        isFirstInput = true;
    }else{
        self.resultLabel.text = [ [NSNumber numberWithDouble:result] stringValue];
        isFirstInput = false;
        Computation* computation = [[Computation alloc]init];
        computation.date = [[NSDate alloc] init];
        computation.expression = self.expressionLabel.text;
        computation.result = self.resultLabel.text;
        [self.computationDao add:computation];
        [historyController update];
    }
    
    //NSLog(operands);
}

- (IBAction)clickOperator:(UIButton *)sender {
    
    if(isFirstInput){
        if( [sender.currentTitle isEqualToString:Add]||[sender.currentTitle isEqualToString:Minius]){
            self.resultLabel.text = sender.currentTitle;
            isFirstInput = false;
        }
        return;
    }
    
    NSString *text = self.resultLabel.text;
    
    NSString * sub = [text substringFromIndex:text.length-1];
    if([Operatorstr containsString:sub])
    {
        text = [text substringToIndex:text.length-1];
        
    }
    
    self.resultLabel.text = [text stringByAppendingString:sender.currentTitle];
    isDotOK = true;
    
}

- (IBAction)ClickFunction:(UIButton *)sender {
    
    if(isFirstInput){
        self.resultLabel.text = [sender.currentTitle stringByAppendingString:LeftBracket];
        isFirstInput = NO;
        
    }else
        self.resultLabel.text = [ [self.resultLabel.text stringByAppendingString:sender.currentTitle] stringByAppendingString:LeftBracket];
}

- (IBAction)ClickPIOrEXP:(UIButton *)sender {
    if(isFirstInput){
        self.resultLabel.text = sender.currentTitle ;
    }else
        self.resultLabel.text =  [self.resultLabel.text stringByAppendingString:sender.currentTitle] ;
    isFirstInput =false;
}

- (IBAction)ClickPowerOrFactorial:(UIButton *)sender {
    NSString *  const jc = @"09)";
    NSString * text = self.resultLabel.text;
    unichar  c = [text characterAtIndex:text.length-1];
    
    if( c == [jc characterAtIndex:2] || ( c>= '0'&& c<='9') ){
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:sender.currentTitle];
    }
}

//改动：当最先输入时候修正
- (IBAction)ClickSquare:(UIButton *)sender {
    if(isFirstInput){
        self.resultLabel.text = sender.currentTitle;
        isFirstInput = false;
    }else
        self.resultLabel.text =  [self.resultLabel.text stringByAppendingString:sender.currentTitle] ;
}


- (IBAction)ClickLeftBracket:(UIButton *)sender {
    if(isFirstInput){
        self.resultLabel.text = LeftBracket;
        isFirstInput = false;
    }else
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:LeftBracket];
    
    isDotOK = true;
    
}
- (IBAction)ClickRightBracket:(UIButton *)sender {
    if(!isFirstInput)
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:RightBracket];
    isDotOK = true;
}

- (IBAction)clearInput:(UIButton *)sender {
    [self start];
    self.resultLabel.text = DefalultOfInput;
    self.expressionLabel.text = @"";
}


- (IBAction)deleteLastChar:(UIButton *)sender {
    NSString *text = self.resultLabel.text;
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
    
    self.resultLabel.text = [text substringToIndex:l];
}
//将阿拉伯数字转换成汉字
- (IBAction)changeToChinese:(UIButton *)sender {
}

//打开历史记录
- (IBAction)openRecord:(UIButton *)sender {
}

//将结果拷贝到粘贴板
- (IBAction)paste:(UIButton *)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.resultLabel.text;
}

-(void)start{
    isFirstInput = true;
    isDotOK = true;
    isINFINITY = false;
}

-(void)changeResult:(NSString*)result
{
    self.resultLabel.text = result;
    isFirstInput = false;
}

-(void)changeExpression:(NSString*)exp
{
    self.expressionLabel.text = exp;
}

-(void)setExpression:(NSString *)newValue
{
    expression = newValue;
    self.expressionLabel.text = expression;
}
@end
