//
//  Provider.m
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "Provider.h"
#import "FeedItem.h"
#import "SLRESTfulCoreData.h"


@implementation Provider

@dynamic connected;
@dynamic follows;
@dynamic identifier;
@dynamic largeIcon;
@dynamic name;
@dynamic oauth;
@dynamic shortTitle;
@dynamic smallIcon;
@dynamic title;
@dynamic webhookUrl;
@dynamic oauthPath;
@dynamic feedItems;
@dynamic account;

+ (void)initialize
{
    [self registerCRUDBaseURL:[NSURL URLWithString:@"providers/:id/feed.json"] forRelationship:@"feedItems"];
}

+ (void)providersWithCompletionHandler:(void(^)(NSArray *providers, NSError *error))completionHandler {
//    NSURL *URL = [NSURL URLWithString:@"providers.json"];
    NSURL *URL = [NSURL URLWithString:@"apps/2/providers.json"];
    [self fetchObjectsFromURL:URL completionHandler:completionHandler];

//apps/2/providers.json
}

@end
