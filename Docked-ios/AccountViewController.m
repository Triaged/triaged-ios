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
   
}

@end

@implementation AccountViewController

@synthesize scrollView, upgradeButton, nameLabel, emailLabel, companyLabel, connectionCountLabel, pushNotificationSwitch, signOutButton, avatarButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        currentAccount = [AppDelegate sharedDelegate].store.account;
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
    connectionCountLabel.text = [[currentAccount connectedCount] stringValue];
    // pushNotificationSwitch setOn
    
    // Upgrade
    upgradeButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    
    // Signout
    [signOutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
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
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    [currentAccount uploadProfilePicture:chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(IBAction)logout:(id)sender
{
    [[CredentialStore sharedClient] clearSavedCredentials];
    [[AppDelegate sharedDelegate].navVC popToRootViewControllerAnimated:NO];
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

-(IBAction)showTeam:(id)sender {
    
    
}

@end
