//
//  ArrayComputationDataSource.m
//  Calculator
//
//  Created by Coding on 7/18/16.
//  Copyright © 2016 Coding. All rights reserved.
//

#import "ArrayComputationDataSource.h"
#import "ComputationDao.h"
#import "Computation.h"
#import "ComputationCell.h"

@interface ArrayComputationDataSource ()
@property (nonatomic, strong) NSMutableArray              *items;
@property (nonatomic        ) NSString                    *cellIdentifier;
@property (nonatomic        ) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, weak  ) ComputationDao              * computationDao;

@end

@implementation ArrayComputationDataSource
-(id)initWithCellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    self.computationDao = [ComputationDao singleInstance];
    self.items = [self.computationDao findAll];
    self.cellIdentifier = aCellIdentifier;
    self.configureCellBlock = [aConfigureCellBlock copy] ;
    return self;
}

-(id) itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[self.items.count - 1 - indexPath.row];
}

-(void) deleteItemAtIndexPath:(NSIndexPath*)indexPath
{
    [self.items removeObjectAtIndex:self.items.count - 1 - indexPath.row];
    [self.computationDao remove:self.items.count  - indexPath.row];
}

-(void) deleteAll{
    [self.items removeAllObjects];
    [self.computationDao removeAll];
}

-(void) update{
    self.items = [self.computationDao findAll];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComputationCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete ) {
        // Delete the row from the data source
        if(indexPath.row>0){
            [self deleteItemAtIndexPath:indexPath];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [tableView reloadData];
        }
    }
    
}


@end
