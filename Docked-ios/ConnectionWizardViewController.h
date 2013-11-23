//
//  ConnectionWizardViewController.h
//  Triage-ios
//
//  Created by Charlie White on 10/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionIntroViewController.h"

@interface ConnectionWizardViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property bool showingWelcomeTour;
@property (strong, nonatomic) ConnectionIntroViewController *introController;
@property (strong, nonatomic) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

- (IBAction)finishConnectionWizard:(id)sender;

@end
