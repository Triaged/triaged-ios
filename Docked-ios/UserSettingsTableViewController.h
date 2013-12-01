//
//  UserSettingsTableViewController.h
//  Triage-ios
//
//  Created by Charlie White on 11/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSettingsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *users;

-(void)refreshTableView;

@end
