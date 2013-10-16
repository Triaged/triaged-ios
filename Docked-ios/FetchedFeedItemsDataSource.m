//
//  FetchedFeedItemsDataSource.m
//  Docked-ios
//
//  Created by Charlie White on 10/14/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FetchedFeedItemsDataSource.h"
#import "FeedItem.h"
#import "CardCell.h"

@implementation FetchedFeedItemsDataSource

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (id)feedItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [MTLManagedObjectAdapter modelOfClass:FeedItem.class
                        fromManagedObject:[self.fetchedResultsController objectAtIndexPath:indexPath] error:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    id<NSFetchedResultsSectionInfo> section = self.fetchedResultsController.sections[sectionIndex];
    return section.numberOfObjects;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell;
     cell = [self cellForFeedItem:tableView AtIndexPath:indexPath];
//    
//    if(indexPath.row == 0) { // Feed Item
//        cell = [self cellForFeedItem:tableView AtIndexPath:indexPath];
//    } else if (indexPath.row == 1) { // Last Message
//        cell = [self cellForMessage:tableView AtIndexPath:indexPath];
//    } else {
//        cell = nil;
//    }
    
    return cell;
}

- (UITableViewCell *)cellForFeedItem:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"%@", object);
    FeedItem *item = [self feedItemAtIndexPath:indexPath];

    
    // Determine the cell class
    id<DataSourceItem> cellSource = (id<DataSourceItem>)item;
    Class cellClass = [ cellSource tableViewCellClass ] ;
    NSString * cellID = NSStringFromClass( cellClass ) ;
    
    CardCell *cell = [ tableView dequeueReusableCellWithIdentifier:cellID ] ;
    if ( !cell )
    {
        cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    }
    
    // Configure the cell...
    [cell configureForItem:item];
    // Should we draw the shadow?
    //NSInteger numberOfRows = [tableView numberOfRowsInSection:[indexPath section]];
    //cell.shouldDrawShadow = (numberOfRows == 1);
    
    return cell;
}



#pragma mark NSFetchedResultsControllerDelegate

- (void)setFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController
{
    NSAssert(_fetchedResultsController == nil, @"TODO: you can currently only assign this property once");
    _fetchedResultsController = fetchedResultsController;
    fetchedResultsController.delegate = self;
    [fetchedResultsController performFetch:NULL];
}


@end
