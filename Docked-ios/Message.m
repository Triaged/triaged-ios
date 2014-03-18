//
//  Message.m
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "Message.h"
#import "FeedItem.h"
#import "User.h"
#import "SLRESTfulCoreData.h"


@implementation Message

@dynamic body;
@dynamic identifier;
@dynamic timestamp;
@dynamic uuid;
@dynamic author;
@dynamic feedItem;

+ (void)initialize {
    //[self registerJSONPrefix:@"message"];
     [self registerCRUDBaseURL:[NSURL URLWithString:@"feed/:feed_item.id/messages"]];
}

@end
