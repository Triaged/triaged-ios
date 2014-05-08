//
//  Provider.h
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FeedItem;
@class Account;

@interface Provider : NSManagedObject

@property (nonatomic, retain) NSNumber * connected;
@property (nonatomic, retain) NSNumber * follows;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * largeIcon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * oauth;
@property (nonatomic, retain) NSString * shortTitle;
@property (nonatomic, retain) NSString * smallIcon;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * webhookUrl;
@property (nonatomic, retain) NSString * oauthPath;
@property (nonatomic, retain) NSSet *feedItems;
@property (nonatomic, retain) Account *account;

+ (void)providersWithCompletionHandler:(void(^)(NSArray *providers, NSError *error))completionHandler;


@end


@interface Provider (CoreDataGeneratedAccessors)

- (void)feedItemsWithCompletionHandler:(void(^)(NSArray *feedItems, NSError *error))completionHandler;

- (void)addFeedItemsObject:(FeedItem *)value;
- (void)removeFeedItemsObject:(FeedItem *)value;
- (void)addFeedItems:(NSSet *)values;
- (void)removeFeedItems:(NSSet *)values;

@end
