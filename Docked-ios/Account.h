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
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *avatarUrl;
@property (nonatomic, copy, readonly) NSString *companyName;
@property (nonatomic, copy, readonly) NSNumber *followedProviderCount;
@property (nonatomic, copy, readonly) NSDictionary *providers;
@property (nonatomic, copy, readonly) NSArray *teammates;

-(BOOL)isLoggedIn;
-(void)updateAPNSPushTokenWithToken:(NSString *)token;
-(void)resetAPNSPushCount;

+(void)fetchRemoteUserAccountWithBlock:(void (^)(Account *))block;

-(void)uploadProfilePicture:(UIImage *)profilePicture;

-(User *)currentUser;
-(NSArray *)team;



@end
