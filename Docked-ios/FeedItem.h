//
//  FeedItem.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "Message.h"

@protocol DataSourceItem <NSObject>
-(Class)tableViewCellClass;
@end

@class Message;

@interface FeedItem : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, copy, readonly) NSString *htmlUrl;
@property (nonatomic, copy, readonly) NSArray *messages;
@property (nonatomic, copy, readonly) NSDate *timestamp;
@property (nonatomic, copy, readonly) NSDate *updatedAt;

+ (NSDictionary *)JSONKeyPathsWithSuper:(NSDictionary *)JSONKeyPaths;
+ (NSDictionary *)relationshipModelClassesWith:(NSDictionary *)relationshipModels;


+ (void)fetchNewRemoteFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block;

- (bool)hasMessages;
- (bool)hasMultipleMessages;
- (Message *)previewMessage;

- (NSArray *)sortedMessages;

- (NSFetchedResultsController*)messagesFetchedResultsController;

@end
