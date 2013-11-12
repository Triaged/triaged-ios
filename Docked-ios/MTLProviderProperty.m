//
//  MTLProviderProperty.m
//  Triage-ios
//
//  Created by Charlie White on 11/8/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MTLProviderProperty.h"
#import "DockedAPIClient.h"

@implementation MTLProviderProperty

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"propertyID": @"id",
             @"name" : @"name",
             @"follows" : @"follows"
             };
}

- (void) followWithProvider:(Provider *)provider andAccount:(MTLProviderAccount *)account {
    
    // set this locally first
    _follows = true;
    
    NSString *path = [NSString stringWithFormat:@"provider_accounts/%@/provider_properties/%@/follow", account.accountID, _propertyID];
    
    [[DockedAPIClient sharedClient] POST:path parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // reset back if the post fails
        _follows = false;
    }];
}

- (void)  ignoreWithProvider:(Provider *)provider andAccount:(MTLProviderAccount *)account {
    _follows = false;
    
     NSString *path = [NSString stringWithFormat:@"provider_accounts/%@/provider_properties/%@/ignore", account.accountID, _propertyID];
    
    [[DockedAPIClient sharedClient] POST:path parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        // Reset back, if the post fails
        _follows = true;
    }];
}

@end
