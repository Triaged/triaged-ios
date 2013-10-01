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
    return @{
     @"externalID": @"id",
     @"project": @"project",
     @"message": @"message",
     @"culprit": @"culprit",
     @"logger": @"logger",
     @"level": @"level"
    };
}

-(NSString *) eventName {
    return @"Exception";
}

-(NSString*)titleLabel {
    return [self.project capitalizedString];
}

-(NSString *)bodyLabel {
    return self.message;
}

-(UIImage *)icon {
    UIImage *icon = [UIImage imageNamed:@"airbrake.png"];
    return icon;
}

@end
