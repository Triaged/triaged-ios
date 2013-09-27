//
//  GithubPush.m
//  Docked-ios
//
//  Created by Charlie White on 9/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GithubPush.h"
#import "TextCardViewController.h"

@implementation GithubPush

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"externalID": @"id",
             @"pusher": @"pusher",
             @"branch": @"branch"
             };
}

+ (NSValueTransformer *)commitsTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GithubCommit class]];
}

-(NSString *)titleLabel {
    return @"Push";
}

-(NSString *)bodyLabel {
    return [NSString stringWithFormat:@" %@ pushed to branch: %@", self.pusher, self.branch];
}

-(Class)detailViewControllerClass {
    return [TextCardViewController class];
}

@end
