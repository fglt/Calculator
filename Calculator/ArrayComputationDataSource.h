//
//  ArrayComputationDataSource.h
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface ArrayComputationDataSource : NSObject<UITableViewDataSource>
- (id)initWithItems:(NSMutableArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
