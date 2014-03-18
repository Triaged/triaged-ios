//
//  MTLUser.h
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;
@class FeedItem;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * avatarUrl;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * registered;
@property (nonatomic, retain) NSString * slug;
@property (nonatomic, retain) NSSet *feedItems;

+ (void)teammatesWithCompletionHandler:(void(^)(NSArray *users, NSError *error))completionHandler;

@end


@interface User (CoreDataGeneratedAccessors)

- (void)feedItemsWithCompletionHandler:(void(^)(NSArray *feedItems, NSError *error))completionHandler;

- (void)addFeedItemsObject:(FeedItem *)value;
- (void)removeFeedItemsObject:(FeedItem *)value;
- (void)addFeedItems:(NSSet *)values;
- (void)removeFeedItems:(NSSet *)values;

@end



