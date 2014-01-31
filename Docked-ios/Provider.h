//
//  Provider.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MTLProviderAccount.h"

@interface Provider : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *providerID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *webhookUrl;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *shortTitle;
@property (nonatomic, copy, readonly) NSString *icon;
@property (nonatomic, copy, readonly) NSString *settingsIcon;
@property (nonatomic, copy, readonly) NSString *largeIcon;
@property (nonatomic, copy, readonly) NSString *smallIcon;
@property (nonatomic, copy, readonly) MTLProviderAccount *account;
@property (nonatomic, readonly) BOOL oauth;
@property (nonatomic, readonly) BOOL connected;
@property (nonatomic, readonly) BOOL follows;

+ (NSArray *)currentProviders;
+ (NSDictionary *)settingsDictForProvider:(NSString *)providerName;

+ (void)fetchRemoteProvidersWithBlock:(void (^)(NSArray *))block;
+ (void)fetchRemoteConnectedProvidersWithBlock:(void (^)(NSArray *))block;
- (void)fetchProviderFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block;

- (void) connect;
- (void) follow;
- (void) ignore;
- (void) emailConnectInstructions;

@end
