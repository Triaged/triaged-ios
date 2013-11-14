//
//  FeedTableViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface FeedTableViewController : UITableViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) RootViewController *rootController;
@end
