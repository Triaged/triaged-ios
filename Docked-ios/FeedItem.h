//
//  FeedItem.h
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Provider.h"
#import "User.h"

@protocol FeedItemCellProtocol

- (id)itemCellClass;

@end


@class Message, Provider, User;

@interface FeedItem : NSManagedObject <FeedItemCellProtocol>

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSOrderedSet *messages;
@property (nonatomic, retain) NSOrderedSet *thumbsups;
@property (nonatomic, retain) NSString *sectionIdentifier;
@property (nonatomic, retain) NSNumber *messagesCount;
@property (nonatomic, retain) Provider *provider;
@property (nonatomic, retain) User *user;

+ (void)feedItemsWithCompletionHandler:(void(^)(NSArray *feedItems, NSError *error))completionHandler;
@end

@interface FeedItem (CoreDataGeneratedAccessors)


- (void)addMessagesObject:(Message *)message withCompletionHandler:(void(^)(Message *message, NSError *error))completionHandler;

- (void)insertObject:(Message *)value inMessagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMessagesAtIndex:(NSUInteger)idx;
- (void)insertMessages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMessagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMessagesAtIndex:(NSUInteger)idx withObject:(Message *)value;
- (void)replaceMessagesAtIndexes:(NSIndexSet *)indexes withMessages:(NSArray *)values;
- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSOrderedSet *)values;
- (void)removeMessages:(NSOrderedSet *)values;
@end
