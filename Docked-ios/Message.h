//
//  Message.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "FeedItem.h"
#import "Account.h"


@interface Message : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, copy, readonly) NSString *authorName;
@property (nonatomic, copy, readonly) NSString *authorID;
@property (nonatomic, copy, readonly) NSString *body;
@property (nonatomic, copy, readonly) NSDate *timestamp;

+ (instancetype) buildNewMessageWithBody:(NSString *)body;
- (void)saveRemoteWithFeedItemID:(NSString *)feedItemID;

@end
