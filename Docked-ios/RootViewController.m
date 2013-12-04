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
#import "FeedBackgroundViewController.h"



@interface RootViewController () <PKRevealing> {
    FeedBackgroundViewController *feedVC;
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

    [self setupViewControllers];
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
        // Show validate company first
        if (needsValidation)
            if (!account.validatedCompany) [self displayCompanyValidation];// Show Validated Company
        if (shouldSeeTutorial) [self displayConnectionIntro];
    }
}

-(void) displayConnectionIntro {
    ConnectionWizardViewController *connectionWizardVC = [[ConnectionWizardViewController alloc] init];
    connectionWizardVC.showingWelcomeTour = YES;
    [self presentViewController:connectionWizardVC animated:NO completion:nil];
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
//    feedVC = [[FeedTableViewController alloc] init];
//    feedVC.navController = self.navigationController;
    
    feedVC = [[FeedBackgroundViewController alloc] init];
    feedVC.feedTableView.navController = self.navigationController;
    
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:feedVC leftViewController:providerSettingsVC rightViewController:userSettingsVC];
    
    [revealController setMinimumWidth:280.0 maximumWidth:310.0 forViewController:providerSettingsVC];
    [revealController setMinimumWidth:280.0 maximumWidth:310.0 forViewController:userSettingsVC];
    [self.revealController enterPresentationModeAnimated:YES completion:nil];
    self.revealController.disablesFrontViewInteraction = YES;
    self.revealController.view.backgroundColor = BG_COLOR;
    revealController.delegate = self;
    
    [self addChildViewController:revealController];
    [self.view addSubview:revealController.view];
    [revealController didMoveToParentViewController:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
