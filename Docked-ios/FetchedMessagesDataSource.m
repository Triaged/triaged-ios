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

@synthesize messages;


- (id)messageAtIndexPath:(NSIndexPath *)indexPath
{
    return [messages objectAtIndex:indexPath.row];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    return messages.count;
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
