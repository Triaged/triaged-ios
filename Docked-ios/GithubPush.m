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
    NSDictionary *jsonKeys = @{
             @"repo": @"repo_name",
             @"pusher": @"pusher",
             @"branch": @"branch",
             @"url": @"url",
             @"commits": @"commits",
             };

    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSValueTransformer *)commitsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GithubCommit class]];
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"github.png"];;
}

-(NSString *)property {
    return _repo;
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
