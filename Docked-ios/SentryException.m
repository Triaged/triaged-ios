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
     @"level": @"level",
     @"timestamp": @"timestamp"
    };
}

-(NSString*)property {
    return [self.project capitalizedString];
}

-(NSString *) action {
    return @"exception";
}


-(NSString *)body {
    return self.message;
}

-(UIImage *)providerIcon {
    return [UIImage imageNamed:@"airbrake.png"];
}

@end
