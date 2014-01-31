//
//  BaseCard.m
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "BaseCard.h"
#import "Provider.h"

@implementation BaseCard


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"provider" : @"provider",
                               @"event": @"event_name",
                               };
    
    return [MTLFeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSValueTransformer *)providerJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Provider class]];
}

+ (NSDictionary *)JSONKeyPathsWithSuper:(NSDictionary *)JSONKeyPaths
{
    NSMutableDictionary *ret = [[BaseCard JSONKeyPathsByPropertyKey] mutableCopy];
    [ret addEntriesFromDictionary:JSONKeyPaths];
    return ret;
}


@end