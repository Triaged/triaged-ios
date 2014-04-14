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

@interface WelcomeViewController () {
    NSTimer *timer;
}

@end

@implementation WelcomeViewController

@synthesize pageController, loginButton, signupButton, scrollView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // buttons
    signupButton.backgroundColor = [[UIColor alloc] initWithRed:121.0f/255.0f green:147.0f/255.0f blue:212.0f/255.0f alpha:1.0f];
    [signupButton.layer setCornerRadius:3.0f];
    [signupButton.layer setMasksToBounds:YES];
    

//  loginButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[WelcomeViewController class], nil];
    pageControl.pageIndicatorTintColor = [[UIColor alloc] initWithRed:233.0f/255.0f green:233.0f/255.0f blue:233.0f/255.0f alpha:1.0f];

    pageControl.currentPageIndicatorTintColor = TINT_COLOR;
    pageControl.backgroundColor = [UIColor clearColor];

    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    self.pageController.view.autoresizingMask = NO;
    [[self.pageController view] setFrame:CGRectMake(0,0,320, 428)];
    
    CardPageViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [scrollView addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    //timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(pageGoto:) userInfo:nil repeats:NO];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    scrollView.contentSize = CGSizeMake(320, loginButton.frame.origin.y + loginButton.frame.size.height);
    scrollView.frame = self.view.frame;
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

//-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
//    
//        CardPageViewController *viewController = [pendingViewControllers firstObject];
//        if (viewController.index == 0) {
//            self.view.backgroundColor = [UIColor whiteColor];
//        } else {
//            self.view.backgroundColor = BG_COLOR;
//        }
//}





- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 5;
}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    // The selected item reflected in the page indicator.
//    return [[self.pageController.viewControllers objectAtIndex:0] index];
//}

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
    
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (IBAction) presentSignupView {
    
    SignupViewController *signupVC = [[SignupViewController alloc] init];
    signupVC.welcomeVC = self;
    [self presentViewController:signupVC animated:YES completion:nil];
}

-(void)dismissAuthScreens:(UIViewController *)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
