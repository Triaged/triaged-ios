//
//  RootViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "RootViewController.h"
#import "FeedTableViewController.h"
#import "CredentialStore.h"
#import "WelcomeViewController.h"
#import "GithubSettingsViewController.h"
#import "StripeSettingsViewController.h"


@interface RootViewController () {
    SWRevealViewController *revealController;
    FeedTableViewController *feedTableView;
}

@end

@implementation RootViewController

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
    
    self.view.backgroundColor = [[UIColor alloc] initWithRed:239.0f/255.0f green:240.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        for (UIView *view2 in view.subviews) {
            if ([view2 isKindOfClass:[UIImageView class]]) {
                [view2 removeFromSuperview];
            }
        }
    }
    
    [self setupViewControllers];
    [self addSettingsButton];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    // Check for authentication
    if (![[CredentialStore sharedClient] isLoggedIn]) {
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
        [self presentViewController:welcomeVC animated:NO completion:nil];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupViewControllers
{
    revealController = [self revealViewController];
    revealController.rearViewRevealWidth = 220;
    revealController.delegate = self;
    
    feedTableView = [[FeedTableViewController alloc] init];
    feedTableView.view.frame = CGRectMake(8, 0, self.view.frame.size.width - 16, self.view.frame.size.height);
    feedTableView.navController = self.navigationController;


    
    [self addChildViewController:feedTableView];
    [self.view addSubview:feedTableView.view];
    [feedTableView didMoveToParentViewController:self];
    
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}

- (void)addSettingsButton
{
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(toggleSWRevealController)];
    self.navigationItem.leftBarButtonItem = settingsButton;
}




#pragma mark - SWRevealController Interaction

- (void)toggleSWRevealController {
    [self disableFeedTableViewInteraction];
    [revealController revealToggle:self];
}

- (void)revealControllerPanGestureBegan
{
    [self disableFeedTableViewInteraction];
}

- (void)disableFeedTableViewInteraction {
    feedTableView.tableView.userInteractionEnabled = NO;
}

-(void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position {
    if (position == FrontViewPositionLeft) {
        feedTableView.tableView.userInteractionEnabled = YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
