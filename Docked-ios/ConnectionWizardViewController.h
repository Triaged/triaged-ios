//
//  ConnectionWizardViewController.h
//  Triage-ios
//
//  Created by Charlie White on 10/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionWizardViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property bool showingWelcomeTour;

@property (strong, nonatomic) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *welcomeTourLabel;



- (IBAction)finishConnectionWizard:(id)sender;

@end
