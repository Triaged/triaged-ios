//
//  Message.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MTLOldFeedItem.h"
#import "MTLAccount.h"
#import "Message.h"

@class MTLOldFeedItem;

@interface MTLMessage : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, copy, readonly) NSString *uuid;
@property (nonatomic, copy, readonly) NSString *body;
@property (nonatomic, copy, readonly) NSDate *timestamp;
@property (nonatomic, copy, readonly) MTLOldFeedItem *feedItem;

+ (NSURLSessionDataTask *)saveRemote:(Message *)message;

@end
