//
//  CellSelectedControllerViewController.h
//  Calculator
//
//  Created by Coding on 7/19/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellSelectedControllerDelegate <NSObject>

-(void)deleteCellAtIndex:(NSIndexPath*)indexPath;
-(void)useResultAtIndex:(NSIndexPath*)indexPath;
-(void)useExpressionAtIndex:(NSIndexPath*)indexPath;

@end

@interface CellSelectedControllerViewController : UIViewController
@property (nonatomic, weak) id<CellSelectedControllerDelegate> delegate;
@property (nonatomic, copy) NSIndexPath *indexPath;
@end

