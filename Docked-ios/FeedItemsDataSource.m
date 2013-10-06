//
//  FeedItemsDataSource.m
//  Docked-ios
//
//  Created by Charlie White on 10/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FeedItemsDataSource.h"
#import "FeedItem.h"
#import "Message.h"
#import "CardCell.h"
#import "MoreMessagesCell.h"

@implementation FeedItemsDataSource

@synthesize feedItems;

- (id)initWithItems:(NSArray *)anfeedItems
{
    self = [super init];
    if (self) {
        self.feedItems = anfeedItems;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.feedItems[(NSUInteger) indexPath.section][indexPath.row];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.feedItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.feedItems[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if(indexPath.row == 0) { // Feed Item
        cell = [self cellForFeedItem:tableView AtIndexPath:indexPath];
    } else if (indexPath.row == 1) { // Last Message
        cell = [self cellForMessage:tableView AtIndexPath:indexPath];
//    } else if (indexPath.row == 2) { // Message Count
//        cell = [self cellForMessageCount:tableView AtIndexPath:indexPath];
    } else {
        cell = nil;
    }
    
    return cell;
}

- (UITableViewCell *)cellForFeedItem:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath {
    FeedItem *item = [self itemAtIndexPath:indexPath];
    
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
    
    return cell;
}
- (UITableViewCell *)cellForMessage:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MessageCell";
    MessageCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ MessageCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    Message *message = [self itemAtIndexPath:indexPath];
    NSNumber *messagesCount = @"3";
    
    cell.authorLabel.text = message.authorName;
    cell.bodyLabel.text = message.body;
    cell.moreMessagesLabel.text = [NSString stringWithFormat:@"+ %@ more", messagesCount];
    
    return cell;

}
- (UITableViewCell *)cellForMessageCount:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MoreMessagesCell";
    MoreMessagesCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ MoreMessagesCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    
    NSNumber *messagesCount = [self itemAtIndexPath:indexPath];
    
    cell.moreMessagesLabel.text = [NSString stringWithFormat:@"+ %@ more", messagesCount];
    
    return cell;
    
}


@end
