//
//  Message.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Message.h"
#import "DockedAPIClient.h"
#import "AppDelegate.h"
#import "Store.h"
#import "UINavigationController+SGProgress.h"


@implementation Message

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return dateFormatter;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"externalID": @"id",
             @"author" : @"author",
             @"body": @"body",
             @"timestamp" : @"timestamp",
             @"uuid" : @"uuid"
             };
}


+ (NSString *)managedObjectEntityName {
    return @"Message";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{@"feedItem" : FeedItem.class, @"author" : User.class};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uuid"];
}

+ (NSValueTransformer *)authorJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[User class]];
}


+ (NSValueTransformer *)timestampJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
        
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (instancetype) buildNewMessageWithBody:(NSString *)body forFeedItem:(FeedItem *)item
{
    NSDictionary *attributes = @{
                                 @"body" : body,
                                 @"timestamp" : [NSDate date],
                                 @"feedItem" : item,
                                 @"author" : [AppDelegate sharedDelegate].store.account.currentUser,
                                 @"uuid" : [[NSUUID UUID] UUIDString]
                                 };
    
    Message *message = [[Message alloc] initWithDictionary:attributes error:nil];
    
    // add to local context
    [MTLManagedObjectAdapter managedObjectFromModel:message insertingIntoContext:[AppDelegate sharedDelegate].store.managedObjectContext error:nil];
    [[AppDelegate sharedDelegate].store.managedObjectContext save:nil];

    [message saveRemote];
    return message;
}


- (void)saveRemote
{
    NSString *path = [NSString stringWithFormat:@"feed/%@/messages.json", _feedItem.externalID];
    id params = @{@"message" : @{
                  @"author_id": self.author.userID,
                  @"body": self.body,
                  @"uuid": self.uuid,
                  @"timestamp" : [Message.dateFormatter stringFromDate:self.timestamp]
                }};
    
    [[DockedAPIClient sharedClient] POST:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
    
        [[AppDelegate sharedDelegate].navVC showSGProgressWithDuration:1.5];
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}


@end
