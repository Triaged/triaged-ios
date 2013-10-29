//
//  TeamMembersViewController.m
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TeamMembersViewController.h"
#import "AppDelegate.h"
#import "Store.h"
#import "TeammateCell.h"
#import "UIImageView+AFNetworking.h"

@interface TeamMembersViewController () {
    NSArray *team;
}

@end

@implementation TeamMembersViewController

@synthesize teamTableView;

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
    
    team = [AppDelegate sharedDelegate].store.account.team;
    
    // Team Members
    teamTableView.delegate = self;
    teamTableView.dataSource = self;
    teamTableView.scrollEnabled = NO;
    teamTableView.allowsSelection = NO;
    teamTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [teamTableView setSeparatorInset:UIEdgeInsetsZero];

    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return team.count + 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"teammateCell";
    TeammateCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ TeammateCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    if (indexPath.row == team.count) {
        cell.cellIsForInvite = YES;
    } else {
        cell.cellIsForInvite = NO;
        User *teammate = team[indexPath.row];
        cell.nameLabel.text = teammate.name;
        NSURL *avatarUrl = [NSURL URLWithString:teammate.avatarUrl];
        [cell.avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46;
}

@end
