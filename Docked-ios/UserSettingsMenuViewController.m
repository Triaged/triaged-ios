//
//  UserSettingsMenuViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "UserSettingsMenuViewController.h"
#import "UserSettingsTableViewController.h"
#import "AccountViewController.h"
#import <MessageUI/MessageUI.h>

@interface UserSettingsMenuViewController () <MFMailComposeViewControllerDelegate> {
    UIScrollView *scrollView;
    UserSettingsTableViewController *usersTableVC;
    TRButton *InviteUserButton;
    UILabel *settingsLabel;
    Account *account;
}



@end

@implementation UserSettingsMenuViewController

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
	// Do any additional setup after loading the view.
    account = [AppDelegate sharedDelegate].store.account;
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.frame = self.view.frame;
    [self.view addSubview:scrollView];
    
    // Connected Label
    settingsLabel = [[UILabel alloc] init];
    settingsLabel.frame = CGRectMake(0, 30, 320, 20);
    settingsLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
    settingsLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
    settingsLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:settingsLabel];
    
    // Account Button
    
    UIButton *accountButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 24, 30, 30)];
    [accountButton setImage:[UIImage imageNamed:@"cog.png"] forState:UIControlStateNormal];
    [accountButton addTarget:self action:@selector(showAccount) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:accountButton];
    
    
    
    // Connected Providers TableView
    usersTableVC = [[UserSettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:usersTableVC];
    CGRect frame = CGRectMake(34, 70, 282, self.view.frame.size.height - 40);
    usersTableVC.tableView.frame = frame;
    UITableView *usersTableView = usersTableVC.tableView;
    [scrollView  addSubview:usersTableView];
    [usersTableVC didMoveToParentViewController:self];
    
    
    usersTableVC.users = [[AppDelegate sharedDelegate].store.account team];
    settingsLabel.text = (usersTableVC.users.count > 0) ? @"Teammates" : @"No Teammates yet";

    InviteUserButton = [[TRButton alloc] initWithFrame:CGRectMake(48, 320, 256, 40)];
    [InviteUserButton setTitle:@"Invite Teammates" forState:UIControlStateNormal];
    [InviteUserButton addTarget:self action:@selector(inviteUser) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:InviteUserButton];

}

-(void) viewWillAppear:(BOOL)animated
{
    [self refreshView];
}

-(void)viewDidLayoutSubviews
{
    [usersTableVC refreshTableView];
    [self setContentSize];
}

-(void)refreshView {
    //[accountSettingsTableView reloadData];
    usersTableVC.users = [[AppDelegate sharedDelegate].store.account team];
    [usersTableVC refreshTableView];
    settingsLabel.text = (usersTableVC.users.count > 0) ? @"Teammates" : @"No Teammates yet";
    [self setContentSize];
}

-(void)setContentSize {
    
    
    CGFloat usersTableVCHeight = (usersTableVC.tableView.frame.origin.y + usersTableVC.tableView.contentSize.height + 20);
    
    // Set connect button
    CGRect  buttonFrame = CGRectMake(InviteUserButton.frame.origin.x, usersTableVCHeight, InviteUserButton.frame.size.width, InviteUserButton.frame.size.height);
    InviteUserButton.frame = buttonFrame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, buttonFrame.origin.y + buttonFrame.size.height+ 30);
    [self.view sendSubviewToBack:scrollView];
}

-(void)showAccount {
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    TRNavigationViewController *nav = [[TRNavigationViewController alloc] initWithRootViewController:accountVC ];
    
    [self presentViewController:nav animated:YES completion:nil];

}

-(void) inviteUser {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer =
        [[MFMailComposeViewController alloc] init];
        [mailComposer setSubject:@"Join me on Triage!"];
        NSString *message = [NSString stringWithFormat:@"Hey, <br><br> I've been using the Triage app to keep tabs of work when I'm on the go. I think you'd like it. <br /><br />Check it out at <a href='triaged.co'>triaged.co</a> <br /><br /> thanks!<br /> %@", account.name];
        [mailComposer setMessageBody:message
                              isHTML:YES];
        mailComposer.mailComposeDelegate = self;
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
