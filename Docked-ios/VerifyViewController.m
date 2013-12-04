//
//  VerifyViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/6/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "VerifyViewController.h"
#import "CredentialStore.h"

@interface VerifyViewController ()

@end

@implementation VerifyViewController

@synthesize verifyButton, verifyCodeLabel, lineView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame = [AppDelegate sharedDelegate].window.frame;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BG_COLOR;
    // Do any additional setup after loading the view from its nib.
    verifyButton.backgroundColor = TINT_COLOR;
    UIColor *color = [UIColor whiteColor];
    verifyCodeLabel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Verification Code" attributes:@{NSForegroundColorAttributeName: color}];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkVerificationStatus) userInfo:nil repeats:YES];
}



- (void) checkVerificationStatus {
    if ([AppDelegate sharedDelegate].store.account.validatedCompany) {
        [self dismissViewControllerAnimated:NO completion:nil];
    } else {
        [[AppDelegate sharedDelegate].store fetchRemoteUserAccount];
    }
}

- (IBAction)resendEmail:(id)sender {
    
    [[AppDelegate sharedDelegate].store.account resendVerifyEmail];
    [verifyButton setTitle:@"Email Sent" forState:UIControlStateNormal];
}

- (IBAction)logout:(id)sender {
    [[CredentialStore sharedClient] clearSavedCredentials];
    [[AppDelegate sharedDelegate].navVC popToRootViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

@end
