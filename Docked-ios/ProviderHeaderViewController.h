//
//  ProviderHeaderViewController.h
//  Triage-ios
//
//  Created by Charlie White on 3/3/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"

@interface ProviderHeaderViewController : UIViewController

@property (weak, nonatomic) Provider *provider;
@property (weak, nonatomic) IBOutlet UIImageView *providerIconView;
@property (weak, nonatomic) IBOutlet UILabel *providerNameLabel;

@end
