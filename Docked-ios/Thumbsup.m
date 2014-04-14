//
//  Thumbsup.m
//  Triage-ios
//
//  Created by Charlie White on 3/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "Thumbsup.h"
#import "FeedItem.h"
#import "User.h"
#import "SLRESTfulCoreData.h"


@implementation Thumbsup

@dynamic createdAt;
@dynamic user;
@dynamic feedItem;

+ (void)initialize {
    [self registerJSONPrefix:@"thumbsup"];
    [self registerCRUDBaseURL:[NSURL URLWithString:@"feed/:feed_item.id/thumbsups"]];
}

- (void)toggleThumbsUpWithCompletionHandler:(void(^)(Thumbsup *thumbsup, NSError *error))completionHandler
{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"feed/%@/thumbsup/toggle", self.feedItem.identifier]];
    [self postToURL:URL completionHandler:completionHandler];
}

@end
