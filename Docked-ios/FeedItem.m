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
    return [self.messages lastObject];
}

- (NSFetchedResultsController*)messagesFetchedResultsController
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
    [request setRelationshipKeyPathsForPrefetching:@[@"author"]];
    request.predicate = [NSPredicate predicateWithFormat:@"feedItem = %@", self];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[AppDelegate sharedDelegate].store.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}


@end
