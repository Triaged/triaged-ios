////
////  MTLFeedItem.m
////  Triage-ios
////
////  Created by Charlie White on 1/23/14.
////  Copyright (c) 2014 Charlie White. All rights reserved.
////
//
//#import "MTLFeedItem.h"
//#import "NSString+Inflections.h"
//
//@implementation MTLFeedItem
//
//+ (NSDateFormatter *)timestampDateFormatter {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
//    return dateFormatter;
//}
//
//+ (NSDateFormatter *)dateFormatter {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
//    return dateFormatter;
//}
//
//+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
//             @"ID" : @"id",
//             @"messages": @"messages",
//             @"timestamp": @"timestamp",
//             @"updatedAt": @"updated_at"
//             };
//}
//
//+ (NSDictionary *)JSONKeyPathsWithSuper:(NSDictionary *)JSONKeyPaths
//{
//    NSMutableDictionary *ret = [[MTLFeedItem JSONKeyPathsByPropertyKey] mutableCopy];
//    [ret addEntriesFromDictionary:JSONKeyPaths];
//    return ret;
//}
//
//+ (NSValueTransformer *)timestampJSONTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
//        return [self.timestampDateFormatter dateFromString:str];
//        
//    } reverseBlock:^(NSDate *date) {
//        return [self.timestampDateFormatter stringFromDate:date];
//    }];
//}
//
//+ (NSValueTransformer *)updatedAtJSONTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
//        return [self.dateFormatter dateFromString:str];
//        
//    } reverseBlock:^(NSDate *date) {
//        return [self.dateFormatter stringFromDate:date];
//    }];
//}
//
//+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
//{
//    
//    NSString *cardType = [JSONDictionary[@"type"] camelize];
//    NSString *cardTypeClassString = [cardType stringByAppendingString:@"Card"];
//    //NSString *mantleCardTypeClassString = [@"MTL" stringByAppendingString:cardTypeClassString];
//    
//    return NSClassFromString(cardTypeClassString);
//}
//
//+ (void)fetchNewRemoteFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block
//{
//    [[DockedAPIClient sharedClient] GET:@"feed.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
//        NSValueTransformer *transformer;
//        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MTLFeedItem.class];
//        NSArray *newItems = [transformer transformedValue:JSON];
//        
//        block(newItems);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [CSNotificationView showInViewController:[AppDelegate sharedDelegate].navVC
//                                           style:CSNotificationViewStyleError
//                                         message:@"Feed failed to load."];
//        block(nil);
//        
//    }];
//}
//
//+ (void)fetchRemoteFeedItemWithID:(NSString*)feedItemID andBlock:(void (^)(MTLFeedItem *))block {
//    
//    NSString *path = [NSString stringWithFormat:@"feed/%@.json",feedItemID];
//    
//    [[DockedAPIClient sharedClient] GET:path parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
//        NSValueTransformer *transformer;
//        transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:MTLFeedItem.class];
//        MTLFeedItem *newFeedItem = [transformer transformedValue:JSON];
//        
//        block(newFeedItem);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [CSNotificationView showInViewController:[AppDelegate sharedDelegate].navVC
//                                           style:CSNotificationViewStyleError
//                                         message:@"FeedItem failed to load."];
//        block(nil);
//        
//    }];
//}
//
//
//- (id)itemCellClass {
//    assert("cell class must be overriden in sub class");
//    return nil;
//}
//
//
//@end
