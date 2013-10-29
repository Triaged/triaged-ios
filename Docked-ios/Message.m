//
//  Message.m
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Message.h"
#import "FeedItem.h"
#import "AppDelegate.h"
#import "MTLMessage.h"
#import "Store.h"


@implementation Message

@dynamic body;
@dynamic externalID;
@dynamic timestamp;
@dynamic uuid;
@dynamic author;
@dynamic feedItem;

+ (instancetype) buildNewMessageWithBody:(NSString *)body forFeedItem:(FeedItem *)item
{
    Message *message = [NSEntityDescription insertNewObjectForEntityForName:@"Message"
                                                     inManagedObjectContext:[AppDelegate sharedDelegate].store.managedObjectContext];

    message.feedItem    = item;
    message.body        = body;
    message.timestamp   = [NSDate date];
    message.author      = [AppDelegate sharedDelegate].store.account.currentUser;
    message.uuid        = [[NSUUID UUID] UUIDString];
    
    [[AppDelegate sharedDelegate].store.managedObjectContext save:nil];
    
    // Save remote
    [MTLMessage saveRemote:message];
    
    return message;
}

@end
