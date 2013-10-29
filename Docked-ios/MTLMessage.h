//
//  Message.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MTLFeedItem.h"
#import "Account.h"
#import "MTLUser.h"
#import "Message.h"

@class MTLFeedItem;


@interface MTLMessage : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, copy, readonly) NSString *uuid;
@property (nonatomic, copy, readonly) NSString *body;
@property (nonatomic, copy, readonly) NSDate *timestamp;
@property (nonatomic, copy, readonly) MTLUser *author;
@property (nonatomic, copy, readonly) MTLFeedItem *feedItem;

+ (void)saveRemote:(Message *)message;



@end
