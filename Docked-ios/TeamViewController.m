//
//  TeamViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TeamViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TeamViewController () {
        Account *account;
}

@end

@implementation TeamViewController

@synthesize users, tableView, inviteTeammates;

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
    // Do any additional setup after loading the view from its nib.
    account = [AppDelegate sharedDelegate].store.account;
    users = account.team;
    
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProviderCell";
    UITableViewCell *cell = [ aTableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    User *user = users[indexPath.row];
    
    cell.textLabel.text = user.name;
    NSURL *avatarUrl = [NSURL URLWithString:user.avatarUrl];
    //[avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    [cell.imageView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    //[cell configureForItem:user];
    
    return cell;
}


@end
