//
//  Provider.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Provider.h"

@implementation Provider

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
     @"providerID": @"id",
    };
}

@end
