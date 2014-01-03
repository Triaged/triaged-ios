//
//  BitbucketSettingsViewController.h
//  Triage-ios
//
//  Created by Charlie White on 12/12/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSettingsViewController.h"
#import "OAuthViewController.h"

@interface BitbucketSettingsViewController :  BaseSettingsViewController  <OAuthRequestDelegate>

@end
