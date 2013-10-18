//
//  SignupViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeViewController.h"

@interface SignupViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) WelcomeViewController *welcomeVC;

@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtextLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *divider1;
@property (weak, nonatomic) IBOutlet UIImageView *divider2;
@property (weak, nonatomic) IBOutlet UIImageView *divider3;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)signup;
- (IBAction)returnToWelcome:(id)sender;
@end
