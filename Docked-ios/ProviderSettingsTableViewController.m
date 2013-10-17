//
//  ProviderSettingsTableViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ProviderSettingsTableViewController.h"
#import "ProviderSettingCell.h"
#import "AppDelegate.h"
#import "Store.h"
#import "Provider.h"
#import "BaseSettingsViewController.h"

@interface ProviderSettingsTableViewController ()

@end

@implementation ProviderSettingsTableViewController

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
    
    self.tableView.bounces = NO;
    self.tableView.backgroundColor  = [UIColor colorWithRed:201.0f/255.0f green:203.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    providers = [Provider currentProviders];
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
    ProviderSettingCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ ProviderSettingCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    NSDictionary *provider = providers[indexPath.row];
    
    [cell configureForItem:provider];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *provider = providers[indexPath.row];
    Class providerSettingsClass = [provider objectForKey:@"settings_class"];
    
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    BaseSettingsViewController *settingsVC = [[providerSettingsClass alloc] init];
    [[AppDelegate sharedDelegate].navVC pushViewController:settingsVC animated:NO];
    [revealController setFrontViewController:[AppDelegate sharedDelegate].navVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end
