//
//  Account.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface Account : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSDictionary *providers;

+(void) fetchRemoteUserAccountWithBlock:(void (^)(Account *))block;

+(void) updateAPNSPushTokenWithToken:(NSString *)token;

@end
