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
    NSDictionary *jsonKeys = @{
      @"title": @"title",
      @"openedByName": @"opened_by_name",
      @"assignedToName": @"assigned_to_name",
      @"message": @"body",
    };
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSString *)managedObjectEntityName {
    return @"GithubIssueOpened";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{}];
}




-(NSString *)property {
    return @"Docked-ios";
}

-(NSString *)action {
    return [NSString stringWithFormat:@"%@ opened an issue", self.openedByName];
}

-(NSString *)body {
    NSString *bodyText = [NSString stringWithFormat:@"%@:",self.title];
    bodyText = [bodyText stringByAppendingString:[NSString stringWithFormat:@"\n%@", self.message]];
    return bodyText;
}

@end
