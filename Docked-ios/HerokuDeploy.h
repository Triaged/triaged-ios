//
//  HerokuDeploy.h
//  Docked-ios
//
//  Created by Charlie White on 10/12/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface HerokuDeploy : FeedItem

@property (nonatomic, copy, readonly) NSString *app;
@property (nonatomic, copy, readonly) NSString *user;
@property (nonatomic, copy, readonly) NSString *gitLog;

@end
