//
//  AppDelegate.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HockeySDK/HockeySDK.h>
#import "UIDebugWindow.h"
#import "GAI.h"

@class Store;
@class PersistentStack;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIDebugWindow *window;
@property (nonatomic, strong) PersistentStack* persistentStack;
@property (nonatomic, strong) Store* store;
@property (strong, nonatomic) UINavigationController *navVC;
@property(nonatomic, strong) id<GAITracker> tracker;

+ (instancetype)sharedDelegate;

@end
