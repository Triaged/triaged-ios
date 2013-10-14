//
//  KilnPush.h
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "KilnCommit.h"

@interface KilnPush : FeedItem

@property (nonatomic, copy, readonly) NSString *repoName;
@property (nonatomic, copy, readonly) NSString *pusher;
@property (nonatomic, copy, readonly) NSString *branch;
@property (nonatomic, copy, readonly) NSString *repoUrl;
@property (nonatomic, copy, readonly) NSArray *commits;

@end
