//
//  Account.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Account.h"
#import "Provider.h"

@implementation Account

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
      @"userID": @"id",
    };
}


+ (NSValueTransformer *)providersTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Provider class]];
}



@end
