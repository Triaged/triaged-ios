//
//  Store.h
//  Docked-ios
//
//  Created by Charlie White on 10/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface Store : NSObject

+ (instancetype)store;

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (readonly, nonatomic, strong) NSArray* feedItems;
@property (readonly, nonatomic, strong) NSArray* users;
@property (readonly, nonatomic, strong) Account* account;

- (void)fetchRemoteFeedItems;
- (void)saveFeedToArchive;


- (NSArray*)sortedFeedItems;
- (NSArray*)sortedFeed;


@end
