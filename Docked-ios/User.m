//
//  User.m
//  Triage-ios
//
//  Created by Charlie White on 10/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "User.h"
#import "Message.h"


@implementation User

@dynamic avatarUrl;
@dynamic email;
@dynamic name;
@dynamic slug;
@dynamic userID;
@dynamic authoredMessages;

- (NSString *)autocompleteString
{
    return [self.slug capitalizedString];
}

@end
