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
#import "SettingsMenuViewController.h"
#import "ConnectionWizardViewController.h"


@interface RootViewController () {
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
    } else {
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"])
            [self displayConnectionWizard];
    }
    
    
}

-(void) displayConnectionWizard
{
    ConnectionWizardViewController *connectionWizardVC = [[ConnectionWizardViewController alloc] init];
    connectionWizardVC.showingWelcomeTour = YES;
    [self presentViewController:connectionWizardVC animated:NO completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupViewControllers
{
    feedTableView = [[FeedTableViewController alloc] init];
    feedTableView.view.frame = CGRectMake(8, 0, self.view.frame.size.width - 16, self.view.frame.size.height);
    feedTableView.navController = self.navigationController;

    [self addChildViewController:feedTableView];
    [self.view addSubview:feedTableView.view];
    [feedTableView didMoveToParentViewController:self];
}

- (void)addSettingsButton
{
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cog.png"] style:UIBarButtonItemStyleDone target:self action:@selector(presentSettingsView)];
    self.navigationItem.leftBarButtonItem = settingsButton;
}

- (void)presentSettingsView
{
    SettingsMenuViewController *settingsVC = [[SettingsMenuViewController alloc] init];
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    
    for (UIView *view in nav.navigationBar.subviews) {
        for (UIView *view2 in view.subviews) {
            if ([view2 isKindOfClass:[UIImageView class]]) {
                [view2 removeFromSuperview];
            }
        }
    }
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
