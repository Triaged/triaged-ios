//
//  ApdexAlert.m
//  Docked-ios
//
//  Created by Charlie White on 10/7/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "NewRelicApdexAlert.h"

@implementation NewRelicApdexAlert

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
       @"applicationName": @"application_name",
       @"accountName": @"account_name",
       @"severity": @"severity",
       @"message": @"message",
       @"shortMessage": @"short_description",
       @"longMessage": @"long_description"
    };
    
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

-(NSString *) action {
    return @"apdex alert";
}

+ (NSString *)managedObjectEntityName {
    return @"NewRelicApdexAlert";
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{}];
}


-(Class)tableViewCellClass {
    return [TextCardCell class];
}


@end
