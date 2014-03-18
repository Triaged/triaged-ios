//
//  FeedItem.m
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "FeedItem.h"
#import "Message.h"
#import "Provider.h"
#import "EventCard.h"
#import "SLRESTfulCoreData.h"

@interface FeedItem ()

@property (nonatomic) NSString *primitiveSectionIdentifier;

@end


@implementation FeedItem

@dynamic identifier;
@dynamic timestamp;
@dynamic updatedAt;
@dynamic imageUrl;
@dynamic messages;
@dynamic provider, sectionIdentifier, primitiveSectionIdentifier;

+ (void)initialize
{
    [self registerSubclass:EventCard.class forManagedObjectAttributeName:@"type" withValue:@"event"];
    [self registerCRUDBaseURL:[NSURL URLWithString:@"feed/:id/messages"] forRelationship:@"messages"];

}

+ (void)feedItemsWithCompletionHandler:(void(^)(NSArray *feedItems, NSError *error))completionHandler {
    NSURL *URL = [NSURL URLWithString:@"feed.json"];
    [self fetchObjectsFromURL:URL completionHandler:completionHandler];
}

- (id)itemCellClass {
    return nil;
}

- (NSString *)sectionIdentifier
{
    // Create and cache the section identifier on demand.
    
    [self willAccessValueForKey:@"sectionIdentifier"];
    NSString *tmp = [self primitiveSectionIdentifier];
    [self didAccessValueForKey:@"sectionIdentifier"];
    
    if (!tmp)
    {
        /*
         Sections are organized by month and year. Create the section identifier as a string representing the number (year * 1000) + month; this way they will be correctly ordered chronologically regardless of the actual name of the month.
         */
        tmp = [FeedItem.timestampDateFormatter stringFromDate:[self timestamp]];
        [self setPrimitiveSectionIdentifier:tmp];
    }
    return tmp;
}


+ (NSDateFormatter *)timestampDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM dd, YYYY";
    return dateFormatter;
}


@end
