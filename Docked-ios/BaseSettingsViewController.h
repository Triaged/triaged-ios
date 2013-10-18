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

@interface BaseSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Provider *provider;
@property (nonatomic, strong) NSArray *events;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) UILabel *pushLabel;
@property (nonatomic, strong) UIImageView *providerHeroImageView;
@property (strong, nonatomic) UILabel *connectedLabel;
@property (nonatomic, strong) UITableView *eventsTableView;
@property (nonatomic, strong) UIImageView *endLineView;

@property (strong, nonatomic) UIButton *connectButton;
@property (strong, nonatomic) UIButton *followButton;


- (void)layoutSubviews;

- (BOOL)isConnected;
- (BOOL)isFollowing;
- (void)toggleFollow;

-(void)setupConnectedState;
-(void)setupUnconnectedState;

@end
