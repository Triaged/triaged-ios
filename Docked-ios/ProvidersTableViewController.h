//
//  ProviderSettingsTableViewController.h
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTLProvider.h"

@interface ProvidersTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *providers;

-(void)refreshTableView;

@end
