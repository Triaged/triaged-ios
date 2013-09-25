//
//  StripeSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "StripeSettingsViewController.h"
#import "OAuthViewController.h"

@interface StripeSettingsViewController ()

@end

@implementation StripeSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectToStripe {
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:@"http://cwhite.local:3000/services/authenticate_for/stripe_connect"];
    [self.navigationController presentViewController:oAuthVC animated:YES completion:nil];
}

@end
