//
//  BaseSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/11/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "BaseSettingsViewController.h"
#import "EventCell.h"
#import "AppDelegate.h"
#import "UINavigationController+SGProgress.h"
#import "ProviderAccountDetailsTableViewController.h"

@interface BaseSettingsViewController ()

@end

@implementation BaseSettingsViewController

@synthesize scrollView, providerHeroImageView, connectButton, connectedLabel, eventsViewController, providerAccountTableVC, ignoreButton, accountProperties, emailInstructionsButton, provider,
    accountDetailsTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        eventsViewController = [[SettingEventsViewController alloc] init];
        providerAccountTableVC = [[ProviderAccountTableViewController alloc] init];
        providerAccountTableVC.tableView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.providerHeroImageView = [[UIImageView alloc] init];
    self.providerHeroImageView.frame = CGRectMake(45, 0, 230, 125);
    [scrollView addSubview:self.providerHeroImageView];
    
    // Connect Button
    connectButton = [[UIButton alloc] init];
    connectButton.frame = CGRectMake(24, 115, 272, 38);
    connectButton.layer.cornerRadius = 6; // this value vary as per your desire
    connectButton.clipsToBounds = YES;
    [connectButton addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
    // Ignore Button
    ignoreButton = [[UIButton alloc] init];
    ignoreButton.frame = CGRectMake(60, 125, 200, 38);
    ignoreButton.clipsToBounds = YES;
    [ignoreButton.layer setCornerRadius:20.0f];
    [ignoreButton.layer setMasksToBounds:YES];
    [ignoreButton.layer setBorderWidth:1.0f];
    ignoreButton.layer.borderColor = [[[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    [ignoreButton addTarget:self action:@selector(toggleIgnore) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self follows] ? [self setIgnoreButtonToIgnore] : [self setIgnoreButtonToFollow];
    
    
    // Email Instructions
    emailInstructionsButton = [[UIButton alloc] init];
    [emailInstructionsButton.layer setCornerRadius:20.0f];
    [emailInstructionsButton.layer setMasksToBounds:YES];
    [emailInstructionsButton.layer setBorderWidth:1.0f];
    emailInstructionsButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    emailInstructionsButton.clipsToBounds = YES;
    emailInstructionsButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    [emailInstructionsButton setTitle:@"Email These Directions" forState:UIControlStateNormal];
    [emailInstructionsButton addTarget:self action:@selector(emailProviderConnectInstructions) forControlEvents:UIControlEventTouchUpInside];
    
    // Provider Account
    providerAccountTableVC.tableView.scrollEnabled = NO;
    
    // Connected State
    ([self isConnected] ?  [self setupConnectedState] : [self setupUnconnectedState]);

    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.navigationController.navigationBar.backItem == NULL) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSettingsView)];
        [self.navigationItem setLeftBarButtonItem:doneButton];
    }
}

-(void)setupConnectedState
{
    // remove views
    [connectButton removeFromSuperview];
    
    UIImage *connectedStatusImage = [UIImage imageNamed:@"status_connected.png"];
    UIImageView *connectedStatusView = [[UIImageView alloc] initWithImage:connectedStatusImage];
    connectedStatusView.frame = CGRectMake(118, 100, 8, 8);
    [scrollView addSubview:connectedStatusView];
    
    connectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(127.5, 94, 65, 20)];
    [connectedLabel setText:@"Connected"];
    [connectedLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:13.0]];
    connectedLabel.textColor = [[UIColor alloc] initWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
    [scrollView addSubview:connectedLabel];
    
    [scrollView addSubview:ignoreButton];
    
    
}

-(void)setupUnconnectedState
{
    
}

- (void) viewWillLayoutSubviews
{
    [self setContentSize];
}

- (void) viewDidLayoutSubviews
{
    [self setContentSize];
}

-(void)setContentSize {
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, eventsViewController.view.frame.origin.y + eventsViewController.eventsTableView.frame.size.height + 50);
    scrollView.frame = self.view.frame;
}

- (BOOL) follows
{
    return self.provider.follows;
}

- (BOOL) isConnected
{
    return self.provider.connected;
}

- (void) emailProviderConnectInstructions
{
    [self.navigationController showSGProgressWithDuration:1.5];
    [emailInstructionsButton setTitle:@"Emailed" forState:UIControlStateNormal];
    [provider emailConnectInstructions];
}

- (void) toggleIgnore
{
    if ([self isFollowing]) {
        [self.provider ignore];
        [self setIgnoreButtonToFollow];
    } else {
        [self.provider follow];
        [self setIgnoreButtonToIgnore];
    }
    [ignoreButton setNeedsDisplay];
    [self.navigationController showSGProgressWithDuration:1.5];

    
//    [ignoreButton setBackgroundColor:[[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f]];
}

- (BOOL) isFollowing;
{
    return self.provider.follows;
}

- (void)setIgnoreButtonToFollow
{
    [ignoreButton setTitle:@"Follow" forState:UIControlStateNormal];
    [ignoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ignoreButton setBackgroundColor:
    [UIColor colorWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f]];
    
}

- (void)setIgnoreButtonToIgnore
{
    [ignoreButton setTitle:@"Unfollow" forState:UIControlStateNormal];
    [ignoreButton setTitleColor:[[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [ignoreButton setBackgroundColor:[UIColor whiteColor]];
    
}



-(void) dismissSettingsView
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

// Details View Controller
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProviderAccountDetailsTableViewController *detailsVC = [[ProviderAccountDetailsTableViewController alloc] init];
    detailsVC.provider = provider;
    detailsVC.accountDetails = accountProperties;
    detailsVC.accountDetailsTitle = accountDetailsTitle;
    
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}


@end
