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

@property (strong, nonatomic)  UIButton *connectButton;
@property (strong, nonatomic) UILabel *eventLabel;
@property (nonatomic, strong) UIImageView *providerHeroImageView;
@property (nonatomic, strong) UITableView *eventsTableView;

- (void) layoutSubviews;

@end
