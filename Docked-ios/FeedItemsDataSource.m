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


@implementation FeedItemsDataSource

@synthesize sections, sortedDays;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
    return [eventsOnThisDay objectAtIndex:(indexPath.row / 2)];
}

- (void) setFeedItems:(NSArray *)feedItems {
    self.sections = [NSMutableDictionary dictionary];
    for (MTLFeedItem *event in feedItems)
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
    MTLFeedItem *item = [self itemAtIndexPath:indexPath];
    
    Class cellClass = item.itemCellClass;
    NSString *cellID = NSStringFromClass(cellClass);
    
    FeedItemCell *cell = [ tableView dequeueReusableCellWithIdentifier:cellID ] ;
    if ( !cell )
    {
        cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    }
    
    cell.shouldSetFrame = YES;
    [cell configureForItem:item];
    
    return cell;
}


@end
