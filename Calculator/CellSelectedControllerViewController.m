//
//  CellSelectedControllerViewController.m
//  Calculator
//
//  Created by Coding on 7/19/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "CellSelectedControllerViewController.h"

@interface CellSelectedControllerViewController ()

@end

@implementation CellSelectedControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onClickDelete:(UIButton *)sender {
    [self.delegate deleteCellAtIndex:self.indexPath];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickUseResult:(UIButton *)sender {
    [self.delegate useResultAtIndex:self.indexPath];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickUseExpression:(UIButton *)sender {
    [self.delegate useExpressionAtIndex:self.indexPath];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
