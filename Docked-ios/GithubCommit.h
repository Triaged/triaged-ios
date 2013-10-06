//
//  GithubCommit.h
//  Docked-ios
//
//  Created by Charlie White on 9/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Github.h"

@interface GithubCommit : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *author;
@property (nonatomic, copy, readonly) NSString *authorEmail;
@property (nonatomic, copy, readonly) NSString *timestamp;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSString *url;

@end
