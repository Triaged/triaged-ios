//
//  GithubCommit.m
//  Docked-ios
//
//  Created by Charlie White on 9/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GithubCommit.h"

@implementation GithubCommit

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"externalID": @"id",
            @"author": @"author",
            @"authorEmail": @"author_email",
            @"timestamp": @"timestamp",
            @"message": @"message",
            @"url": @"url"
        };
}

@end
