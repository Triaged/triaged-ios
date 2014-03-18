//
//  FetchedFeedItemsDataSource.m
//  Docked-ios
//
//  Created by Charlie White on 10/14/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FeedItemsDataSource.h"
#import "EventCard.h"
#import "FeedItemCell.h"
#import "SpacerCell.h"
#import "NSDate+TimeAgo.h"
#import "CardViewController.h"
#import "FeedSectionViewController.h"

#define kLCellSpacerHeight      16.0f


@implementation FeedItemsDataSource

@synthesize sections, sortedDays, tableViewController;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
    return [eventsOnThisDay objectAtIndex:(indexPath.row / 2)];
}

- (void) setFeedItems:(NSMutableArray *)feedItems {
    self.sections = [NSMutableDictionary dictionary];
    for (FeedItem *event in feedItems)
    {
        // Reduce event start date to date components (year, month, day)
        NSDate *dateRepresentingThisDay = [self dateAtBeginningOfDayForDate:event.timestamp];
        
        // If we don't yet have an array to hold the events for this day, create one
        NSMutableArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
        if (eventsOnThisDay == nil) {
            eventsOnThisDay = [NSMutableArray array];
            
            // Use the reduced date as dictionary key to later retrieve the event list this day
            [self.sections setObject:eventsOnThisDay forKey:dateRepresentingThisDay];
        }
        
        // Add the event to the list for this day
        [eventsOnThisDay addObject:event];
    }
    
    // Create a sorted list of days
    NSArray *unsortedDays = [self.sections allKeys];
    NSSortDescriptor *dateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO selector:@selector(compare:)];
    self.sortedDays = [unsortedDays sortedArrayUsingDescriptors:[NSArray arrayWithObjects:dateSortDescriptor, nil]];
    //self.sortedDays = [unsortedDays sortedArrayUsingSelector:@selector(compare:)];
}

- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate
{
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:inputDate];
    
    // Set the time components manually
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    // Convert back
    NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
    return beginningOfDay;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return [self.sections count];
}




- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:sectionIndex];
    NSArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
    return [eventsOnThisDay count] * 2 + 1;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row % 2 != 1) {
        return [self cellForSpacerWith:tableView andIndexPath:indexPath];
    }else {
        return [self cellForFeedItemWith:tableView andIndexPath:indexPath];
    }
}

- (UITableViewCell*) cellForSpacerWith:(UITableView*)tableView andIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SpacerCell";
    SpacerCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ SpacerCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    return cell;
}

- (UITableViewCell*) cellForFeedItemWith:(UITableView*)tableView andIndexPath:(NSIndexPath *)indexPath {
    FeedItem *item = [self itemAtIndexPath:indexPath];
    
    Class cellClass = item.itemCellClass;
    NSString *cellID = NSStringFromClass(cellClass);
    
    if (item.imageUrl) {
        cellID = [NSString stringWithFormat:@"%@-image",cellID];
    }
    
    FeedItemCell *cell = [ tableView dequeueReusableCellWithIdentifier:cellID ] ;
    if ( !cell )
    {
        cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    }
    
    [cell configureForItem:item];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedItem * item = [self itemAtIndexPath:indexPath];
    
    CardViewController *detailVC = [[CardViewController alloc] init];
    [detailVC setFeedItem:item];
    
    [tableViewController.navigationController pushViewController:detailVC animated:YES];
    [tableViewController.tableView deselectRowAtIndexPath:[tableViewController.tableView indexPathForSelectedRow] animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:section];
    
    FeedSectionViewController *feedSectionVC = [[FeedSectionViewController alloc] initWithDate:dateRepresentingThisDay];
    
    return feedSectionVC.view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row % 2 != 1)
        return kLCellSpacerHeight;
    
    FeedItem *item = [self itemAtIndexPath:indexPath];
    Class cellClass = item.itemCellClass;
    
    NSString *cellID = NSStringFromClass(cellClass);
    
    if (item.imageUrl) {
        cellID = [NSString stringWithFormat:@"%@-image",cellID];
    }
    
    FeedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if ( !cell )
    {
        cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    }
    
    // Configure the cell for this indexPath
    
    [cell configureForItem:item];
    
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // Set the width of the cell to match the width of the table view. This is important so that we'll get the
    // correct height for different table view widths, since our cell's height depends on its width due to
    // the multi-line UILabel word wrapping. Don't need to do this above in -[tableView:cellForRowAtIndexPath]
    // because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 != 1)
        return kLCellSpacerHeight;
    return 200;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 42;
}

//- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
//    if ([tableViewController.tableView visibleCells].count > 0) {
//        //NSLog(@"%ld", (long)[[tableViewController.tableView indexPathForCell:[[tableViewController.tableView visibleCells] objectAtIndex:0]] section]);
//        //FeedSectionViewController *section = (FeedSectionViewController *)[tableViewController.tableView headerViewForSection:[[[tableViewController.tableView visibleCells] objectAtIndex:0] section]];
//        
//    }
//}



@end
