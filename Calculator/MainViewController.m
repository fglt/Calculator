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
        self.result =@"🆕";;
        
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
    
    NSMutableAttributedString *displyText = [[NSMutableAttributedString alloc] initWithString:@" " attributes:nil];
    NSAttributedString *attriSpace = [[NSAttributedString alloc]initWithString:@" " attributes:nil];
    CGFloat fontHeight = self.expressionLabel.font.pointSize;

    NSMutableArray* opArray = [ self arrayToDisplay];
    long  count = opArray.count;
    
    for(long  i = 0; i < count; i++)
    {
        NSString *  op = opArray[i];
        
        if([op isNumber])
        {
            NSMutableAttributedString * appText = [[NSMutableAttributedString alloc] initWithString:[@" " stringByAppendingString:op] attributes:nil];
            [displyText insertAttributedString:appText atIndex:displyText.length-1];
        }
        else{
            NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
            UIImage *img = [self image2WithHeight:fontHeight string:op];
            attachment.image = img;
            attachment.bounds = CGRectMake(0, 0, img.size.width , img.size.height);
            NSAttributedString *imgText = [NSAttributedString attributedStringWithAttachment:attachment];
            [displyText insertAttributedString:attriSpace atIndex:displyText.length-1];
            [displyText insertAttributedString:imgText atIndex:displyText.length-1];
        }
    }
    
    self.expressionLabel.attributedText = displyText;
    
}


-(NSMutableArray *)arrayToDisplay
{
    NSArray* tempArray = [_curExpression componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@" "]];
    NSMutableArray *opArray = [NSMutableArray arrayWithArray:tempArray];
    
    long  i=0;
    while(i < opArray.count)
    {
        if([opArray[i] isEqualToString:@""])
            [opArray removeObjectAtIndex:i];
        else
            i++;
    }
    return opArray;
}

-(UIImage*)imageWithHeight:(CGFloat)height string:(NSString*)string
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:height *0.6]}];

    CGRect textFrame;
    
    textFrame = [attrString boundingRectWithSize:CGSizeMake(200, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

    //图片宽度不小于28.
    textFrame = CGRectMake(0, 0, MAX(textFrame.size.width, 28), textFrame.size.height);
    // 1.开启上下文，第二个参数是是否不透明（opaque）NO为透明，这样可以防止占据额外空间（例如圆形图会出现方框），第三个为伸缩比例，0.0为不伸缩。
    UIGraphicsBeginImageContextWithOptions(textFrame.size, NO, 0.0);
    
    CATextLayer *layer = [CATextLayer layer];
    layer.bounds = textFrame;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.string = attrString;
    layer.contentsScale = 2.0f;
    layer.wrapped = YES;
    layer.cornerRadius = 5;
    layer.alignmentMode = kCAAlignmentCenter;
    
    // 2.将控制器view的layer渲染到上下文
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


-(UIImage*)image2WithHeight:(CGFloat)height string:(NSString*)string
{
    NSMutableAttributedString *attrString =
        [[NSMutableAttributedString alloc] initWithString:string
        attributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:height *0.7 ] } ];

//    [attrString addAttributes:@{NSBaselineOffsetAttributeName:@(5),NSFontAttributeName: [UIFont boldSystemFontOfSize:17]} range:(NSRange){3,2}];
    
    CGRect textFrame;
    
    textFrame = [attrString boundingRectWithSize:CGSizeMake(200, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    //图片宽度不小于28.
    textFrame = CGRectMake(0, 0, MAX(textFrame.size.width, 28), textFrame.size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:textFrame];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 1;
    label.attributedText = attrString;
    label.backgroundColor = [UIColor greenColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    // 1.开启上下文，第二个参数是是否不透明（opaque）NO为透明，这样可以防止占据额外空间（例如圆形图会出现方框），第三个为伸缩比例，0.0为不伸缩。
    UIGraphicsBeginImageContextWithOptions(textFrame.size, NO, 0.0);
    // 2.将控制器view的layer渲染到上下文
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
