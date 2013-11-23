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
#import "ConnectionIntroViewController.h"
#import "VerifyViewController.h"


@interface RootViewController () {
    FeedTableViewController *feedTableView;
    ConnectionIntroViewController *connectionIntroVC;
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
//    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    
    
    
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
        [self shouldShowWelcomeScreens];
    }
}

-(void) shouldShowWelcomeScreens
{
    Account *account = [AppDelegate sharedDelegate].store.account;
    bool shouldSeeTutorial = ![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"];
    bool needsValidation = ![[NSUserDefaults standardUserDefaults] boolForKey:@"companyValidated"];
    
    if (account.personalAccount) {
        if (shouldSeeTutorial) [self displayConnectionIntro];
    } else {
        if (account.connectedProviderCount == 0) {
            // Show connection Wizard first
            if (shouldSeeTutorial) [self displayConnectionIntro];
            if (needsValidation)
                if (!account.validatedCompany) [self displayCompanyValidation]; // Show validation screen
        } else {
            // Show validate company first
            if (needsValidation)
                if (!account.validatedCompany) [self displayCompanyValidation];// Show Validated Company
            if (shouldSeeTutorial) [self displayConnectionIntro];
        }
    }
}

-(void) displayConnectionIntro {
    connectionIntroVC = [[ConnectionIntroViewController alloc] init];
    connectionIntroVC.rootController = self;
    [self presentViewController:connectionIntroVC animated:NO completion:nil];
}

-(void) displayCompanyValidation
{
    VerifyViewController *verifyVC = [[VerifyViewController alloc] init];
    [self presentViewController:verifyVC animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupViewControllers
{
    feedTableView = [[FeedTableViewController alloc] init];
    feedTableView.view.frame = self.view.frame;//CGRectMake(8, 0, self.view.frame.size.width - 16, self.view.frame.size.height);
    feedTableView.navController = self.navigationController;
    feedTableView.rootController = self;

    [self addChildViewController:feedTableView];
    [self.view addSubview:feedTableView.view];
    [feedTableView didMoveToParentViewController:self];
}

- (void)addSettingsButton
{

    UIImage *menuImage = [UIImage imageNamed:@"menu-1.png"];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:menuImage style:UIBarButtonItemStyleDone target:self action:@selector(presentSettingsView)];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    UIImage *logoImage = [[UIImage imageNamed:@"logo_navbar.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    self.navigationItem.titleView = logoImageView;
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
