//
//  ProviderSettingsTableViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ProvidersTableViewController.h"
#import "ListCell.h"
#import "AppDelegate.h"
#import "Store.h"
#import "Provider.h"
#import "BaseSettingsViewController.h"
#import "ConnectionWizardViewController.h"
#import "ProviderViewController.h"

@interface ProvidersTableViewController ()

@end

@implementation ProvidersTableViewController

@synthesize providers;

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
    
    self.title = @"Providers";
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icn_plus.png"] style:UIBarButtonItemStylePlain target:self action:@selector(connectProvider)];
    [self.navigationItem setRightBarButtonItem:doneButton];

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchProviders) forControlEvents:UIControlEventValueChanged];
    
    
    [self fetchProviders];
}

- (void) fetchProviders {
    [self.refreshControl beginRefreshing];
    
    [Provider fetchRemoteConnectedProvidersWithBlock:^(NSArray * fetchedProviders) {
        providers = fetchedProviders;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void) connectProvider {
    [self showConnectionWizard];
}

-(void)refreshTableView
{
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    CGRect frame = CGRectMake(0, self.tableView.frame.origin.y, 320.0, [self.tableView contentSize].height);
    self.tableView.frame = frame;
}

- (void) viewDidAppear:(BOOL)animated
{
    
    [self.tableView reloadData];
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
    return providers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProviderCell";
    ListCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ ListCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
   
    Provider *provider = providers[indexPath.row];
    [cell configureForProvider:provider];
   
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Provider *provider = providers[indexPath.row];
    
    ProviderViewController *providerVC = [[ProviderViewController alloc] initWithProvider:provider];
    [self.navigationController pushViewController:providerVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47;
}

- (void) showConnectionWizard
{
    ConnectionWizardViewController *connectionWizard = [[ConnectionWizardViewController alloc] init];
    [self.navigationController presentViewController:connectionWizard animated:YES completion:^ {
        [self.tableView reloadData];
    }];
}
@end
