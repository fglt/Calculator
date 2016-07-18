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
#import "HistorysViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lastExpression;
@property (weak, nonatomic) IBOutlet UILabel *input;
@property (weak, nonatomic) IBOutlet UIView *historyBoard;
@property CalculatorBrain *brain;

@property BOOL isFirstInput;
@property BOOL isDotOK;
@property BOOL isINFINITY;
@end

@implementation MainViewController

@synthesize isFirstInput;
@synthesize isDotOK;
@synthesize isINFINITY;
@synthesize brain;

-(BOOL) prefersStatusBarHidden
{
    return YES;
}
-(void) viewDidLoad
{
    [super viewDidLoad];

    self.scrollView.delegate = self;
    CGFloat scrollWidth = self.view.frame.size.width * 0.5 - 20;
    CGFloat scrollHeight = self.view.frame.size.height * 0.7 - 60;
    CGFloat scrollx = self.view.frame.size.width * 0.5 ;
    CGFloat scrolly = self.view.frame.size.height * 0.3 + 20 ;
    
    
    //如果没有此句，scrollview 疑问？
    self.scrollView.frame = CGRectMake(scrollx, scrolly, scrollWidth, scrollHeight);
    CGRect  scrollFrame = self.scrollView.frame;
    self.scrollView.contentSize = CGSizeMake(scrollFrame.size.width * 2, scrollFrame.size.height);

//    UIStoryboard *mainStoryBoard = self.storyboard;
//    UIViewController *page1Contro = [mainStoryBoard instantiateViewControllerWithIdentifier:@"page1"];
//    self.page1 =  page1Contro.view;
   // self.page1 = self.stack1;
    
    //    UIViewController *page2Contro = [mainStoryBoard instantiateViewControllerWithIdentifier:@"page2"];
    //    self.page2 =  page2Contro.view;
    // self.page2 = self.stack2;
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
    HistorysViewController *history = [mainStoryBoard instantiateViewControllerWithIdentifier:@"historyID"];

   // 用下面这句代替上面是错误的！！！！！导致computationCell创建失败！！！
//    HistorysViewController *history = [[HistorysViewController alloc]init];
    [self addChildViewController:history];
    CGRect bounds = self.historyBoard.bounds;
  
    history.view.frame = bounds;
    history.view.backgroundColor = [UIColor grayColor];
    history.view.layer.cornerRadius = 10;
    [self.historyBoard addSubview:history.view];
    [history didMoveToParentViewController:self];
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
            self.input.text =DefalultOfInput ;
            isINFINITY = false;
        }
        isFirstInput = false;
        self.input.text = sender.currentTitle ;
        
    }else{
        self.input.text = [self.input.text stringByAppendingString:sender.currentTitle] ;
        
    }
}
- (IBAction)clickDot:(UIButton *)sender {
    if(isINFINITY){
        self.input.text =DefalultOfInput ;
        isINFINITY = false;
    }
    if(isDotOK){
        self.input.text =[self.input.text stringByAppendingString:Dot];
        isDotOK = false;
        isFirstInput = false;
    }
}

- (IBAction)clickEqual:(UIButton *)sender {
    //calculator
    //save
    
    if(isFirstInput) return;
    self.lastExpression.text = [self.input.text stringByAppendingString:@"="];
    if(self.input.text.length ==1 ) return;
    brain = [[ CalculatorBrain alloc] initWithInput:self.input.text];
    double result = [brain calculate];
    
    if( result == INFINITY||result == -INFINITY)
    {
        self.input.text = @"ERROR";
        isINFINITY =true;
        isFirstInput = true;
    }else{
        self.input.text = [ [NSNumber numberWithDouble:result] stringValue];
        isFirstInput = false;
    }
    
    //NSLog(operands);
}

- (IBAction)clickOperator:(UIButton *)sender {
    
    if(isFirstInput){
        if( [sender.currentTitle isEqualToString:Add]||[sender.currentTitle isEqualToString:Minius]){
            self.input.text = sender.currentTitle;
            isFirstInput = false;
        }
        return;
    }
    
    NSString *text = self.input.text;
    
    NSString * sub = [text substringFromIndex:text.length-1];
    if([Operatorstr containsString:sub])
    {
        text = [text substringToIndex:text.length-1];
        
    }
    
    self.input.text = [text stringByAppendingString:sender.currentTitle];
    isDotOK = true;
    
}

- (IBAction)ClickFunction:(UIButton *)sender {
    
    if(isFirstInput){
        self.input.text = [sender.currentTitle stringByAppendingString:LeftBracket];
        isFirstInput = NO;
        
    }else
        self.input.text = [ [self.input.text stringByAppendingString:sender.currentTitle] stringByAppendingString:LeftBracket];
}

- (IBAction)ClickPIOrEXP:(UIButton *)sender {
    if(isFirstInput){
        self.input.text = sender.currentTitle ;
    }else
        self.input.text =  [self.input.text stringByAppendingString:sender.currentTitle] ;
    isFirstInput =false;
}

- (IBAction)ClickPowerOrFactorial:(UIButton *)sender {
    NSString *  const jc = @"09)";
    NSString * text = self.input.text;
    unichar  c = [text characterAtIndex:text.length-1];
    
    if( c == [jc characterAtIndex:2] || ( c>= '0'&& c<='9') ){
        self.input.text = [self.input.text stringByAppendingString:sender.currentTitle];
    }
}

//改动：当最先输入时候修正
- (IBAction)ClickSquare:(UIButton *)sender {
    if(isFirstInput){
        self.input.text = sender.currentTitle;
        isFirstInput = false;
    }else
        self.input.text =  [self.input.text stringByAppendingString:sender.currentTitle] ;
}


- (IBAction)ClickLeftBracket:(UIButton *)sender {
    if(isFirstInput){
        self.input.text = LeftBracket;
        isFirstInput = false;
    }else
        self.input.text = [self.input.text stringByAppendingString:LeftBracket];
    
    isDotOK = true;
    
}
- (IBAction)ClickRightBracket:(UIButton *)sender {
    if(!isFirstInput)
        self.input.text = [self.input.text stringByAppendingString:RightBracket];
    isDotOK = true;
}

- (IBAction)clearInput:(UIButton *)sender {
    [self start];
    self.input.text = DefalultOfInput;
    self.lastExpression.text = @"";
}


- (IBAction)deleteLastChar:(UIButton *)sender {
    NSString *text = self.input.text;
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
    
    self.input.text = [text substringToIndex:l];
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
    pboard.string = self.input.text;
}

-(void)start{
    isFirstInput = true;
    isDotOK = true;
    isINFINITY = false;
}




@end
