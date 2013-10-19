//
//  SettingEventsViewController.h
//  Docked-ios
//
//  Created by Charlie White on 10/18/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingEventsViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *events;

@property (strong, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) UILabel *pushLabel;
@property (nonatomic, strong) UITableView *eventsTableView;
@property (nonatomic, strong) UIImageView *endLineView;


@end
