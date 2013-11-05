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
#import "TextCardCell.h"

@interface GithubPush : Github <TextCardProtocol>

@property (nonatomic, copy, readonly) NSString *repo;
@property (nonatomic, copy, readonly) NSString *pusher;
@property (nonatomic, copy, readonly) NSString *branch;
@property (nonatomic, copy, readonly) NSString *url;
@property (nonatomic, copy, readonly) NSArray *commits;

@end
