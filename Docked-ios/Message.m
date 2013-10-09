//
//  Message.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Message.h"
#import "DockedAPIClient.h"

@implementation Message


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"externalID": @"id",
             @"authorName": @"author_name",
             @"body": @"body"
             };
}

// ManagedObjects

+ (NSString *)managedObjectEntityName {
    return @"Message";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}


@end
