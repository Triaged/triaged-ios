//
//  ConnectionWizardViewController.m
//  Triage-ios
//
//  Created by Charlie White on 10/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ConnectionWizardViewController.h"
#import "ConnectionPageViewController.h"

@interface ConnectionWizardViewController ()

@end

@implementation ConnectionWizardViewController

@synthesize pageController, finishButton, showingWelcomeTour, welcomeTourLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[ConnectionWizardViewController class], nil];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:76.0f/255.0f green:89.0f/255.0f blue:127.0f/255.0f alpha:1.0f];
    
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:140.0f/255.0f green:156.0f/255.0f blue:201.0f/255.0f alpha:1.0f];
    pageControl.backgroundColor = [UIColor clearColor];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    [[self.pageController view] setFrame:CGRectMake(0,100,320, self.view.frame.size.height - 110)];
    
    ConnectionPageViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view insertSubview:self.pageController.view belowSubview:finishButton];
//    [self.view addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    if (showingWelcomeTour) {
        finishButton.hidden = YES;
    } else {
        welcomeTourLabel.text = @"Connect Your Services";
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ConnectionPageViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ConnectionPageViewController *)viewController index];
    
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

- (ConnectionPageViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    ConnectionPageViewController *childViewController = [[ConnectionPageViewController alloc] init];
    childViewController.index = index;
    
    return childViewController;
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
    if (showingWelcomeTour) {
        ConnectionPageViewController *viewController = [pendingViewControllers firstObject];
        if (viewController.index == 4) {
            finishButton.hidden = NO;
        } else {
            finishButton.hidden = YES;
        }
    }
    
}

- (IBAction)finishConnectionWizard:(id)sender
{
    bool hasSeenTutorial = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"];

    if (!hasSeenTutorial) {
        // Once we get through all the welcome screens, ask for push notifications
        [[AppDelegate sharedDelegate].store.account welcomeComplete];
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
