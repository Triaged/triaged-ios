//
//  AccountViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "AccountViewController.h"
#import "CredentialStore.h"
#import "AppDelegate.h"
#import "Store.h"
#import "TeammateCell.h"

@interface AccountViewController () <UITableViewDataSource>  {

    Account *currentAccount;
   
}

@end

@implementation AccountViewController

@synthesize scrollView, upgradeButton, nameLabel, emailLabel, companyLabel, connectionCountLabel, pushNotificationSwitch, teamTableView, signOutButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        currentAccount = [AppDelegate sharedDelegate].store.account;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nameLabel.text = currentAccount.name;
    nameLabel.text = currentAccount.email;
    nameLabel.text = currentAccount.companyName;
    //avatarImage.image = currentAccount.avatar;
    
    // Connections
    connectionCountLabel.text = [currentAccount.followedProviderCount stringValue];
    // pushNotificationSwitch setOn
    
    // Upgrade
    upgradeButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    
    // Team Members
    teamTableView.delegate = self;
    teamTableView.dataSource = self;
    teamTableView.scrollEnabled = NO;
    teamTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [teamTableView setSeparatorInset:UIEdgeInsetsZero];
}

-(void) layoutSubviews {
    signOutButton.frame = CGRectMake(12.0, teamTableView.frame.origin.y + teamTableView.contentSize.height + 50.0 ,40.0, 20.0);
}

-(void)viewDidLayoutSubviews
{
    [self setContentSize];
}

-(void)refreshView {
    [teamTableView reloadData];
    [self setContentSize];
}

-(void)setContentSize {
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, signOutButton.frame.origin.y + 50);
    scrollView.frame = self.view.frame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return currentAccount.teammates.count + 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"teammateCell";
    TeammateCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ TeammateCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    if (indexPath.row == currentAccount.teammates.count) {
        cell.cellIsForInvite = YES;
    } else {
        cell.cellIsForInvite = NO;
        User *teammate = currentAccount.teammates[indexPath.row];
        cell.nameLabel.text = teammate.name;
        //cell.avatarView.image = teammate.avatarUrl;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logout:(id)sender
{
    [[CredentialStore sharedClient] clearSavedCredentials];
}

@end
