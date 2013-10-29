//
//  FetchedMessagesDataSource.m
//  Docked-ios
//
//  Created by Charlie White on 10/15/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FetchedMessagesDataSource.h"
#import "FeedItem.h"
#import "Message.h"
#import "MessageCell.h"
#import "NSDate+TimeAgo.h"


@implementation FetchedMessagesDataSource

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (id)messageAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
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
    static NSString *CellIdentifier = @"MessageCell";
    MessageCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ MessageCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    Message *message = [self messageAtIndexPath:indexPath];
    
    [cell configureForMessage:message];
    cell.shouldDrawSeparator = (indexPath.row == 0) ? NO : YES;
    
    return cell;
}

- (void)setFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController
{
    NSAssert(_fetchedResultsController == nil, @"TODO: you can currently only assign this property once");
    _fetchedResultsController = fetchedResultsController;
    [fetchedResultsController performFetch:NULL];
}

@end
