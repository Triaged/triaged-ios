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
    // Do any additional setup after loading the view from its nib.
    verifyButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    
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
}

- (IBAction)logout:(id)sender {
    [[CredentialStore sharedClient] clearSavedCredentials];
    [[AppDelegate sharedDelegate].navVC popToRootViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

@end
