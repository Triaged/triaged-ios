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
                   @"branch": @"branch",
                   @"repoUrl": @"repo_url",
                   @"commits": @"commits"
                   };
    
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSString *)managedObjectEntityName {
    return @"KilnPush";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{@"commits" : KilnCommit.class}];
}


+ (NSValueTransformer *)commitsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[KilnCommit class]];
}

-(NSString*)property {
    return [self.repoName capitalizedString];
}

-(NSString *) action {
    return [NSString stringWithFormat:@"%@ pushed to %@", self.pusher, self.branch];
}

-(NSString *)body {
    NSString *body = @"";
    for (KilnCommit *commit in _commits) {
        body = [body stringByAppendingString:[NSString stringWithFormat:@"- %@\n", commit.message]];
    }
    
    return body;
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"kiln-s.png"];
}

@end
