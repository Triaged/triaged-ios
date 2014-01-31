//
//  User.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface User : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *slug;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *avatarUrl;
@property (nonatomic, readonly) BOOL registered;

+ (void)fetchRemoteTeamWithBlock:(void (^)(NSArray *))block;
- (void)fetchTeammateFeedItemsWithParams:(NSDictionary*)params andBlock:(void (^)(NSArray *))block;

@end
