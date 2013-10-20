//
//  Account.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Account.h"
#import "Provider.h"
#import "DockedAPIClient.h"
#import "CredentialStore.h"

@implementation Account

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
      @"userID": @"id",
      @"name": @"name",
      @"email": @"email",
      @"providers": @"providers",
      @"followedProviderCount" : @"followed_provider_count",
      @"companyName" : @"company_name",
      @"teammates" : @"teammates",
      @"avatarUrl" : @"avatar_url"
    };
}


+ (NSValueTransformer *)teammatesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[User class]];
}


+ (void)fetchRemoteUserAccountWithBlock:(void (^)(Account *))block
{
    [[DockedAPIClient sharedClient] GET:@"account.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:Account.class];
        
        block([transformer transformedValue:JSON]);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
}

-(BOOL)isLoggedIn {
    return [[CredentialStore sharedClient] isLoggedIn];
}

-(void)updateAPNSPushTokenWithToken:(NSString *)token {
    
    id params = @{@"push_token" : @{
                          @"service": @"apns",
                          @"token": token
                          }};
    
    [[DockedAPIClient sharedClient] POST:@"account/push_tokens.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

-(void)resetAPNSPushCount
{
    
    id params = @{@"push_token" : @{
                        @"service": @"apns"
                        }};
    
    [[DockedAPIClient sharedClient] POST:@"account/push_tokens/reset_count.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}


@end
