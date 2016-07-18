//
//  FirstViewController.m
//  MyCalculator
//
//  Created by Coding on 5/17/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "StandardViewController.h"
#import "constants.h"

#import "CalculatorBrain.h"


@interface StandardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lastExpression;
@property (weak, nonatomic) IBOutlet UILabel *input;
@property CalculatorBrain *brain;

@property BOOL isFirstInput;

@property BOOL isDotOK;
@property BOOL isINFINITY;
@end

@implementation StandardViewController

@synthesize isFirstInput;
@synthesize isDotOK;
@synthesize isINFINITY;
@synthesize brain;


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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self start];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

