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
    self.tableView.backgroundColor  = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
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
    Provider *provider = providers[indexPath.row];
    
    NSDictionary *providerSettings = [Provider settingsDictForProvider:provider.name];
    Class providerSettingsClass = [providerSettings objectForKey:@"settings_class"];

    BaseSettingsViewController *settingsVC = [[providerSettingsClass alloc] init];
    [self.navigationController pushViewController:settingsVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
