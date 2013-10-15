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
             @"authorName": @"author_name",
             @"body": @"body",
             @"timestamp" : @"timestamp"
             };
}

+ (NSValueTransformer *)timestampJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
        
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

// ManagedObjects

+ (instancetype) buildNewMessageWithBody:(NSString *)body
{
    NSDictionary *attributes = @{
                                 @"body" : body,
                                 @"authorName" : [AppDelegate sharedDelegate].store.account.name,
                                 @"authorID" : [AppDelegate sharedDelegate].store.account.userID,
                                 @"timestamp" : [NSDate date]
                                 };
    
    Message *message = [[Message alloc] initWithDictionary:attributes error:nil];
    return message;
}


- (void)saveRemoteWithFeedItemID:(NSString *)feedItemID
{
    NSString *path = [NSString stringWithFormat:@"feed/%@/messages.json", feedItemID];
    id params = @{@"message" : @{
                  @"author_id": self.authorID,
                  @"body": self.body
                }};
    
    [[DockedAPIClient sharedClient] POST:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        [[AppDelegate sharedDelegate].navVC showSGProgressWithDuration:1.5];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}


@end
