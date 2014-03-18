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
#import "ConnectionWizardViewController.h"
#import "ConnectionIntroViewController.h"
#import "VerifyViewController.h"
#import "PKRevealController.h"



@interface RootViewController () <PKRevealing> {
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
//    MTLAccount *account = [AppDelegate sharedDelegate].store.account;
//    bool shouldSeeTutorial = ![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"];
//    bool needsValidation = ![[NSUserDefaults standardUserDefaults] boolForKey:@"companyValidated"];
//    
//    if (account.personalAccount) {
//        if (shouldSeeTutorial) [self displayConnectionIntro];
//    } else {
//        // Show validate company first
//        if (needsValidation)
//            if (!account.validatedCompany) [self displayCompanyValidation];// Show Validated Company
//        if (shouldSeeTutorial) [self displayConnectionIntro];
//    }
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
    
    
    //UserSettingsMenuViewController *userSettingsVC = [[UserSettingsMenuViewController alloc] init];
//    feedVC = [[FeedTableViewController alloc] init];
//    feedVC.navController = self.navigationController;
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
