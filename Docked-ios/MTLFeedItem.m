//
//  FeedItem.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLFeedItem.h"
#import "DockedAPIClient.h"
#import "TextCardCell.h"
#import "NSString+Inflections.h"
#import "AppDelegate.h"
#import "Store.h"


@implementation MTLFeedItem

+ (NSDateFormatter *)timestampDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return dateFormatter;
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    return dateFormatter;
}

+ (Class)classForDeserializingManagedObject:(NSManagedObject *)managedObject {
    return NSClassFromString(managedObject.entity.name);
}



+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"provider": @"provider",
             @"action": @"action",
             @"event": @"event",
             @"property": @"property",
             @"externalID": @"id",
             @"htmlUrl": @"html_url",
             @"messages": @"messages",
             @"timestamp": @"timestamp",
             @"updatedAt": @"updated_at"
             };
}

+ (NSString *)managedObjectEntityName {
    return @"FeedItem";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{@"messages" : MTLMessage.class};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"externalID"];
}

+ (NSDictionary *)JSONKeyPathsWithSuper:(NSDictionary *)JSONKeyPaths
{
    NSMutableDictionary *ret = [[MTLFeedItem JSONKeyPathsByPropertyKey] mutableCopy];
    [ret addEntriesFromDictionary:JSONKeyPaths];
    return ret;
}

+ (NSDictionary *)relationshipModelClassesWith:(NSDictionary *)relationshipModels
{
    NSMutableDictionary *ret = [[NSMutableDictionary alloc] initWithDictionary:@{@"messages" : MTLMessage.class}];
    [ret addEntriesFromDictionary:relationshipModels];
    return ret;
}

+ (NSValueTransformer *)timestampJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.timestampDateFormatter dateFromString:str];

    } reverseBlock:^(NSDate *date) {
        return [self.timestampDateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)updatedAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
        
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
    
    NSString *cardType = [JSONDictionary[@"card_type"] camelize];
    NSString *cardTypeClassString = [cardType stringByAppendingString:@"Item"];
    NSString *mantleCardTypeClassString = [@"MTL" stringByAppendingString:cardTypeClassString];
    
    return NSClassFromString(mantleCardTypeClassString);
}

-(NSArray *)sortedMessages {
    return [_messages sortedArrayUsingComparator:^NSComparisonResult(MTLMessage *message1, MTLFeedItem *message2) {
        return [message2.timestamp compare:message1.timestamp];
    }];
}

- (bool)hasMessages
{
    return (_messages.count > 0);
}


- (bool)hasMultipleMessages
{
    return (_messages.count > 1);
}

- (MTLMessage *)previewMessage
{
    return [_messages lastObject];
}


+ (NSValueTransformer *)messagesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MTLMessage class]];
}

+ (void)fetchNewRemoteFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block
{
    [[DockedAPIClient sharedClient] GET:@"feed.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MTLFeedItem.class];
        NSArray *newItems = [transformer transformedValue:JSON];
        
        block(newItems);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
        NSLog(@"%@", [error description]);
    }];
}

- (NSManagedObject *)managedItem
{
    return [MTLManagedObjectAdapter managedObjectFromModel:self insertingIntoContext:[AppDelegate sharedDelegate].store.managedObjectContext error:nil];
}

- (NSFetchedResultsController*)messagesFetchedResultsController
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
    [request setRelationshipKeyPathsForPrefetching:@[@"author"]];
    request.predicate = [NSPredicate predicateWithFormat:@"feedItem = %@", [self managedItem]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[AppDelegate sharedDelegate].store.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}


@end
