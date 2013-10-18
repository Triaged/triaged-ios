//
//  BaseSettingsViewController.h
//  Docked-ios
//
//  Created by Charlie White on 10/11/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"

@interface BaseSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Provider *provider;
@property (nonatomic, strong) NSArray *events;

@property (strong, nonatomic) UILabel *eventLabel;
@property (nonatomic, strong) UIImageView *providerHeroImageView;
@property (strong, nonatomic) UILabel *connectedLabel;
@property (nonatomic, strong) UITableView *eventsTableView;

@property (strong, nonatomic) UIButton *connectButton;
@property (strong, nonatomic) UIButton *followButton;


- (void)layoutSubviews;

- (BOOL)isConnected;
- (BOOL)isFollowing;
- (void)connect;
- (void)toggleFollow;

-(void)setupConnectedState;
-(void)setupUnconnectedState;

@end
