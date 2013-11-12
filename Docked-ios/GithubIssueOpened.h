//
//  GithubIssueOpened.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Github.h"

@interface GithubIssueOpened : Github 

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *openedByName;
@property (nonatomic, copy, readonly) NSString *assignedToName;
@property (nonatomic, copy, readonly) NSString *message;


@end