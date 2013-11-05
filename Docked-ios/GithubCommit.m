//
//  GithubCommit.m
//  Docked-ios
//
//  Created by Charlie White on 9/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GithubCommit.h"

@implementation GithubCommit

+ (NSDateFormatter *)timestampDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"externalID": @"id",
            @"author": @"author",
            @"authorEmail": @"author_email",
            @"timestamp": @"timestamp",
            @"message": @"message",
            @"url": @"url"
        };
}

+ (NSString *)managedObjectEntityName {
    return @"GithubCommit";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSValueTransformer *)timestampJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.timestampDateFormatter dateFromString:str];
        
    } reverseBlock:^(NSDate *date) {
        return [self.timestampDateFormatter stringFromDate:date];
    }];
}

@end
