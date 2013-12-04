//
//  AppDelegate.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "AppDelegate.h"
#import "Store.h"
#import "Account.h"
#import "PersistentStack.h"
#import "RootViewController.h"
#import "ProviderSettingsMenuViewController.h"
#import "DetailViewController.h"
#import "WelcomeViewController.h"
#import "CredentialStore.h"
#import <Appsee/Appsee.h>
#import <Crashlytics/Crashlytics.h>
#import "TestFlight.h"

// STAGING
//#define MIXPANEL_TOKEN @"f1bc2a39131c2de857c04fdf4d236eed"
//#define APPSEE_TOKEN @"ec4d1216d3464c1f8dd7882242876d4d"
#define HOCKEYAPP_TOKEN @"75134b3efefcd10ce90e4509d3a10431"
#define CRASHLYTICS_TOKEN @"2776a41715c04dde4ba5d15b716b66a51e353b0f"
#define TESTFLIGHT_TOKEN @"1b63c684-3adc-480d-8ccd-02f09186e10c"

// RELEASE
#define MIXPANEL_TOKEN @"392cf507394a7b630ad9e6b878003f3d"
#define APPSEE_TOKEN @"13389247ea0b457e837f7aec5d80acb8"


@interface AppDelegate () 

@end

@implementation AppDelegate

@synthesize store = _store;
@synthesize navVC;

+ (instancetype)sharedDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hasSeenTutorial"];
    //[[CredentialStore sharedClient] clearSavedCredentials];
    
    [self setAnalytics];
    
    self.persistentStack = [[PersistentStack alloc] init];
    self.store = [[Store alloc] init];
    self.store.managedObjectContext = self.persistentStack.managedObjectContext;
    
    [self setWindowAndRootVC];
    [self setBaseStyles];
    [self addObservers];
    [self setupLoggedInUser];
    
    
    
    
    return YES;
}

- (void) addObservers
{

}

- (void)setWindowAndRootVC {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RootViewController *rootVC = [[RootViewController alloc] init];
    navVC = [[TRNavigationController alloc] initWithRootViewController:rootVC];
    
    [self.window setRootViewController:navVC];
    [self.window makeKeyAndVisible];
}

- (void) setBaseStyles
{
    self.window.backgroundColor = BG_COLOR;
    self.window.tintColor = TINT_COLOR;
    
    UIColor *tint = [[UIColor alloc] initWithRed:38.0f/255.0f green:40.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Avenir-Medium" size:16], NSFontAttributeName, tint,NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    UIColor *buttonTint = TINT_COLOR;
    NSDictionary *buttonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"Avenir-Medium" size:16], NSFontAttributeName, buttonTint,NSForegroundColorAttributeName, nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:buttonAttributes forState:UIControlStateNormal];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void) setAnalytics {
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    
    [TestFlight takeOff:TESTFLIGHT_TOKEN];
    
    
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:HOCKEYAPP_TOKEN delegate:self];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [Appsee start:APPSEE_TOKEN];
    
    [Crashlytics startWithAPIKey:CRASHLYTICS_TOKEN];
    
    [Intercom setApiKey:@"ios-470c22eb9b8bc927db5c6c2c9721988cba08022c" forAppId:@"254713b22c6841aa49aa91b356f3ac288bfa14b1"];
    
}

- (void)setupLoggedInUser
{
    if ([self.store.account isLoggedIn]) {
        if([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            [self.store.account resetAPNSPushCount];
            [self.store readAccountArchive];
            [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
        }
    }
}

- (Store *)store
{
    if (_store == nil) {
        _store = [Store store];
    }
    return _store;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.store saveAccountToArchive];
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSString * deviceToken = [[devToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // @TODO: Optimize this:
    [self.store.account updateAPNSPushTokenWithToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    UIApplicationState state = [application applicationState];
    
    [_store fetchNewRemoteFeedItemsWithBlock:^(NSArray * newFeedItems) {
        if (newFeedItems) {
            if (state == UIApplicationStateInactive) {
                [self navigateToDetailViewWithFeedItem:[userInfo objectForKey:@"external_id"]];
            }
            completionHandler(UIBackgroundFetchResultNewData);
        } else {
            completionHandler(UIBackgroundFetchResultNoData);
        }
    }];
    completionHandler(UIBackgroundFetchResultFailed);
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [_store fetchNewRemoteFeedItemsWithBlock:^(NSArray * newFeedItems) {
        if (newFeedItems) {
            completionHandler(UIBackgroundFetchResultNewData);
        } else {
            completionHandler(UIBackgroundFetchResultNoData);
        }
    }];
    completionHandler(UIBackgroundFetchResultFailed);
}

- (void) navigateToDetailViewWithFeedItem:(NSString *)externalID
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"FeedItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"externalID = %@", externalID];
    NSArray * fetchedObjects = [self.store.managedObjectContext executeFetchRequest:request error:nil];
   
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [detailVC setFeedItem:[fetchedObjects firstObject]];
    [navVC pushViewController:detailVC animated:NO];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[url scheme] isEqualToString:@"triage"]) {

        NSString *token = [url query];
        if ([token isEqual:self.store.account.validationToken]) {
            [self.store.account setValidated];
        }
        
        
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"App Open" properties:@{}];
    [self setupLoggedInUser];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self setupLoggedInUser];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.store saveAccountToArchive];
    
    NSError *error = nil;
    [self.store.managedObjectContext save:&error];
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

@end
