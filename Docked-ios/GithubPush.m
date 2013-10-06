//
//  GithubPush.m
//  Docked-ios
//
//  Created by Charlie White on 9/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GithubPush.h"
#import "TextCardCell.h"

@implementation GithubPush

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"externalID": @"id",
             @"pusher": @"pusher",
             @"branch": @"branch",
             @"url": @"url",
             @"commits": @"commits",
             @"htmlUrl": @"html_url",
             @"messages": @"messages",
             @"timestamp": @"timestamp"
             };
}

+ (NSValueTransformer *)commitsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GithubCommit class]];
}



-(NSString *)property {
    return @"Github-ios";
}

-(NSString *)action {
   return [NSString stringWithFormat:@"%@ pushed to %@", self.pusher, self.branch];
}

-(NSString *)body {
    NSString *body = @"";
    for (GithubCommit *commit in _commits) {
        body = [body stringByAppendingString:[NSString stringWithFormat:@"- %@\n", commit.message]];
    }
    
    return body;
}

-(NSString *)externalLinkUrl {
    return self.url;
}



@end
