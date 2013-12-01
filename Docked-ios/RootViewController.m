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
#import "ProviderSettingsMenuViewController.h"
#import "ConnectionWizardViewController.h"
#import "ConnectionIntroViewController.h"
#import "VerifyViewController.h"
#import "PKRevealController.h"
#import "UserSettingsMenuViewController.h"


@interface RootViewController () <PKRevealing> {
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
    
    self.view.backgroundColor = BG_COLOR;

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
    
    ProviderSettingsMenuViewController *providerSettingsVC = [[ProviderSettingsMenuViewController alloc] init];
    UserSettingsMenuViewController *userSettingsVC = [[UserSettingsMenuViewController alloc] init];

    
    feedTableView = [[FeedTableViewController alloc] init];
    feedTableView.navController = self.navigationController;
    feedTableView.rootController = self;
    
//    [self addChildViewController:feedTableView];
//    [self.view addSubview:feedTableView.view];
//    
//    //[self followScrollView:feedTableView.tableView];
//    [feedTableView didMoveToParentViewController:self];
    
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:feedTableView leftViewController:providerSettingsVC rightViewController:userSettingsVC];
    
    //[PKRevealController revealControllerWithFrontViewController:feedTableView providerSettingsVC:settingsVC];
    [revealController setMinimumWidth:280.0 maximumWidth:310.0 forViewController:providerSettingsVC];
    [revealController setMinimumWidth:280.0 maximumWidth:310.0 forViewController:userSettingsVC];
    [self.revealController enterPresentationModeAnimated:YES completion:nil];
    self.revealController.disablesFrontViewInteraction = YES;
    revealController.delegate = self;
    //revealController.quickSwipeVelocity = 1000;
    
    
    [self addChildViewController:revealController];
    [self.view addSubview:revealController.view];
    [revealController didMoveToParentViewController:self];
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
    ProviderSettingsMenuViewController *settingsVC = [[ProviderSettingsMenuViewController alloc] init];
    TRNavigationViewController *nav = [[TRNavigationViewController alloc] initWithRootViewController:settingsVC];
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
