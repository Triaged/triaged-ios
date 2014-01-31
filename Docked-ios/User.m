//
//  User.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "User.h"
#import "MTLFeedItem.h"

@implementation User

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userID": @"id",
             @"name": @"name",
             @"slug" : @"slug",
             @"email": @"email",
             @"avatarUrl" : @"avatar_url",
             @"registered" : @"registered"
             };
}

+ (void)fetchRemoteTeamWithBlock:(void (^)(NSArray *))block
{
    [[DockedAPIClient sharedClient] GET:@"team.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        NSValueTransformer *transformer;
        
        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:User.class];
        
        NSArray *team = [transformer transformedValue:JSON];
        
        block(team);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

- (void)fetchTeammateFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block
{
    NSString *path = [NSString stringWithFormat:@"team/%@/feed", self.userID];
    
    [[DockedAPIClient sharedClient] GET:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MTLFeedItem.class];
        NSArray *newItems = [transformer transformedValue:JSON];
        
        block(newItems);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [CSNotificationView showInViewController:[AppDelegate sharedDelegate].navVC
                                           style:CSNotificationViewStyleError
                                         message:@"Feed failed to load."];
        block(nil);
        
    }];
}






@end
