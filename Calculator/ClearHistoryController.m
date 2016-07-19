//
//  ClearHistoryController.m
//  Calculator
//
//  Created by Coding on 7/19/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ClearHistoryController.h"

@interface ClearHistoryController ()

@end

@implementation ClearHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickClear:(UIButton *)sender {
    [self.delegate clearTable];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
