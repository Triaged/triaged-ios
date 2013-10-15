//
//  Downtime.m
//  Docked-ios
//
//  Created by Charlie White on 10/7/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "NewRelicDowntime.h"

@implementation NewRelicDowntime

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
       @"applicationName": @"application_name",
       @"accountName": @"account_name",
       @"severity": @"severity",
       @"message": @"message",
       @"shortDescrip": @"short_description",
       @"longDescrip": @"long_description"
    };
    
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSString *)managedObjectEntityName {
    return @"NewRelicDowntime";
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{}];
}



-(NSString *) action {
    return @"downtime";
}



@end
