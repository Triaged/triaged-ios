//
//  Account.m
//  Triage-ios
//
//  Created by Charlie White on 2/10/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "Account.h"
#import "User.h"
#import "SLRESTfulCoreData.h"


@implementation Account

@dynamic apiToken;
@dynamic followedProvidersCount;
@dynamic identifier;
@dynamic personalAccount;
@dynamic pushEnabled;
@dynamic validatedCompany;
@dynamic validationToken;
@dynamic currentUser;
@dynamic teammates;
@dynamic companyName;
@dynamic providers;


+ (void)currentAccountWithCompletionHandler:(void(^)(Account *account, NSError *error))completionHandler {
    NSURL *URL = [NSURL URLWithString:@"account.json"];
    [self fetchObjectFromURL:URL completionHandler:completionHandler];
}


@end
