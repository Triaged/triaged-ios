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

@synthesize scrollView, providerHeroImageView, connectButton, connectedLabel, eventsViewController, providerAccountTableVC, accountProperties, emailInstructionsButton, provider,
    accountDetailsTitle, instructionsLabel, oAuthController, instructionsText, serviceUrlLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        eventsViewController = [[SettingEventsViewController alloc] init];
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSettingsView)];
    [self.navigationItem setLeftBarButtonItem:doneButton];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    self.view.backgroundColor = BG_COLOR;
    
    self.providerHeroImageView = [[UIImageView alloc] init];
    self.providerHeroImageView.frame = CGRectMake(45, 0, 230, 125);
    [scrollView addSubview:self.providerHeroImageView];
    
    // Connect Button
    connectButton = [[TRButton alloc] init];
    connectButton.frame = CGRectMake(40, 115, 240, 38);
    [connectButton addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
//    // Ignore Button
//    ignoreButton = [[TRButton alloc] init];
//    ignoreButton.frame = CGRectMake(60, 125, 200, 38);
//    [ignoreButton addTarget:self action:@selector(toggleIgnore) forControlEvents:UIControlEventTouchUpInside];
    
    
    //[self follows] ? [self setIgnoreButtonToIgnore] : [self setIgnoreButtonToFollow];
    
    
    // Email Instructions
    emailInstructionsButton = [[TRButton alloc] init];
    [emailInstructionsButton setTitle:@"Email Me Directions" forState:UIControlStateNormal];
    [emailInstructionsButton addTarget:self action:@selector(emailProviderConnectInstructions) forControlEvents:UIControlEventTouchUpInside];
    
    // Provider Account
    providerAccountTableVC.tableView.scrollEnabled = NO;
    
}

-(void)setupConnectedState
{
    // remove views
    [connectButton removeFromSuperview];
    
    [self.navigationItem setTitle:@"Connected"];
    
    NSString *ignoreTitle = [self follows] ? @"Ignore" : @"Follow";
    UIBarButtonItem *ignoreButton = [[UIBarButtonItem alloc] initWithTitle:ignoreTitle style:UIBarButtonItemStylePlain target:self action:@selector(toggleIgnore)];
                                   
    [self.navigationItem setRightBarButtonItem:ignoreButton];
    
    if (oAuthController) {
        self.providerAccountTableVC = [[ProviderAccountTableViewDataSource alloc] init];
        //self.providerAccountTableVC.accountText = self.provider.account.name;
        UITableView *accountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 100) style:UITableViewStyleGrouped];
        accountTableView.scrollEnabled = NO;
        accountTableView.bounces = NO;
        accountTableView.backgroundColor = [UIColor clearColor];
        accountTableView.sectionFooterHeight = 1;
        accountTableView.sectionHeaderHeight = 1;
        accountTableView.delegate = self;
        accountTableView.dataSource = self.providerAccountTableVC;
        
        //self.accountProperties  = self.provider.account.properties;
        //self.accountDetailsTitle = self.provider.account.propertyLabel;
        [self.scrollView addSubview:accountTableView];
    }
}

-(void)setupUnconnectedState
{
    [self.navigationItem setTitle:@"Connect Your Account"];
    
    if (!oAuthController) {
        // Instructions
        instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 120, 240, 40)];
        [instructionsLabel setText:instructionsText ];
        [instructionsLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:15.0]];
        instructionsLabel.textColor = [[UIColor alloc] initWithRed:89.0f/255.0f green:96.0f/255.0f blue:115.0f/255.0f alpha:1.0f];
        instructionsLabel.numberOfLines = 0;
        instructionsLabel.textAlignment = NSTextAlignmentCenter;
        [instructionsLabel sizeToFit];
        [self.scrollView addSubview:instructionsLabel];
        
        // Service URL
        serviceUrlLabel = [[HTCopyableLabel alloc] initWithFrame:CGRectMake(20, 185, 280, 20)];
        [serviceUrlLabel setText:provider.webhookUrl];
        [serviceUrlLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
        [serviceUrlLabel setTextAlignment:NSTextAlignmentCenter];
        serviceUrlLabel.textColor = TINT_COLOR;
        [self.scrollView addSubview:serviceUrlLabel];
        
        self.emailInstructionsButton.frame = CGRectMake(60, 220, 200, 40);
        [self.scrollView addSubview:self.emailInstructionsButton];
    }
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
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    scrollView.frame = frame;
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
    //[provider emailConnectInstructions];
}

- (void) toggleIgnore
{
    if ([self isFollowing]) {
       // [self.provider ignore];
        //[self setIgnoreButtonToFollow];
        self.navigationItem.rightBarButtonItem.title = @"Follow";
    } else {
        //[self.provider follow];
        self.navigationItem.rightBarButtonItem.title = @"Ignore";
        //[self setIgnoreButtonToIgnore];
    }
    //[ignoreButton setNeedsDisplay];
    [self.navigationController showSGProgressWithDuration:1.5];

    
//    [ignoreButton setBackgroundColor:[[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f]];
}

- (BOOL) isFollowing;
{
    return self.provider.follows;
}

//- (void)setIgnoreButtonToFollow
//{
//    [ignoreButton setTitle:@"Follow" forState:UIControlStateNormal];
//    [ignoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [ignoreButton setBackgroundColor:
//    [UIColor colorWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f]];
//    
//}
//
//- (void)setIgnoreButtonToIgnore
//{
//    [ignoreButton setTitle:@"Unfollow" forState:UIControlStateNormal];
//    [ignoreButton setTitleColor:[[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//    [ignoreButton setBackgroundColor:[UIColor whiteColor]];
//    
//}



-(void) dismissSettingsView
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

// Details View Controller
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProviderAccountDetailsTableViewController *detailsVC = [[ProviderAccountDetailsTableViewController alloc] init];
    detailsVC.provider = provider;
    detailsVC.accountDetails = accountProperties;
    detailsVC.accountDetailsTitle = accountDetailsTitle;
    
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}


@end
