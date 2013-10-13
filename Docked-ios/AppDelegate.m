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
#import "SettingsMenuViewController.h"
#import "DetailViewController.h"
#import "Mixpanel.h"

#define MIXPANEL_TOKEN @"f1bc2a39131c2de857c04fdf4d236eed"

@interface AppDelegate () 

@property (nonatomic, strong) PersistentStack* persistentStack;

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
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];

    if (remoteNotification != nil) {
        NSString *message = [remoteNotification descriptionWithLocale:nil indent: 1];
        NSLog(@"Message in didFinishLaunchingWithOptions: %@",message);
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.persistentStack = [[PersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    self.store = [[Store alloc] init];
    
    if ([self.store.account isLoggedIn]) {
        [self.store.account resetAPNSPushCount];
    }
    
    [self setBaseStyles];
    [self addObservers];
    
    
    
    RootViewController *rootVC = [[RootViewController alloc] init];
    navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    SettingsMenuViewController *settingsMenuViewController = [[SettingsMenuViewController alloc] init];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:settingsMenuViewController frontViewController:navVC];
    
    [self.window setRootViewController:revealController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void) addObservers
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

- (void) setBaseStyles
{
    self.window.backgroundColor = [[UIColor alloc] initWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    self.window.tintColor = [UIColor whiteColor];//[[UIColor alloc] initWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (Store *)store
{
    if (_store == nil) {
        _store = [Store store];
    }
    return _store;
}

- (NSURL*)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"docked.sqlite"];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"docked" withExtension:@"momd"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.store saveFeedToArchive];
    [self.store saveAccountToArchive];
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"Got device token: %@", [devToken description]);
    [self.store.account updateAPNSPushTokenWithToken:[devToken description]];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"remote notification received");
    NSLog(@"%@", userInfo);
    UIApplicationState state = [application applicationState];
    
    [_store fetchNewRemoteFeedItemsWithBlock:^(NSArray * newFeedItems) {
        if (newFeedItems) {
            // TODO: Route to remote notification
            if (state == UIApplicationStateInactive) {
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"externalID == %@", [userInfo objectForKey:@"external_id"]];
                NSArray *results = [self.store.feedItems filteredArrayUsingPredicate:predicate];
                [self navigateToDetailViewWithFeedItem:[results firstObject]];
                
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

- (void) navigateToDetailViewWithFeedItem:(FeedItem *)item
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [detailVC setFeedItem:item];
    [navVC pushViewController:detailVC animated:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if ([self.store.account isLoggedIn]) {
        [self.store.account resetAPNSPushCount];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if ([self.store.account isLoggedIn]) {
        [self.store.account resetAPNSPushCount];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        [self.store saveFeedToArchive];
        [self.store saveAccountToArchive];
}


@end
