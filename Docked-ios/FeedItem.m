//
//  FeedItem.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FeedItem.h"
#import "DockedAPIClient.h"
#import "TextCardCell.h"

#import "SentryException.h"
#import "GithubIssueOpened.h"
#import "GithubPush.h"
#import "StripeChargeSucceeded.h"
#import "GoogleAnalyticsDaily.h"
#import "NewRelicApdexAlert.h"
#import "NewRelicApdexAlertEnded.h"
#import "NewRelicAppAlert.h"
#import "NewRelicDeployment.h"
#import "NewRelicDowntime.h"
#import "NewRelicDowntimeEnded.h"
#import "NewRelicErrorThreshold.h"
#import "NewRelicErrorThresholdEnded.h"
#import "HerokuDeploy.h"
#import "NSString+Inflections.h"


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
             @"externalID": @"id",
             @"htmlUrl": @"html_url",
             @"messages": @"messages",
             @"timestamp": @"timestamp"
             };
}

+ (NSDictionary *)JSONKeyPathsWithSuper:(NSDictionary *)JSONKeyPaths
{
    NSMutableDictionary *ret = [[FeedItem JSONKeyPathsByPropertyKey] mutableCopy];
    [ret addEntriesFromDictionary:JSONKeyPaths];
    return ret;
}

+ (NSValueTransformer *)timestampJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];

    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}


+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    
    NSString *provider = [JSONDictionary[@"provider"] camelize];
    NSString *event = [JSONDictionary[@"event"] camelize];
    
    NSString *providerEventClassString = [provider stringByAppendingString:event];
    
    return NSClassFromString(providerEventClassString);
    
//    if ([JSONDictionary[@"provider"]  isEqual: @"github"]) {
//        if ([JSONDictionary[@"event"]  isEqual: @"push"]) {
//            return GithubPush.class;
//        }
//        if ([JSONDictionary[@"event"]  isEqual: @"issue_opened"]) {
//         return GithubIssueOpened.class;
//        }
//    }
//    
//    if ([JSONDictionary[@"provider"]  isEqual: @"sentry"]) {
//        if ([JSONDictionary[@"event"]  isEqual: @"exception"]) {
//            return SentryException.class;
//        }
//    }
//    
//    if ([JSONDictionary[@"provider"]  isEqual: @"stripe"]) {
//        if ([JSONDictionary[@"event"]  isEqual: @"charge_succeeded"]) {
//            return StripeChargeSucceeded.class;
//        }
//    }
//    
//    if ([JSONDictionary[@"provider"]  isEqual: @"heroku"]) {
//        if ([JSONDictionary[@"event"]  isEqual: @"deploy"]) {
//            return HerokuDeploy.class;
//        }
//    }
//    
//    if ([JSONDictionary[@"provider"]  isEqual: @"google_analytics"]) {
//        if ([JSONDictionary[@"event"]  isEqual: @"daily"]) {
//            return GoogleAnalyticsDailyStatus.class;
//        }
//    }
//    
//    if ([JSONDictionary[@"provider"]  isEqual: @"new_relic"]) {
//        if ([JSONDictionary[@"event"]  isEqual: @"apdex_alert"]) {
//            return ApdexAlert.class;
//        }
//        if ([JSONDictionary[@"event"]  isEqual: @"apdex_alert_ended"]) {
//            return ApdexAlertEnded.class;
//        }
//        if ([JSONDictionary[@"event"]  isEqual: @"app_alert"]) {
//            return AppAlert.class;
//        }
//        if ([JSONDictionary[@"event"]  isEqual: @"deployment"]) {
//            return Deployment.class;
//        }
//        if ([JSONDictionary[@"event"]  isEqual: @"downtime"]) {
//            return Downtime.class;
//        }
//        if ([JSONDictionary[@"event"]  isEqual: @"downtime_ended"]) {
//            return DowntimeEnded.class;
//        }
//        if ([JSONDictionary[@"event"]  isEqual: @"error_threshold"]) {
//            return ErrorThreshold.class;
//        }
//        if ([JSONDictionary[@"event"]  isEqual: @"error_threshold_ended"]) {
//            return ErrorThresholdEnded.class;
//        }
//    }
//    
//    return nil;
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

-(NSArray *)sortedMessages {
    return [_messages sortedArrayUsingComparator:^NSComparisonResult(Message *message1, FeedItem *message2) {
        return [message2.timestamp compare:message1.timestamp];
    }];
}

-(BOOL)addMessageWithBody:(NSString *)body {
    Message* newMessage = [Message buildNewMessageWithBody:body];
    [newMessage saveRemoteWithFeedItemID:_externalID];
    [self addMessageToItem:newMessage];
    return true;
}

-(void)addMessageToItem:(Message *)message {
    NSMutableArray *messages = [[NSMutableArray alloc] initWithArray:_messages];
    [messages addObject:message];
    _messages =  [NSArray arrayWithArray:messages];
}


+ (NSValueTransformer *)messagesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Message class]];
}

+ (void)fetchNewRemoteFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block
{
    [[DockedAPIClient sharedClient] GET:@"feed.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FeedItem.class];
        NSArray *newItems = [transformer transformedValue:JSON];
        
        block(newItems);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
        NSLog(@"%@", [error description]);
    }];
}


@end
