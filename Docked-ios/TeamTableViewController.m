//
//  TeamTableViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "TeamTableViewController.h"
#import "User.h"
#import "TeammateViewController.h"
#import "ListCell.h"

@interface TeamTableViewController ()

@end

@implementation TeamTableViewController

@synthesize team;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Team";
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    UIBarButtonItem *inviteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icn_plus.png"] style:UIBarButtonItemStylePlain target:self action:@selector(inviteTeammate)];
    [self.navigationItem setRightBarButtonItem:inviteButton];

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTeam) forControlEvents:UIControlEventValueChanged];
    
    [self fetchTeam];
}

- (void) fetchTeam {
    [self.refreshControl beginRefreshing];
    
    [User fetchRemoteTeamWithBlock:^(NSArray * fetchedTeam) {
        team = fetchedTeam;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void) inviteTeammate {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return team.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProviderCell";
    ListCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ ListCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    // Configure the cell...
    User * teammate = [team objectAtIndex:indexPath.row];
    [cell configureForUser:teammate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = team[indexPath.row];
    
    TeammateViewController *teammateVC = [[TeammateViewController alloc] initWithUser:user];
    [self.navigationController pushViewController:teammateVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47;
}




@end