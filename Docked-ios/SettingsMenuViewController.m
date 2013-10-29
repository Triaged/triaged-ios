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

@interface SettingsMenuViewController () {

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
        account = [AppDelegate sharedDelegate].store.account;
        
        for (UIView *view in self.navigationController.navigationBar.subviews) {
            for (UIView *view2 in view.subviews) {
                if ([view2 isKindOfClass:[UIImageView class]]) {
                    [view2 removeFromSuperview];
                }
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Settings";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                   target:self action:@selector(dismissSettingsView)];

    self.navigationItem.leftBarButtonItem = doneButton;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.frame = self.view.frame;
    scrollView.contentSize = CGSizeMake(320, 550);
    [self.view addSubview:scrollView];
    
    UILabel *connectionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 24, 260, 20)];
    connectionsLabel.text = @"Connections";
    [connectionsLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    connectionsLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [scrollView addSubview:connectionsLabel];

    
    

    
    ProviderSettingsTableViewController *providersTableVC = [[ProviderSettingsTableViewController alloc] init];
    //commentsVC.delegate = self;
    //providersTableVC.providers =  [[AppDelegate sharedDelegate].store.account.providers allValues];
    [self addChildViewController:providersTableVC];
    CGRect frame = CGRectMake(0, 46, 320, self.view.frame.size.height - 100);
    providersTableVC.tableView.frame = frame;
    [scrollView  addSubview:providersTableVC.tableView];
    [providersTableVC didMoveToParentViewController:self];
    
    UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView.frame = CGRectMake(0, 46, 320, 1);
    [scrollView addSubview: lineView];
    
    UIImageView *lineView4 = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView4.frame = CGRectMake(0, 396, 320, 1);
    [scrollView addSubview: lineView4];
    
    
    UILabel *settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 420, 260, 20)];
    settingsLabel.text = @"Account Settings";
    [settingsLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    settingsLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [scrollView addSubview:settingsLabel];

    
    UITableView *accountTable = [[UITableView alloc] init];
    accountTable.frame = CGRectMake(0, 442, 310, 88);
    accountTable.delegate = self;
    accountTable.dataSource = self;
    accountTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    accountTable.scrollEnabled = NO;
    [scrollView  addSubview:accountTable];
    
    //UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView1 = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView1.frame = CGRectMake(0, 442, 320, 1);
    [scrollView addSubview: lineView1];

    
    //UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView2 = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView2.frame = CGRectMake(0, 550, 320, 1);
    [scrollView addSubview: lineView2];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
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
        User *user = account.currentUser;
        cell.nameLabel.text = user.name;
        NSURL *avatarUrl = [NSURL URLWithString:user.avatarUrl];
        [cell.avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    } else {
        cell.nameLabel.text = @"Teammates";
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
