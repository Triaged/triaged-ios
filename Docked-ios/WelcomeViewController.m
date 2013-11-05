//
//  WelcomeViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/17/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "WelcomeViewController.h"
#import "CardPageViewController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

@synthesize pageController, loginButton, signupButton;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // buttons
    signupButton.backgroundColor = [[UIColor alloc] initWithRed:140.0f/255.0f green:156.0f/255.0f blue:201.0f/255.0f alpha:1.0f];
    loginButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[WelcomeViewController class], nil];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:76.0f/255.0f green:89.0f/255.0f blue:127.0f/255.0f alpha:1.0f];
    
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:140.0f/255.0f green:156.0f/255.0f blue:201.0f/255.0f alpha:1.0f];
    pageControl.backgroundColor = [UIColor clearColor];

    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:CGRectMake(0,0,320, signupButton.frame.origin.y - 20)];
    
    CardPageViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(CardPageViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(CardPageViewController *)viewController index];
    
    index++;
    
    if (index == 5) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (CardPageViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    CardPageViewController *childViewController = [[CardPageViewController alloc] init];
    childViewController.index = index;
    
    return childViewController;
}

- (void) presentSelfFromVC:(UIViewController *)sender
{
    [UIView transitionFromView:sender.view
                        toView:self.view
                      duration:0.20f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:nil];

}

- (IBAction) presentLoginView {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.welcomeVC = self;
    
    
    [UIView transitionFromView:self.view
                        toView:loginVC.view
                      duration:0.20f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        [self didMoveToParentViewController:loginVC];
                        [self addChildViewController:loginVC];
                    }];
    
    
}

- (IBAction) presentSignupView {
    
    SignupViewController *signupVC = [[SignupViewController alloc] init];
    signupVC.welcomeVC = self;

    [UIView transitionFromView:self.view
                        toView:signupVC.view
                      duration:0.20f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        [self didMoveToParentViewController:signupVC];
                        [self addChildViewController:signupVC];
                    }];
}

-(void)dismissAuthScreens:(UIViewController *)sender
{
    [UIView transitionFromView:sender.view
                        toView:self.view
                      duration:0.20f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:nil];
    
    
    
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}

@end
