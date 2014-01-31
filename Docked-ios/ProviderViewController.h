//
//  ProviderViewController.h
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"
#import "ProviderFeedTableViewController.h"

@interface ProviderViewController : UIViewController

@property (nonatomic, retain) Provider *provider;
@property (nonatomic, retain) ProviderFeedTableViewController *providerFeedTableVC;

- (id)initWithProvider:(Provider *)newProvider;


@end
