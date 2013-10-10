//
//  AppDelegate.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@class Store;
@class PersistentStack;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Store* store;
@property (strong, nonatomic) UINavigationController *navVC;

+ (instancetype)sharedDelegate;

@end
