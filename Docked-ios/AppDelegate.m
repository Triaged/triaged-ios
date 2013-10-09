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

@interface AppDelegate () 

@property (nonatomic, strong) PersistentStack* persistentStack;

@end

@implementation AppDelegate

@synthesize store = _store;

+ (instancetype)sharedDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];

    if (remoteNotification != nil) {
        NSString *message = [remoteNotification descriptionWithLocale:nil indent: 1];
        NSLog(@"Message in didFinishLaunchingWithOptions: %@",message);
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.persistentStack = [[PersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    self.store = [[Store alloc] init];
    
    [self setBaseStyles];
    [self addObservers];
    
    [Account updateAPNSPushTokenWithToken:@"85006c46 ee195751 4fd9e2b5 4c49c1c8 cfa46cb3 a30d95bf 0daea81e 04507770"];
    
    RootViewController *rootVC = [[RootViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    SettingsMenuViewController *settingsMenuViewController = [[SettingsMenuViewController alloc] init];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:settingsMenuViewController frontViewController:navVC];
    revealController.delegate = self;
    
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
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"Got device token: %@", [devToken description]);
    [Account updateAPNSPushTokenWithToken:[devToken description]];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"remote notification received");
    
    [_store fetchNewRemoteFeedItemsWithBlock:^(NSArray * newFeedItems) {
        if (newFeedItems) {
            // TODO: Route to remote notification
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

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        [self.store saveFeedToArchive];
}


@end
