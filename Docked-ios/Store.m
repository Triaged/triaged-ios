//
//  Store.m
//  Docked-ios
//
//  Created by Charlie White on 10/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "Store.h"
#import "MTLAccount.h"
#import "DockedAPIClient.h"
#import "AppDelegate.h"
#import "PersistentStack.h"
#import "ConnectionWizardViewController.h"
#import "CredentialStore.h"
#import "FeedItem.h"

//-com.apple.CoreData.SQLDebug 1

@interface Store ()
    @property (nonatomic,strong) NSString *minID;
@end

@implementation Store

+ (instancetype)store
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        if ([[CredentialStore sharedClient] isLoggedIn]) {
            [self userLoggedIn];
        }

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userLoggedIn)
                                                     name:@"login"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userSignedOut)
                                                     name:@"signout"
                                                   object:nil];
    }
    return self;
}


#pragma mark - Remote Updates

- (void) fetchRemoteUserAccount
{
    [Account currentAccountWithCompletionHandler:^(Account *account, NSError *error) {}];
}

- (Account *)currentAccount {
    return [Account MR_findFirst];
}


#pragma mark - User Authentication

- (void) userLoggedIn
{
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    [Account currentAccountWithCompletionHandler:^(Account *account, NSError *error) {
//        Mixpanel *mixpanel = [Mixpanel sharedInstance];
//        [mixpanel identify:account.identifier];
//        [mixpanel track:@"signup" properties:@{@"id": account.identifier,
//                                               @"email" : account.currentUser.email,
//                                               @"company" : account.companyName}];
        
        //[Intercom beginSessionForUserWithUserId:account.identifier andEmail:account.currentUser.email];
        
    }];

    [FeedItem feedItemsWithCompletionHandler:^(NSArray *feedItems, NSError *error) {}];
    
    
}

- (void) userSignedOut
{
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalNever];
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults removeObjectForKey:@"min_updated_at"];
    [standardDefaults removeObjectForKey:@"companyValidated"];
    [standardDefaults synchronize];
    
    //[Intercom endSession];
    
    //[[AppDelegate sharedDelegate].persistentStack resetPersistentStore];
}


+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    return dateFormatter;
}





@end
