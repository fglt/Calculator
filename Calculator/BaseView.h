//
//  BaseView.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResultView;
@class HistoryBoardView;
@class CalBoardView;

@interface BaseView : UIView
@property (weak, nonatomic) IBOutlet ResultView *resultView;
@property (weak, nonatomic) IBOutlet HistoryBoardView *historyView;
@property (weak, nonatomic) IBOutlet CalBoardView *calView;
@property (nonatomic, strong) UIButton *historyButton;

@end
