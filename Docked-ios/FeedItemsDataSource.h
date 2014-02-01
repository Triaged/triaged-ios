//
//  FeedItemsDataSource.h
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLFeedItem.h"

@interface FeedItemsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) NSArray *sortedDays;
@property (strong, nonatomic) NSDateFormatter *sectionDateFormatter;
@property (strong, nonatomic) UITableViewController *tableViewController;


- (void) setFeedItems:(NSArray *)feedItems;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
