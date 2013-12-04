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
#import <MessageUI/MessageUI.h>

@interface UserSettingsTableViewController () <MFMailComposeViewControllerDelegate>

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
    CGRect frame =  CGRectMake(34, 30, 282, [self.tableView contentSize].height);
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
    return users.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProviderCell";
    TeammateCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ TeammateCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    if (indexPath.row == users.count) {
        [cell configureForAddTeamMember];
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        User *user = users[indexPath.row];
        [cell configureForItem:user];
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == users.count) {
        [self inviteUser];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

-(void) inviteUser {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer =
        [[MFMailComposeViewController alloc] init];
        [mailComposer setSubject:@"Join me on Triage!"];
        NSString *message = [NSString stringWithFormat:@"Hey, <br><br> I've been using the Triage app to keep tabs of work when I'm on the go. I think you'd like it. <br /><br />Check it out at <a href='triaged.co'>triaged.co</a> <br /><br /> thanks!<br /> %@", [[AppDelegate sharedDelegate].store.account name]];
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
