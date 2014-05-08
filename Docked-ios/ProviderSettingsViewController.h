//
//  ProviderSettingsViewController.h
//  Docked-ios
//
//

#import <UIKit/UIKit.h>
#import "BaseSettingsViewController.h"
#import "OAuthViewController.h"

@interface ProviderSettingsViewController : BaseSettingsViewController <OAuthRequestDelegate>

@end
