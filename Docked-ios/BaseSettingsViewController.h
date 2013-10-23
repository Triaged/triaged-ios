//
//  BaseSettingsViewController.h
//  Docked-ios
//
//  Created by Charlie White on 10/11/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"
#import "AppDelegate.h"
#import "Store.h"
#import "SVProgressHUD.h"
#import "SettingEventsViewController.h"

@interface BaseSettingsViewController : UIViewController

@property (nonatomic, strong) Provider *provider;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *providerHeroImageView;
@property (strong, nonatomic) UILabel *connectedLabel;
@property (strong, nonatomic) SettingEventsViewController *eventsViewController;
@property (strong, nonatomic) UIButton *connectButton;


- (void)layoutSubviews;

- (BOOL)isConnected;
- (void)toggleFollow;

-(void)setupConnectedState;
-(void)setupUnconnectedState;

@end
