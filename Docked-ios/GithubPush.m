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
             @"url": @"url"
             };
}

//+ (NSValueTransformer *)commitsJSONTransformer
//{
//    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GithubCommit class]];
//}






-(NSString *)titleLabel {
    return @"Github-ios";
}

-(NSString *)bodyLabel {
    return [NSString stringWithFormat:@"%@ pushed to %@", self.pusher, self.branch];
}

-(NSString *)externalLinkUrl {
    return self.url;
}



@end
