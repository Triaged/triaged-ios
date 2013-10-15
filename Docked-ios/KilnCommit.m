//
//  KilnCommit.m
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "KilnCommit.h"

@implementation KilnCommit

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
             @"branch": @"branch",
             @"timestamp": @"timestamp",
             @"message": @"message",
             @"url": @"url"
             };
}

+ (NSString *)managedObjectEntityName {
    return @"KilnCommit";
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
