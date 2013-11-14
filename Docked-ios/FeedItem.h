//
//  FeedItem.h
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface FeedItem : NSManagedObject

@property (nonatomic, retain) NSString * provider;
@property (nonatomic, retain) NSString * property;
@property (nonatomic, retain) NSString * action;
@property (nonatomic, retain) NSString * event;
@property (nonatomic, retain) NSString * externalID;
@property (nonatomic, retain) NSString * htmlUrl;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSArray *messages;

- (bool)hasMessages;
- (bool)hasMultipleMessages;
- (Message *)previewMessage;

- (NSFetchedResultsController*)messagesFetchedResultsController;


@end

@interface FeedItem (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inMessagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMessagesAtIndex:(NSUInteger)idx;
- (void)insertMessages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMessagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMessagesAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceMessagesAtIndexes:(NSIndexSet *)indexes withMessages:(NSArray *)values;
- (void)addMessagesObject:(NSManagedObject *)value;
- (void)removeMessagesObject:(NSManagedObject *)value;
- (void)addMessages:(NSOrderedSet *)values;
- (void)removeMessages:(NSOrderedSet *)values;
@end
