//
//  Message.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLMessage.h"
#import "DockedAPIClient.h"
#import "AppDelegate.h"
#import "Store.h"
#import "UINavigationController+SGProgress.h"


@implementation MTLMessage

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
    return @{@"feedItem" : MTLOldFeedItem.class, @"author" : User.class};
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

+ (NSURLSessionDataTask *)saveRemote:(Message *)message
{
    
    NSString *path = [NSString stringWithFormat:@"feed/%@/messages.json", message.feedItem.externalID];
    id params = @{@"message" : @{
                  @"author_id": message.author.userID,
                  @"body": message.body,
                  @"uuid": message.uuid,
                  @"timestamp" : [MTLMessage.dateFormatter stringFromDate:message.timestamp]
                }};
    
    [[AppDelegate sharedDelegate].navVC showSGProgressWithDuration:1.5];
    return [[DockedAPIClient sharedClient] POST:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [CSNotificationView showInViewController:[AppDelegate sharedDelegate].navVC
                                           style:CSNotificationViewStyleError
                                         message:@"Message Failed to Send."];
        
        // Delete new Message
        NSManagedObjectContext *context = [AppDelegate sharedDelegate].store.managedObjectContext;
        [context deleteObject:message];
        NSError *saveError;
        if (![context save:&saveError]) {
            // Handle the error.
        }
    }];
}


@end
