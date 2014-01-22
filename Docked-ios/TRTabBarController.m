//
//  TRTabBarController.m
//  Triage-ios
//
//  Created by Charlie White on 1/22/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "TRTabBarController.h"
#import "FeedTableViewController.h"
#import "ProviderSettingsTableViewController.h"
#import "TeamMembersViewController.h"
#import "AccountViewController.h"

@interface TRTabBarController ()

@end

@implementation TRTabBarController

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
    
    self.delegate = self;
    
    // Home
    FeedTableViewController *feedTableView = [[FeedTableViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:feedTableView];
    homeNav.tabBarItem.image = [UIImage imageNamed:@"icn_settings.png"];
    
    // Providers
    ProviderSettingsTableViewController *providerList = [[ProviderSettingsTableViewController alloc] init];
    UINavigationController *providerNav = [[UINavigationController alloc] initWithRootViewController:providerList];
    providerNav.tabBarItem.image = [UIImage imageNamed:@"icn_settings.png"];
    
    // Users
    TeamMembersViewController *teamList = [[TeamMembersViewController alloc] init];
    UINavigationController *teamNav = [[UINavigationController alloc] initWithRootViewController:teamList];
    teamNav.tabBarItem.image = [UIImage imageNamed:@"icn_settings.png"];
    
//    // Notifications
//    FeedTableViewController *feedTableView = [[FeedTableViewController alloc] init];
//    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:feedTableView];
//    homeNav.tabBarItem.image = [UIImage imageNamed:@"icn_settings.png"];
    
    // Settings
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    UINavigationController *accountNav = [[UINavigationController alloc] initWithRootViewController:accountVC];
    accountNav.tabBarItem.image = [UIImage imageNamed:@"icn_settings.png"];
    
    
    self.viewControllers = [NSArray arrayWithObjects:homeNav, providerNav, teamNav, accountNav, nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
