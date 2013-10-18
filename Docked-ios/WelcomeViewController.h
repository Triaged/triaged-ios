//
//  WelcomeViewController.h
//  Docked-ios
//
//  Created by Charlie White on 10/17/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction) presentSignupView;
- (IBAction) presentLoginView;

-(void) presentFromVC:(UIViewController *)sender;
-(void) dismissAuthScreens:(UIViewController *)sender;

@end
