//
//  GithubIssueOpened.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GithubIssueOpened.h"

@implementation GithubIssueOpened

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
      @"githubIssueOpenedID": @"id",
      @"title": @"title",
      @"openedByName": @"opened_by_name",
      @"AssignedToName": @"assigned_to_name",
      @"body": @"body",
      @"htmlUrl": @"html_url",
      @"timestamp": @"timestamp"
    };
}



-(NSString *)property {
    return @"Docked-ios";
}

-(NSString *)action {
    return @"issue opened";
}

-(NSString *)body {
    return self.title;
}

@end
