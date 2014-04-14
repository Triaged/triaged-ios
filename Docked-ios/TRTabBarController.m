//
//  TRTabBarController.m
//  Triage-ios
//
//  Created by Charlie White on 1/22/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "TRTabBarController.h"
#import "TRNavigationController.h"
#import "FeedTableViewController.h"
#import "ProvidersTableViewController.h"
#import "TeamTableViewController.h"
#import "NotificationsTableViewController.h"
#import "AccountViewController.h"
#import "CredentialStore.h"
#import "WelcomeViewController.h"
#import "RDVTabBarItem.h"
#import "Masonry.h"

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
    
    //self.delegate = self;
    
    // Home
    FeedTableViewController *feedTableView = [[FeedTableViewController alloc] init];
    TRNavigationController *homeNav = [[TRNavigationController alloc] initWithRootViewController:feedTableView];
    UIView *blockade = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    blockade.backgroundColor = [UIColor whiteColor];
    [homeNav.view addSubview:blockade];
    
    // Providers
    ProvidersTableViewController *providerList = [[ProvidersTableViewController alloc] init];
    TRNavigationController *providerNav = [[TRNavigationController alloc] initWithRootViewController:providerList];
    
    
    // Users
    TeamTableViewController *teamList = [[TeamTableViewController alloc] init];
    TRNavigationController *teamNav = [[TRNavigationController alloc] initWithRootViewController:teamList];
    
    
    // Notifications
    NotificationsTableViewController *notificationsList = [[NotificationsTableViewController alloc] init];
    TRNavigationController *notificationsNav = [[TRNavigationController alloc] initWithRootViewController:notificationsList];
    
    
    // Settings
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    TRNavigationController *accountNav = [[TRNavigationController alloc] initWithRootViewController:accountVC];
    
    
    self.tabBar.opaque = NO;
    [self.tabBar setTintColor:[UIColor colorWithRed:165.00f green:171.00f blue:184.00f alpha:1.0f]];
    
    
    [self  setViewControllers:[NSArray arrayWithObjects:homeNav, teamNav, providerNav, notificationsNav, accountNav, nil]];
    
//    
    UIImage *finishedImage = [UIImage imageNamed:@"nav_bg_on"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"nav_bg_off"];
    NSArray *tabBarItemImages = @[@"home", @"team", @"providers", @"inbox", @"account"];
    
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"nav_icon_%@_on",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"nav_icon_%@_off",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
    
    
    
//    [homeNav.view makeConstraints:^(MASConstraintMaker *make) {
//        //UIView *topLayoutGuide = (id)self.topLayoutGuide;
//        make.bottom.equalTo(@300);
//    }];


    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
