//
//  SentryException.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "SentryException.h"

@implementation SentryException

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *jsonKeys = @{
       @"project": @"project",
       @"message": @"message",
       @"culprit": @"culprit",
       @"logger": @"logger",
       @"level": @"level"
    };
    
    return [FeedItem JSONKeyPathsWithSuper:jsonKeys];
}

+ (NSString *)managedObjectEntityName {
    return @"SentryException";
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return [FeedItem relationshipModelClassesWith:@{}];
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

-(NSString*)property {
    return [self.project capitalizedString];
}

-(NSString *) action {
    return @"Exception";
}


-(NSString *)body {
    NSString *body = [NSString stringWithFormat:@"%@\n", _message];
    body = [body stringByAppendingString:[NSString stringWithFormat:@"culprit: %@", _culprit]];
    return body;
    
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"airbrake-s.png"];
}

@end
