//
//  AccountViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AccountViewController : UIViewController <MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectionCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *upgradeButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UISwitch *pushNotificationSwitch;
@property (weak, nonatomic) IBOutlet UIButton *teamButton;
@property (weak, nonatomic) IBOutlet UITableView *teamTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *dynamicTVHeight;

-(IBAction)logout:(id)sender;
-(IBAction)contactUs:(id)sender;

@end
