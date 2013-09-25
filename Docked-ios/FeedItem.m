//
//  FeedItem.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FeedItem.h"
#import "SentryException.h"
#import "GithubIssueOpened.h"
#import "StripeChargeSucceeded.h"


@implementation FeedItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    if ([JSONDictionary[@"provider"]  isEqual: @"github"]) {
         if ([JSONDictionary[@"event"]  isEqual: @"issue_opened"]) {
             return GithubIssueOpened.class;
         }
    }
    
    if ([JSONDictionary[@"provider"]  isEqual: @"sentry"]) {
        if ([JSONDictionary[@"event"]  isEqual: @"exception"]) {
            return SentryException.class;
        }
    }
    
    if ([JSONDictionary[@"provider"]  isEqual: @"stripe"]) {
        if ([JSONDictionary[@"event"]  isEqual: @"charge_succeeded"]) {
            return StripeChargeSucceeded.class;
        }
    }
    
    NSAssert(NO, @"No matching class for the JSON dictionary '%@'.", JSONDictionary);
    return self;
}

@end
