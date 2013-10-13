//
//  KilnCommit.m
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "KilnCommit.h"

@implementation KilnCommit

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


@end
