//
//  TeammateViewController.h
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TeammateFeedTableViewController.h"

@interface TeammateViewController : UIViewController

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) TeammateFeedTableViewController *teammateFeedTableVC;

- (id)initWithUser:(User *)newUser;

@end
