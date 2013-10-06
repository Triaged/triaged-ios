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
        [self fetchRemoteUserAccount];
        [self fetchRemoteFeedItems];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(fetchRemoteUserAccount)
                                                     name:@"login"
                                                   object:nil];

    }
    return self;
}

- (NSArray *)sortedFeed {
    NSArray *sortedFeedItems = [self sortedFeedItems];
    NSMutableArray *feed = [[NSMutableArray alloc] initWithCapacity:sortedFeedItems.count];
    
    for (FeedItem *item in sortedFeedItems) {
        [feed addObject:[self buildGroupedFeedItem:item]];
    }
    
    return [NSArray arrayWithArray:feed];
}

- (void) fetchRemoteUserAccount
{
    [[DockedAPIClient sharedClient] GET:@"account.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:Account.class];
        _account = [transformer transformedValue:JSON];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

- (void)fetchRemoteFeedItems {
    
    NSDictionary *params;
    
    if (_minID != nil){
        params = [[NSDictionary alloc] initWithObjectsAndKeys:_minID, @"min_id", nil];
    }
    
    [[DockedAPIClient sharedClient] GET:@"feed.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FeedItem.class];
        _feedItems = [transformer transformedValue:JSON];
        
        [self feedWasUpdated];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

- (void) feedWasUpdated {
    // set minID for remote requests
    FeedItem *item = [_feedItems firstObject];
    _minID = item.externalID;
    
    // Send notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"feedUpdated" object:self];
}

- (NSArray *)sortedFeedItems
{
    return [self.feedItems sortedArrayUsingComparator:^NSComparisonResult(FeedItem *feedItem1, FeedItem *feedItem2) {
        return [feedItem2.timestamp compare:feedItem1.timestamp];
    }];
}

- (NSArray *)buildGroupedFeedItem:(FeedItem *)feedItem
{
    NSMutableArray *groupedFeedItem = [[NSMutableArray alloc] initWithObjects:feedItem, nil];
    if (feedItem.messages.count == 1) {
        [groupedFeedItem addObject:[feedItem.messages firstObject]];
    } else if (feedItem.messages.count > 1) {
        [groupedFeedItem addObject:[feedItem.messages firstObject]];
        //[groupedFeedItem addObject:[NSNumber numberWithInt:(feedItem.messages.count - 1)]];
    }
    return [NSArray arrayWithArray:groupedFeedItem];
}

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

// Path to the data file in the app's Documents directory
- (NSString *) pathForDataFile {
    NSArray*	documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*	path = nil;
	
    if (documentDir) {
        path = [documentDir objectAtIndex:0];
    }
	
    return [NSString stringWithFormat:@"%@/%@", path, @"feed.bin"];
}




@end
