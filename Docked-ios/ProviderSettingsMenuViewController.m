//
//  SettingsMenuViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ProviderSettingsMenuViewController.h"
#import "ProviderSettingsTableViewController.h"
#import "AppDelegate.h"
#import "Store.h"
#import "CredentialStore.h"
#import "AccountViewController.h"
#import "TeammateCell.h"
#import "Account.h"
#import "UIImageView+AFNetworking.h"
#import "TeamMembersViewController.h"
#import "ConnectionWizardViewController.h"
#import "PKRevealController.h"

@interface ProviderSettingsMenuViewController () {

    UIScrollView *scrollView;
    ProviderSettingsTableViewController *providersTableVC;
    TRButton *connectProviderButton;
    UILabel *settingsLabel;
    //UITableView *accountSettingsTableView;
    UILabel *connectedLabel;
    Account *account;
}
@end

@implementation ProviderSettingsMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = BG_COLOR;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    account = [AppDelegate sharedDelegate].store.account;
    
    self.navigationItem.title = @"Settings";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                   target:self action:@selector(dismissSettingsView)];

    self.navigationItem.leftBarButtonItem = doneButton;
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.frame = self.view.frame;
    [self.view addSubview:scrollView];
    
    // Connected Label
    connectedLabel = [[UILabel alloc] init];
    connectedLabel.frame = CGRectMake(12, 40, 270, 20);
    connectedLabel.font = [UIFont fontWithName:@"Avenir-Book" size:14.0];
    connectedLabel.textColor = [[UIColor alloc] initWithRed:134.0f/255.0f green:139.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
    [scrollView addSubview:connectedLabel];
    
    // Account Button
    
    UIButton *accountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-44, 140, 40)];
    [accountButton setImage:[UIImage imageNamed:@"cog.png"] forState:UIControlStateNormal];
    UIColor *buttonColor = TINT_COLOR;
    [accountButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [accountButton setTitle:@"   Account" forState:UIControlStateNormal];
    accountButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:17.0];
    [accountButton addTarget:self action:@selector(showAccount) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:accountButton];
    
    
    // Connected Providers TableView
    providersTableVC = [[ProviderSettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:providersTableVC];
    CGRect frame = CGRectMake(0, 30, 320, self.view.frame.size.height - 40);
    providersTableVC.tableView.frame = frame;
    UITableView *providersTableView = providersTableVC.tableView;
    [scrollView  addSubview:providersTableView];
    [providersTableVC didMoveToParentViewController:self];
    
    
    providersTableVC.providers = [[AppDelegate sharedDelegate].store.account connectedProviders];
    connectedLabel.text = (providersTableVC.providers.count > 0) ? @"Connected Services" : @"No Services Connected";
    
    
    
//    connectProviderButton = [[TRButton alloc] initWithFrame:CGRectMake(14, 320, 256, 40)];
//    [connectProviderButton setTitle:@"Connect Services" forState:UIControlStateNormal];
//    [connectProviderButton addTarget:self action:@selector(showConnectionWizard) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:connectProviderButton];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self refreshView];
}

-(void)viewDidLayoutSubviews
{
    [providersTableVC refreshTableView];
    [self setContentSize];
}

-(void)refreshView {
    //[accountSettingsTableView reloadData];
    providersTableVC.providers = [[AppDelegate sharedDelegate].store.account connectedProviders];
    [providersTableVC refreshTableView];
    connectedLabel.text = (providersTableVC.providers.count > 0) ? @"Connected Services" : @"No Services Connected";
    [self setContentSize];
}

-(void)setContentSize {
    
    CGFloat providersTableVCHeight = (providersTableVC.tableView.frame.origin.y + providersTableVC.tableView.contentSize.height + 20);
    
    // Set connect button
    CGRect  buttonFrame = CGRectMake(connectProviderButton.frame.origin.x, providersTableVCHeight, connectProviderButton.frame.size.width, connectProviderButton.frame.size.height);
    connectProviderButton.frame = buttonFrame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, buttonFrame.origin.y + buttonFrame.size.height+ 30);
    [self.view sendSubviewToBack:scrollView];
}

- (void) showConnectionWizard
{
    ConnectionWizardViewController *connectionWizard = [[ConnectionWizardViewController alloc] init];
    [self.navigationController presentViewController:connectionWizard animated:YES completion:^ {
        [self refreshView];
    }];
}

-(void)showAccount {
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    TRNavigationController *nav = [[TRNavigationController alloc] initWithRootViewController:accountVC ];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)dismissSettingsView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
