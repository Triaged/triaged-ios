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

@interface Account : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *slug;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *avatarUrl;
@property (nonatomic, copy, readonly) NSString *companyName;
@property (nonatomic, copy, readonly) NSNumber *followedProviderCount;
@property (nonatomic, copy, readonly) NSDictionary *providers;
@property (nonatomic, copy, readonly) NSArray *teammates;


+(void)fetchRemoteUserAccountWithBlock:(void (^)(Account *))block;

-(User *)currentUser;
-(void) createUserFromAccount;
-(NSArray *)team;

-(BOOL)isLoggedIn;
-(void)updateAPNSPushTokenWithToken:(NSString *)token;
-(void)resetAPNSPushCount;
-(void)uploadProfilePicture:(UIImage *)profilePicture;
-(void)uploadAvatar:(UIImage *)avatar WithBlock:(void (^)(bool))block;


-(NSArray *)connectedProviders;
-(NSNumber *)connectedProviderCount;



@end
