//
//  ApdexAlertEnded.m
//  Docked-ios
//
//  Created by Charlie White on 10/7/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "NewRelicApdexAlertEnded.h"

@implementation NewRelicApdexAlertEnded

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
       @"applicationName": @"application_name",
       @"accountName": @"account_name",
       @"severity": @"severity",
       @"message": @"message",
       @"shortDescription": @"short_description",
       @"longDescription": @"long_description"
    };
    
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}


-(NSString *) action {
    return @"appdex alert ended";
}

@end
