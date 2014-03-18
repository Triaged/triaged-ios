//
//  MTLUser.m
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "User.h"
#import "Message.h"
#import "SLRESTfulCoreData.h"


@implementation User

@dynamic avatarUrl;
@dynamic email;
@dynamic identifier;
@dynamic name;
@dynamic registered;
@dynamic slug;
@dynamic feedItems;


+ (void)initialize
{
    [self registerCRUDBaseURL:[NSURL URLWithString:@"team/:id/feed.json"] forRelationship:@"feedItems"];
}

+ (void)teammatesWithCompletionHandler:(void(^)(NSArray *users, NSError *error))completionHandler {
    NSURL *URL = [NSURL URLWithString:@"team.json"];
    [self fetchObjectsFromURL:URL completionHandler:completionHandler];
}


//
//+ (void)fetchRemoteTeamWithBlock:(void (^)(NSArray *))block
//{
//    [[DockedAPIClient sharedClient] GET:@"team.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
//        NSValueTransformer *transformer;
//        
//        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:MTLUser.class];
//        
//        NSArray *team = [transformer transformedValue:JSON];
//        
//        block(team);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure");
//    }];
//}
//
//- (void)fetchTeammateFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block
//{
//    NSString *path = [NSString stringWithFormat:@"team/%@/feed", self.userID];
//    
//    [[DockedAPIClient sharedClient] GET:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
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




@end
