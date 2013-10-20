//
//  User.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userID": @"id",
             @"name": @"name",
             @"email": @"email",
             @"avatarUrl" : @"avatar_url"
             };
}

@end
