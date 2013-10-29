//
//  TextItem.m
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLTextItem.h"

@implementation MTLTextItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"body": @"body"
                            };
    
    return [MTLFeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSString *)managedObjectEntityName {
    return @"TextItem";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

@end
