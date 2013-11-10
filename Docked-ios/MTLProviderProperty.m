//
//  MTLProviderProperty.m
//  Triage-ios
//
//  Created by Charlie White on 11/8/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLProviderProperty.h"

@implementation MTLProviderProperty

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"propertyID": @"id",
             @"name" : @"name",
             @"follows" : @"follows"
             };
}

@end
