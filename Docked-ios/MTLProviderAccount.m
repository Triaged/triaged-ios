//
//  MTLProviderAccount.m
//  Triage-ios
//
//  Created by Charlie White on 11/8/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLProviderAccount.h"

@implementation MTLProviderAccount

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"accountID": @"id",
             @"name" : @"name",
             @"accountLabel" : @"account_label",
             @"propertyLabel" : @"property_label",
             @"properties" : @"provider_properties"
             };
}

+ (NSValueTransformer *)propertiesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MTLProviderProperty class]];
}


@end
