//
//  Store.h
//  Docked-ios
//
//  Created by Charlie White on 10/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@class NSFetchedResultsController;

@interface Store : NSObject

+ (instancetype)store;

@property (readonly, nonatomic, strong) NSArray* feedItems;
@property (readonly, nonatomic, strong) NSArray* users;
@property (readonly, nonatomic, strong) Account* account;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

- (NSFetchedResultsController*)feedItemsFetchedResultsController;

- (void)fetchRemoteFeedItems;

- (void)fetchNewRemoteFeedItemsWithBlock:(void (^)(NSArray *))block;

- (void)saveFeedToArchive;
- (void)saveAccountToArchive;


- (NSArray*)sortFeedItems;
- (NSArray*)sortedTableFeed;


@end
