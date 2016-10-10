//
//  ClearHistoryController.h
//  Calculator
//
//  Created by Coding on 7/19/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClearHistoryControllerDelegate <NSObject>

- (void)clearTable;

@end

@interface ClearHistoryController : UIViewController
@property(nonatomic, weak) id<ClearHistoryControllerDelegate>  delegate;
@end
