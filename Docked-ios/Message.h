//
//  Message.h
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"
#import "FeedItem.h"

@class FeedItem;
@class User;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * externalID;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) User *author;
@property (nonatomic, retain) FeedItem *feedItem;

+ (instancetype) buildNewMessageWithBody:(NSString *)body forFeedItem:(FeedItem *)item;

@end
