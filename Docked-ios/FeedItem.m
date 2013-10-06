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
#import "GoogleAnalyticsDailyStatus.h"


@implementation FeedItem

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    return dateFormatter;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"htmlUrl": @"html_url",
             @"messages": @"messages"
             };
}

+ (NSValueTransformer *)timestampJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];

    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
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
    
    if ([JSONDictionary[@"provider"]  isEqual: @"google_analytics"]) {
        if ([JSONDictionary[@"event"]  isEqual: @"daily"]) {
            return GoogleAnalyticsDailyStatus.class;
        }
    }
    
    return self;
    NSAssert(NO, @"No matching class for the JSON dictionary '%@'.", JSONDictionary);
    return self;
}

-(Class)tableViewCellClass {
    return [TextCardCell class];
}


-(NSString *)property {
    return @"FeedItem";
}

-(NSString *)action {
    return @"test";
}

-(NSString *)body {
    NSString *body = @"test body";
    return body;
}

-(NSString *)externalLinkUrl {
    return self.htmlUrl;
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"github.png"];;
}


+ (NSValueTransformer *)messagesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Message class]];
}

// ManagedObjects

+ (NSString *)managedObjectEntityName {
    return @"FeedItem";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{@"messages" : Message.class };
}



@end
