//
//  BraintreeSettingsViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/27/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "BraintreeSettingsViewController.h"
#import "HTCopyableLabel.h"

@interface BraintreeSettingsViewController ()

@end

@implementation BraintreeSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [[AppDelegate sharedDelegate].store.account providerWithName:@"braintree"];
        
        
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Deploy", @NO], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_braintree.png"];
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    // Connect Title
    UILabel *connectTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, 240, 20)];
    [connectTitle setText:@"Connect Your Account"];
    [connectTitle setFont: [UIFont fontWithName:@"AvenirNext-UltraLight" size:24.0]];
    connectTitle.textColor = [UIColor blackColor];
    [self.scrollView addSubview:connectTitle];
    
    // Instructions
    UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 140, 240, 40)];
    [instructionsLabel setText:@"Please login to Braintree.\nGo to your project settings and add a webhook with the url:"];
    [instructionsLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    instructionsLabel.textColor = [UIColor blackColor];
    instructionsLabel.numberOfLines = 0;
    instructionsLabel.textAlignment = NSTextAlignmentCenter;
    [instructionsLabel sizeToFit];
    [self.scrollView addSubview:instructionsLabel];
    
    // Service URL
    HTCopyableLabel *serviceUrlLabel = [[HTCopyableLabel alloc] initWithFrame:CGRectMake(20, 205, 280, 20)];
    [serviceUrlLabel setText:self.provider.webhookUrl];
    [serviceUrlLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    [serviceUrlLabel setTextAlignment:NSTextAlignmentCenter];
    serviceUrlLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
    [self.scrollView addSubview:serviceUrlLabel];
    
    // Email Instructions
    self.emailInstructionsButton.frame = CGRectMake(40, 240, 240, 40);
    [self.scrollView addSubview:self.emailInstructionsButton];
    
    self.eventsViewController.view.frame = CGRectMake(0, 300, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
}

- (void) setupConnectedState
{
    [super setupConnectedState];
    
    self.eventsViewController.view.frame = CGRectMake(0, 240, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
}
@end