//
//  FeedItem.m
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FeedItem.h"
#import "AppDelegate.h"
#import "Store.h"


@implementation FeedItem

@dynamic provider;
@dynamic action;
@dynamic event;
@dynamic externalID;
@dynamic htmlUrl;
@dynamic property;
@dynamic timestamp;
@dynamic updatedAt;
@dynamic messages;

- (bool)hasMessages
{
    return (self.messages.count > 0);
}


- (bool)hasMultipleMessages
{
    return (self.messages.count > 1);
}

- (Message *)previewMessage
{
    NSArray * fetchedObjects =[[AppDelegate sharedDelegate].store.managedObjectContext executeFetchRequest:[self messageFetchRequest] error:nil];
    return (Message *)[fetchedObjects lastObject];
}

- (NSFetchedResultsController*)messagesFetchedResultsController
{
    return [[NSFetchedResultsController alloc] initWithFetchRequest:[self messageFetchRequest] managedObjectContext:[AppDelegate sharedDelegate].store.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (NSFetchRequest *)messageFetchRequest {
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
    [request setRelationshipKeyPathsForPrefetching:@[@"author"]];
    request.predicate = [NSPredicate predicateWithFormat:@"feedItem = %@", self];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    return request;
}


@end
