//
//  SettingsMenuViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "SettingsMenuViewController.h"
#import "ProviderSettingsTableViewController.h"
#import "AppDelegate.h"
#import "Store.h"
#import "CredentialStore.h"
#import "AccountViewController.h"

@interface SettingsMenuViewController ()

@end

@implementation SettingsMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:201.0f/255.0f green:203.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Messages Table View
    ProviderSettingsTableViewController *providersTableVC = [[ProviderSettingsTableViewController alloc] init];
    //commentsVC.delegate = self;
    //providersTableVC.providers =  [[AppDelegate sharedDelegate].store.account.providers allValues];
    [self addChildViewController:providersTableVC];
    CGRect frame = CGRectMake(0, 64, 260, self.view.frame.size.height - 64);
    providersTableVC.tableView.frame = frame;
    [self.view  addSubview:providersTableVC.tableView];
    [providersTableVC didMoveToParentViewController:self];
    
    // Avatar image
    UIImage *avatarIcon = [UIImage imageNamed:@"avatar.png"];
    UIImageView *avatarView = [[UIImageView alloc] initWithImage:avatarIcon];
    avatarView.frame = CGRectMake(15, 500, 30, 30);
    [self.view addSubview: avatarView];
    
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(54, 500, 80, 30)];
    settingsButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:18.0];
    [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(loadAccountView) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setTitle:@"Account" forState:UIControlStateNormal];
    [self.view addSubview:settingsButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadAccountView
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [[AppDelegate sharedDelegate].navVC pushViewController:accountVC animated:NO];
    [revealController setFrontViewController:[AppDelegate sharedDelegate].navVC animated:YES];
}

@end
