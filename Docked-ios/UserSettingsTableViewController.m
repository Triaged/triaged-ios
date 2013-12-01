//
//  UserSettingsTableViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "UserSettingsTableViewController.h"
#import "TeammateCell.h"
#import "UIImageView+AFNetworking.h"

@interface UserSettingsTableViewController ()

@end

@implementation UserSettingsTableViewController

@synthesize users;

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
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorColor = BG_COLOR;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

}

-(void)refreshTableView
{
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    CGRect frame =  CGRectMake(34, 70, 282, [self.tableView contentSize].height);
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
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProviderCell";
    TeammateCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ TeammateCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    User *user = users[indexPath.row];
    
    [cell configureForItem:user];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    User *user = users[indexPath.row];
//    
//    NSDictionary *providerSettings = [Provider settingsDictForProvider:provider.name];
//    Class providerSettingsClass = [providerSettings objectForKey:@"settings_class"];
//    
//    BaseSettingsViewController *settingsVC = [[providerSettingsClass alloc] init];
//    
//    TRNavigationViewController *nav = [[TRNavigationViewController alloc] initWithRootViewController:settingsVC ];
//    [self presentViewController:nav animated:YES completion:nil];
//    
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
