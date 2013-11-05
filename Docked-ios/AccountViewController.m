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
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "TeamMembersViewController.h"

@interface AccountViewController ()  {

    Account *currentAccount;
     NSArray *team;
   
}

@end

@implementation AccountViewController

@synthesize scrollView, upgradeButton, nameLabel, emailLabel, companyLabel, connectionCountLabel, pushNotificationSwitch, signOutButton, avatarButton, teamTableView, dynamicTVHeight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        currentAccount = [AppDelegate sharedDelegate].store.account;
        team = [AppDelegate sharedDelegate].store.account.team;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nameLabel.text = currentAccount.name;
    emailLabel.text = currentAccount.email;
    companyLabel.text = currentAccount.companyName;
    
    NSURL *avatarUrl = [NSURL URLWithString:currentAccount.avatarUrl];
    [avatarButton setBackgroundImageForState:UIControlStateNormal withURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    [avatarButton addTarget:self action:@selector(updateProfilePicture) forControlEvents:UIControlEventTouchUpInside];
    
    // Connections
    connectionCountLabel.text = [[currentAccount connectedProviderCount] stringValue];
    // pushNotificationSwitch setOn
    
    // Team Table View
    // Team Members
    teamTableView.scrollEnabled = NO;
    teamTableView.allowsSelection = NO;
    teamTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [teamTableView setSeparatorInset:UIEdgeInsetsZero];

    
    
    // Upgrade
    upgradeButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    
    // Signout
    [signOutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [teamTableView reloadData];
}

- (void) viewDidLayoutSubviews
{
    
    dynamicTVHeight.constant =  teamTableView.contentSize.height;
    //[teamTableView layoutIfNeeded];
    
    // Scroll View Size
    scrollView.contentSize = CGSizeMake(320, signOutButton.frame.origin.y + 80);
    //[scrollView layoutIfNeeded];


}


-(void) updateProfilePicture
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate = self;
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // Set the placeholder image while we're uploading
    [avatarButton setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    [currentAccount uploadAvatar:chosenImage WithBlock:^(bool block) {
        currentAccount = [AppDelegate sharedDelegate].store.account;
        NSURL *avatarUrl = [NSURL URLWithString:currentAccount.avatarUrl];
        [avatarButton setBackgroundImageForState:UIControlStateNormal withURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
        [avatarButton setNeedsDisplay];
    }];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(IBAction)logout:(id)sender
{
    [[CredentialStore sharedClient] clearSavedCredentials];
    [[AppDelegate sharedDelegate].navVC popToRootViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)contactUs:(id)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer =
        [[MFMailComposeViewController alloc] init];
        [mailComposer setToRecipients:[NSArray arrayWithObject:@"team@triaged.co"]];
        [mailComposer setSubject:@"Hello"];
        NSString *message = @"Hey Triage team,";
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


#pragma mark TeamTableView

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
