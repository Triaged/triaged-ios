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
@property (nonatomic, strong) Account* account;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

- (NSFetchedResultsController*)feedItemsFetchedResultsController;

- (void)fetchRemoteFeedItems;
- (void)fetchNewRemoteFeedItemsWithBlock:(void (^)(NSArray *))block;

- (void)setCurrentAccount: (Account *)account;
- (void)fetchRemoteUserAccount;
- (void)readAccountArchive;
- (void)saveAccountToArchive;


- (NSArray*)sortFeedItems;
- (NSArray*)sortedTableFeed;


@end
