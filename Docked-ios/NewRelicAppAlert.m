//
//  AppAlert.m
//  Docked-ios
//
//  Created by Charlie White on 10/7/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "NewRelicAppAlert.h"

@implementation NewRelicAppAlert

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
    return @"NewRelicAppAlert";
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{}];
}




-(NSString *) action {
    return @"app alert";
}

@end
