//
//  Account.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "User.h"
#import "Provider.h"

@interface Account : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *slug;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *avatarUrl;
@property (nonatomic, copy, readonly) NSString *companyName;
@property (nonatomic, copy, readonly) NSString *apiToken;
@property (nonatomic, readonly) BOOL pushEnabled;
@property (nonatomic, readonly) BOOL validatedCompany;
@property (nonatomic, readonly) BOOL personalAccount;
@property (nonatomic, copy, readonly) NSString *validationToken;
@property (nonatomic, copy, readonly) NSNumber *followedProviderCount;
@property (nonatomic, copy, readonly) NSArray *providers;
@property (nonatomic, copy, readonly) NSArray *teammates;


+(void)fetchRemoteUserAccountWithBlock:(void (^)(Account *))block;

-(User *)currentUser;
-(void) createUserFromAccount;
-(NSArray *)team;

-(BOOL)isLoggedIn;
-(void)updateAPNSPushTokenWithToken:(NSString *)token;
-(void)resetAPNSPushCount;
-(void)welcomeComplete;
-(void)resendVerifyEmail;
-(void)setValidated;

-(void)uploadAvatar:(UIImage *)avatar WithBlock:(void (^)(bool))block;
- (void)updatePushEnabled:(BOOL)pushValue;

-(NSArray *)connectedProviders;
-(NSNumber *)connectedProviderCount;
-(Provider *)providerWithName:(NSString *)name;



@end
