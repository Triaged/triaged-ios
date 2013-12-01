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
#import "MRProgress.h"

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
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissAccountView)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    
    self.view.backgroundColor = BG_COLOR;

    
    self.title = @"Account";
    
    nameLabel.text = currentAccount.name;
    emailLabel.text = currentAccount.email;
    companyLabel.text = currentAccount.companyName;
    
    NSURL *avatarUrl = [NSURL URLWithString:currentAccount.avatarUrl];
    [avatarButton setBackgroundImageForState:UIControlStateNormal withURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    [avatarButton addTarget:self action:@selector(updateProfilePicture) forControlEvents:UIControlEventTouchUpInside];
    
    // Connections
    connectionCountLabel.text = [[currentAccount connectedProviderCount] stringValue];
    // pushNotificationSwitch setOn
    pushNotificationSwitch.on = currentAccount.pushEnabled;
    
    // Team Table View
    // Team Members
    teamTableView.scrollEnabled = NO;
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
    dynamicTVHeight.constant =  (teamTableView.contentSize.height > 100) ? teamTableView.contentSize.height : 100;
    scrollView.contentSize = CGSizeMake(320, signOutButton.frame.origin.y + 80);
    
    [self.view layoutSubviews];
}


-(void) updateProfilePicture
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"How would you like to set your picture?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Choose Picture", nil];
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self selectPhoto];
    } else {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}

-(void) selectPhoto
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate = self;
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];

}

-(void) takePhoto
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imagePicker.delegate = self;
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    MRProgressOverlayView *progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    progressView.titleLabelText = @"Uploading";
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    
    [currentAccount uploadAvatar:chosenImage WithBlock:^(bool block) {
        if (block) {
            currentAccount = [AppDelegate sharedDelegate].store.account;
            NSURL *avatarUrl = [NSURL URLWithString:currentAccount.avatarUrl];
            [avatarButton setBackgroundImageForState:UIControlStateNormal withURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
            [avatarButton setNeedsDisplay];
            [currentAccount createUserFromAccount];
            [progressView dismiss:YES];
        }
            else {
                [progressView dismiss:YES];
                [CSNotificationView showInViewController:self
                                                   style:CSNotificationViewStyleError
                                                 message:@"Avatar failed to upload."];
            }
        
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

- (IBAction)pushSwitchValueChanged:(id)sender {
    [currentAccount updatePushEnabled:pushNotificationSwitch.on];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) dismissAccountView
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
        cell.userInteractionEnabled = NO;
        User *teammate = team[indexPath.row];
        cell.nameLabel.text = teammate.name;
        NSURL *avatarUrl = [NSURL URLWithString:teammate.avatarUrl];
        [cell.avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer =
        [[MFMailComposeViewController alloc] init];
        [mailComposer setSubject:@"Check out Triage"];
        NSString *message = [NSString stringWithFormat:@"Hey, <br><br> I've been using the Triage app to keep tabs of work when I'm on the go. I think you'd like it. <br /><br />Check it out at <a href='triaged.co'>triaged.co</a> <br /><br /> thanks!<br /> %@", currentAccount.name];
        [mailComposer setMessageBody:message
                              isHTML:YES];
        mailComposer.mailComposeDelegate = self;
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46;
}

@end
