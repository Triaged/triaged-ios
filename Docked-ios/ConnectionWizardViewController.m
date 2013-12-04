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

@synthesize pageController, finishButton, showingWelcomeTour, introController;

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
    self.view.backgroundColor = BG_COLOR;
    
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[ConnectionWizardViewController class], nil];
    pageControl.pageIndicatorTintColor = [[UIColor alloc] initWithRed:233.0f/255.0f green:233.0f/255.0f blue:233.0f/255.0f alpha:1.0f];
    pageControl.currentPageIndicatorTintColor = TINT_COLOR;
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
    
    if (index == 6) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 6;
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
        if (viewController.index == 5) {
            finishButton.hidden = NO;
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
    if (introController) {
        //[introController dismissViewControllerAnimated:YES completion:nil];
        [introController dismiss];
    } else {
      [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

@end
