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
#import "MRProgress.h"
#import "SVWebViewController.h"

@interface AccountViewController ()  {

    Account *currentAccount;
     NSArray *team;
   
}

@end

@implementation AccountViewController

@synthesize scrollView, nameLabel, emailLabel, companyLabel, connectionCountLabel, pushNotificationSwitch, avatarButton, tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        currentAccount = [AppDelegate sharedDelegate].store.currentAccount;
        team =  [[AppDelegate sharedDelegate].store.currentAccount.teammates allObjects];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissAccountView)];
    [self.navigationItem setLeftBarButtonItem:doneButton];
    
    self.view.backgroundColor = BG_COLOR;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];

    self.title = @"Account";
    
    nameLabel.text = currentAccount.currentUser.name;
    emailLabel.text = currentAccount.currentUser.email;
    companyLabel.text = currentAccount.companyName;
    
    NSURL *avatarUrl = [NSURL URLWithString:currentAccount.currentUser.avatarUrl];
    [avatarButton setBackgroundImageForState:UIControlStateNormal withURL:avatarUrl placeholderImage:[UIImage imageNamed:@"add_photo.png"]];
    [avatarButton addTarget:self action:@selector(updateProfilePicture) forControlEvents:UIControlEventTouchUpInside];
    
    // Connections
    connectionCountLabel.text = currentAccount.followedProvidersCount;
    // pushNotificationSwitch setOn
    pushNotificationSwitch.on = currentAccount.pushEnabled;
    
}

- (void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: YES animated:YES];
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
    
    
//    [currentAccount uploadAvatar:chosenImage WithBlock:^(bool block) {
//        if (block) {
//            currentAccount = [AppDelegate sharedDelegate].store.account;
//            NSURL *avatarUrl = [NSURL URLWithString:currentAccount.avatarUrl];
//            [avatarButton setBackgroundImageForState:UIControlStateNormal withURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
//            [avatarButton setNeedsDisplay];
//            [currentAccount createUserFromAccount];
//            [progressView dismiss:YES];
//        }
//            else {
//                [progressView dismiss:YES];
//                [CSNotificationView showInViewController:self
//                                                   style:CSNotificationViewStyleError
//                                                 message:@"Avatar failed to upload."];
//            }
//        
//    }];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)logout
{
    [[CredentialStore sharedClient] clearSavedCredentials];
    [[AppDelegate sharedDelegate] setWindowAndRootVC];
}

-(void)terms {
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress:@"https://www.triaged.co/terms"];
    [self.navigationController pushViewController:webViewController animated:YES];
    
}

-(void)contactUs
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
    //[currentAccount updatePushEnabled:pushNotificationSwitch.on];
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
    return 3;
}

- (UITableViewCell*)tableView:(UITableView*)aTableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"teammateCell";
    UITableViewCell *cell = [ aTableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    [cell.textLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:17.0]];
    cell.textLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.row == 0) {
        cell.textLabel.text = @"Send Us Feedback";
    } else if(indexPath.row == 1) {
        cell.textLabel.text = @"Terms And Service";
    } else {
        cell.textLabel.text = @"Sign Out";
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 0) {
        [self contactUs];
    } else if(indexPath.row == 1) {
        [self terms];
    } else {
        [self logout];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
