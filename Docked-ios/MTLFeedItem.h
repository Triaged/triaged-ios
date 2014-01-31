//
//  MTLFeedItem.h
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FeedItemCellProtocol

    - (id)itemCellClass;

@end

@interface MTLFeedItem : MTLModel <MTLJSONSerializing, FeedItemCellProtocol>

@property (nonatomic, copy, readonly) NSString *ID;
@property (nonatomic, copy, readonly) NSArray *messages;
@property (nonatomic, copy, readonly) NSDate *timestamp;
@property (nonatomic, copy, readonly) NSDate *updatedAt;

+ (NSDictionary *)JSONKeyPathsWithSuper:(NSDictionary *)JSONKeyPaths;

+ (void)fetchNewRemoteFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block;

+ (void)fetchRemoteFeedItemWithID:(NSString*)feedItemID andBlock:(void (^)(MTLFeedItem *))block;



@end
