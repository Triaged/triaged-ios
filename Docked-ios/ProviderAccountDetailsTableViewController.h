//
//  ProviderAccountDetailsTableViewController.h
//  Triage-ios
//
//  Created by Charlie White on 10/31/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"
#import "MTLProviderAccount.h"

@interface ProviderAccountDetailsTableViewController : UITableViewController

@property (strong, nonatomic) Provider *provider;
@property (strong, nonatomic) NSArray *accountDetails;
@property (strong, nonatomic) NSString *accountDetailsTitle;

@end
