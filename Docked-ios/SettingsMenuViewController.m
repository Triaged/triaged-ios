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
#import "TeammateCell.h"
#import "Account.h"
#import "UIImageView+AFNetworking.h"
#import "TeamMembersViewController.h"
#import "ConnectionWizardViewController.h"

@interface SettingsMenuViewController () {

    UIScrollView *scrollView;
    ProviderSettingsTableViewController *providersTableVC;
    UIButton *connectProviderButton;
    UILabel *settingsLabel;
    UITableView *accountSettingsTableView;
    Account *account;
}
@end

@implementation SettingsMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
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
    UILabel *connectedLabel = [[UILabel alloc] init];
    connectedLabel.frame = CGRectMake(10, 20, 320, 20);
    connectedLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0];
    connectedLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [scrollView addSubview:connectedLabel];
    
    
    // Connected Providers TableView
    providersTableVC = [[ProviderSettingsTableViewController alloc] init];
    [self addChildViewController:providersTableVC];
    CGRect frame = CGRectMake(0, 40, 320, self.view.frame.size.height - 40);
    providersTableVC.tableView.frame = frame;
    UITableView *providersTableView = providersTableVC.tableView;
    [scrollView  addSubview:providersTableView];
    [providersTableVC didMoveToParentViewController:self];
    
    
    providersTableVC.providers = [[AppDelegate sharedDelegate].store.account connectedProviders];
    connectedLabel.text = (providersTableVC.providers.count > 0) ? @"Connected Services" : @"No Services Connected";
    
    
    
    connectProviderButton = [[UIButton alloc] init];
    connectProviderButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
     connectProviderButton.frame = CGRectMake(40, 300, 240, 40);
    [connectProviderButton setTitle:@"Connect Services" forState:UIControlStateNormal];
    [connectProviderButton addTarget:self action:@selector(showConnectionWizard) forControlEvents:UIControlEventTouchUpInside];
    [connectProviderButton.layer setCornerRadius:20.0f];
    [connectProviderButton.layer setMasksToBounds:YES];
    [connectProviderButton.layer setBorderWidth:1.0f];
    connectProviderButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [scrollView addSubview:connectProviderButton];
    
    
    
    // Account Settings
    settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 330, 260, 20)];
    settingsLabel.text = @"Account Settings";
    [settingsLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    settingsLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [scrollView addSubview:settingsLabel];

    
    accountSettingsTableView = [[UITableView alloc] init];
    accountSettingsTableView.frame = CGRectMake(0, 350, 320, 44);
    accountSettingsTableView.delegate = self;
    accountSettingsTableView.dataSource = self;
    accountSettingsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    accountSettingsTableView.scrollEnabled = NO;
    [scrollView addSubview:accountSettingsTableView];
}

-(void) viewWillAppear:(BOOL)animated
{
    account = [AppDelegate sharedDelegate].store.account;
    [self refreshView];
}

-(void)viewDidLayoutSubviews
{
    [providersTableVC refreshTableView];
    [self setContentSize];
}

-(void)refreshView {
    [accountSettingsTableView reloadData];
    [providersTableVC refreshTableView];
    [self setContentSize];
}

-(void)setContentSize {
    
    UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView.frame = CGRectMake(0, providersTableVC.tableView.frame.origin.y + providersTableVC.tableView.contentSize.height, 320, 1);
    [scrollView addSubview: lineView];
    
    UIImageView *lineView3 = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView3.frame = CGRectMake(0, providersTableVC.tableView.frame.origin.y, 320, 1);
    [scrollView addSubview: lineView3];


    
    CGFloat providersTableVCHeight = (providersTableVC.tableView.frame.origin.y + providersTableVC.tableView.contentSize.height + 20);
    
    // Set connect button
    CGRect  buttonFrame = CGRectMake(connectProviderButton.frame.origin.x, providersTableVCHeight, connectProviderButton.frame.size.width, connectProviderButton.frame.size.height);
    connectProviderButton.frame = buttonFrame;
    
    // Settings Label
    CGRect  accountSettingsFrame = CGRectMake(settingsLabel.frame.origin.x, buttonFrame.origin.y + 80, settingsLabel.frame.size.width, settingsLabel.frame.size.height);
    settingsLabel.frame = accountSettingsFrame;
    
    // Set Accounts tableView
    CGRect  accountTableFrame = CGRectMake(accountSettingsTableView.frame.origin.x, buttonFrame.origin.y + 100, accountSettingsTableView.frame.size.width, accountSettingsTableView.frame.size.height);
    accountSettingsTableView.frame = accountTableFrame;
    

    
    UIImageView *lineView1 = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView1.frame = CGRectMake(0, accountSettingsTableView.frame.origin.y, 320, 1);
    [scrollView addSubview: lineView1];
    
    UIImageView *lineView2 = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView2.frame = CGRectMake(0, accountSettingsTableView.frame.origin.y + accountSettingsTableView.frame.size.height, 320, 1);
    [scrollView addSubview: lineView2];
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, accountSettingsTableView.frame.origin.y + accountSettingsTableView.frame.size.height+ 30);
    [self.view sendSubviewToBack:scrollView];
}

- (void) showConnectionWizard
{
    ConnectionWizardViewController *connectionWizard = [[ConnectionWizardViewController alloc] init];
    [self.navigationController presentViewController:connectionWizard animated:YES completion:^ {
        [self refreshView];
    }];
}




#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"teammateCell";
    TeammateCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if ( !cell )
    {
        cell = [ [ TeammateCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    if (indexPath.row == 0) {
        cell.cellIsForInvite = NO;
        //User *user = account.currentUser;
        cell.nameLabel.text = account.name;
        NSURL *avatarUrl = [NSURL URLWithString:account.avatarUrl];
        [cell.avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    } else {
        cell.nameLabel.text = @"Team Members";
        cell.avatarView.image = [UIImage imageNamed:@"avatar"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        AccountViewController *accountVC = [[AccountViewController alloc] init];
        [self.navigationController pushViewController:accountVC animated:YES];
    } else {
        TeamMembersViewController *teamVC = [[TeamMembersViewController alloc] init];
        [self.navigationController pushViewController:teamVC animated:YES];
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46;
}

- (void)dismissSettingsView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
