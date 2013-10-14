//
//  HerokuDeploy.m
//  Docked-ios
//
//  Created by Charlie White on 10/12/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "HerokuDeploy.h"

@implementation HerokuDeploy

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
                               @"app": @"app",
                               @"gitLog": @"git_log",
                               @"user": @"user"
                               };
    
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

-(NSString*)property {
    return [self.app capitalizedString];
}

-(NSString *) action {
    return [NSString stringWithFormat:@"Deploy by %@", self.user];
}


-(NSString *)body {
    NSString *body = @"";
    body = [body stringByAppendingString:_gitLog];
    return body;
    
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"heroku-s.png"];
}


@end
