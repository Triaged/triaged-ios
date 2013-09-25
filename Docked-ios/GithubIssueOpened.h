//
//  GithubIssueOpened.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface GithubIssueOpened : FeedItem

@property (nonatomic, copy, readonly) NSString *githubIssueOpenedID;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *openedByName;
@property (nonatomic, copy, readonly) NSString *AssignedToName;
@property (nonatomic, copy, readonly) NSString *body;
@property (nonatomic, copy, readonly) NSString *htmlUrl;

@end
