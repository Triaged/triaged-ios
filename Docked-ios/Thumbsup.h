//
//  Thumbsup.h
//  Triage-ios
//
//  Created by Charlie White on 3/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FeedItem, User;

@interface Thumbsup : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) FeedItem *feedItem;

- (void)toggleThumbsUpWithCompletionHandler:(void(^)(Thumbsup *thumbsup, NSError *error))completionHandler;

@end
