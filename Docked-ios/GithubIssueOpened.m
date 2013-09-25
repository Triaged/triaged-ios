//
//  GithubIssueOpened.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GithubIssueOpened.h"
#import "TextCardViewController.h"

@implementation GithubIssueOpened

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
      @"githubIssueOpenedID": @"id",
      @"title": @"title",
      @"openedByName": @"opened_by_name",
      @"AssignedToName": @"assigned_to_name",
      @"body": @"body",
      @"htmlUrl": @"html_url"
    };
}

-(NSString *)titleLabel {
    return @"Issue Opened";
}

-(NSString *)bodyLabel {
    return self.title;
}

-(Class)detailViewControllerClass {
    return [TextCardViewController class];
}

-(UIImage *)icon {
    UIImage *icon = [UIImage imageNamed:@"github.png"];
    return icon;
}

@end
