//
//  GithubPush.h
//  Docked-ios
//
//  Created by Charlie White on 9/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Github.h"
#import "GithubCommit.h"

@interface GithubPush : Github

@property (nonatomic, copy, readonly) NSString *pusher;
@property (nonatomic, copy, readonly) NSString *branch;
@property (nonatomic, copy, readonly) NSArray *commits;

@end
