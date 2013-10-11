//
//  Store.m
//  Docked-ios
//
//  Created by Charlie White on 10/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Store.h"
#import "FeedItem.h"
#import "Account.h"
#import "DockedAPIClient.h"
#import "AppDelegate.h"

@interface Store ()
    @property (nonatomic,strong) NSString *minID;
@end

@implementation Store

+ (instancetype)store
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self readFeedArchive];
        [self readAccountArchive];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userLoggedIn)
                                                     name:@"login"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userSignedOut)
                                                     name:@"signout"
                                                   object:nil];

    }
    return self;
}

#pragma mark - Remote Updates

- (void) fetchRemoteUserAccount
{
    [Account fetchRemoteUserAccountWithBlock:^(Account *account) {
        _account = account;
    }];
}

- (void)fetchRemoteFeedItems
{
    [self fetchNewRemoteFeedItemsWithBlock:nil];
}

- (void)fetchNewRemoteFeedItemsWithBlock:(void (^)(NSArray *))block {
    NSDictionary *params;
    
    if (_minID != nil){
        params = [[NSDictionary alloc] initWithObjectsAndKeys:_minID, @"min_id", nil];
    }
    
    [FeedItem fetchNewRemoteFeedItemsWithParams:params andBlock:^(NSArray *newItems) {
        
        if (newItems.count > 0) {
            NSMutableArray *allFeedItems = [[NSMutableArray alloc] initWithArray:_feedItems];
            [allFeedItems addObjectsFromArray:newItems];
            _feedItems =  [NSArray arrayWithArray:allFeedItems];
        }
        
        // Need to call to ensure table views stop refreshing
        [self feedWasUpdated];
        
        if (block) block(newItems);
    }];
}

#pragma mark - Feed methods

- (NSArray *)sortedTableFeed {
    NSArray *sortedFeedItems = [self sortFeedItems];
    NSMutableArray *feed = [[NSMutableArray alloc] initWithCapacity:sortedFeedItems.count];
    
    for (FeedItem *item in sortedFeedItems) {
        [feed addObject:[self buildGroupedFeedItem:item]];
    }
    
    return [NSArray arrayWithArray:feed];
}

- (void) feedWasUpdated {
    // set minID for remote requests
    FeedItem *item = [[self sortFeedItems] firstObject];
    _minID = item.externalID;
    
    // Send notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"feedUpdated" object:self];
}

- (NSArray *)sortFeedItems
{
    return [self.feedItems sortedArrayUsingComparator:^NSComparisonResult(FeedItem *feedItem1, FeedItem *feedItem2) {
        return [feedItem2.externalID compare:feedItem1.externalID];
    }];
}

- (NSArray *)buildGroupedFeedItem:(FeedItem *)feedItem
{
    NSMutableArray *groupedFeedItem = [[NSMutableArray alloc] initWithObjects:feedItem, nil];
    if (feedItem.messages.count > 0) {
        [groupedFeedItem addObject:[feedItem.sortedMessages firstObject]];
    }
    return [NSArray arrayWithArray:groupedFeedItem];
}

#pragma mark - User Authentication

- (void) userLoggedIn
{
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    [self fetchRemoteUserAccount];
    [self fetchRemoteFeedItems];
}

- (void) userSignedOut
{
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalNever];
    _feedItems = nil;
    [self deleteFeedArchive];
}

#pragma mark - NSKeyArchiving

- (void)readFeedArchive
{
    NSString     * path         = [self pathForDataFile];
    NSDictionary * rootObject;
    
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    _feedItems = [rootObject valueForKey:@"feedItems"];
    
    [self feedWasUpdated];
    [self fetchRemoteFeedItems];
    
}

- (void)saveFeedToArchive
{
    NSString * path = [self pathForDataFile];
    
    NSMutableDictionary * rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue:_feedItems forKey:@"feedItems"];
    
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

- (BOOL)deleteFeedArchive
{
    NSString * path = [self pathForDataFile];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exists = [fm fileExistsAtPath:path];
    if(exists == YES) return [fm removeItemAtPath:path error:nil];
    return exists;
}

- (NSString *) pathForDataFile
{
    NSArray*	documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*	path = nil;
	
    if (documentDir) {
        path = [documentDir objectAtIndex:0];
    }
	
    return [NSString stringWithFormat:@"%@/%@", path, @"feed.bin"];
}

- (void)readAccountArchive
{
    NSString     * path         = [self pathForAccountFile];
    NSDictionary * rootObject;
    
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    _account = [rootObject valueForKey:@"account"];
    
    [self fetchRemoteUserAccount];
    
}

- (void)saveAccountToArchive
{
    NSString * path = [self pathForAccountFile];
    
    NSMutableDictionary * rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue:_account forKey:@"account"];
    
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

- (BOOL)deleteAccountArchive
{
    NSString * path = [self pathForAccountFile];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exists = [fm fileExistsAtPath:path];
    if(exists == YES) return [fm removeItemAtPath:path error:nil];
    return exists;
}

- (NSString *) pathForAccountFile
{
    NSArray*	documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*	path = nil;
	
    if (documentDir) {
        path = [documentDir objectAtIndex:0];
    }
	
    return [NSString stringWithFormat:@"%@/%@", path, @"account.bin"];
}




@end