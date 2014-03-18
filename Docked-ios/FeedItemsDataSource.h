//
//  FeedItemsDataSource.h
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface FeedItemsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) NSArray *sortedDays;
@property (strong, nonatomic) NSDateFormatter *sectionDateFormatter;
@property (strong, nonatomic) UITableViewController *tableViewController;


- (void) setFeedItems:(NSMutableArray *)feedItems;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
