//
//  FetchedFeedItemsDataSource.h
//  Docked-ios
//
//  Created by Charlie White on 10/14/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchedFeedItemsDataSource : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (id)feedItemAtIndexPath:(NSIndexPath *)indexPath;
- (id)feedItemAtForMessageIndexPath:(NSIndexPath *)indexPath;

@end
