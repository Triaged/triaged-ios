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
#import "GithubPush.h"
#import "StripeChargeSucceeded.h"
#import "TextCardCell.h"
#import "DockedAPIClient.h"


@implementation FeedItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    if ([JSONDictionary[@"provider"]  isEqual: @"github"]) {
        if ([JSONDictionary[@"event"]  isEqual: @"push"]) {
            return GithubPush.class;
        }
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

-(Class)tableViewCellClass {
    return [TextCardCell class];
}

-(NSString *)externalLinkUrl {
    return @"http://google.com";
}

+ (NSValueTransformer *)messagesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Message class]];
}

+(NSMutableArray *)loadFeedItems {
    __block NSMutableArray *feedItems;
    [[DockedAPIClient sharedClient] GET:@"feed.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        NSArray *results = [JSON valueForKeyPath:@"feed"];
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FeedItem.class];
        feedItems = [[NSMutableArray alloc] initWithArray:[transformer transformedValue:results]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
        feedItems = [[NSMutableArray alloc] init];
    }];
    return feedItems;
}


@end
