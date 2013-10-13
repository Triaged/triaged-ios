//
//  KilnPush.m
//  Docked-ios
//
//  Created by Charlie White on 10/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "KilnPush.h"

@implementation KilnPush

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"repoName": @"repo_name",
                               @"pusher": @"pusher",
                               @"repoUrl": @"repo_url"
                               };
    
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

-(NSString*)property {
    return [self.repoName capitalizedString];
}

-(NSString *) action {
    return [NSString stringWithFormat:@"%@ pushed", self.pusher];
}


-(NSString *)body {
    return @"body";
    
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"heroku.png"];
}

@end
