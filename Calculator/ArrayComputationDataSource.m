//
//  ArrayComputationDataSource.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ArrayComputationDataSource.h"


@interface ArrayComputationDataSource ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic) NSString *cellIdentifier;
@property (nonatomic) TableViewCellConfigureBlock configureCellBlock;
@end

@implementation ArrayComputationDataSource
-(id)initWithItems:(NSMutableArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    self.items = anItems;
    self.cellIdentifier = aCellIdentifier;
    self.configureCellBlock = [aConfigureCellBlock copy] ;
    return self;
}

-(id) itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}
@end
