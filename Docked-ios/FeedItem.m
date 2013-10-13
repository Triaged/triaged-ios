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
