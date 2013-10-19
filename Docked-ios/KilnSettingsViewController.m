//
//  KilnSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/18/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "KilnSettingsViewController.h"

@interface KilnSettingsViewController ()

@end

@implementation KilnSettingsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [MTLJSONAdapter modelOfClass:Provider.class fromJSONDictionary:[[AppDelegate sharedDelegate].store.account.providers valueForKey:@"kiln"] error:nil];
        
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Push", @NO], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_kiln.png"];
    [self.scrollView addSubview:self.followButton];
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    // Connect Title
    UILabel *connectTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 180, 240, 20)];
    [connectTitle setText:@"Connect Your Account"];
    [connectTitle setFont: [UIFont fontWithName:@"AvenirNext-UltraLight" size:24.0]];
    connectTitle.textColor = [UIColor blackColor];
    [self.scrollView addSubview:connectTitle];
    
    // Instructions
    UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 210, 240, 40)];
    [instructionsLabel setText:@"Please login to Sentry. Go to your project settings and add a webhook with the url:"];
    [instructionsLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    instructionsLabel.textColor = [UIColor blackColor];
    instructionsLabel.numberOfLines = 0;
    [instructionsLabel sizeToFit];
    [self.scrollView addSubview:instructionsLabel];
    
    // Service URL
    UILabel *serviceUrlLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 275, 280, 20)];
    [serviceUrlLabel setText:self.provider.webhookUrl];
    [serviceUrlLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    [serviceUrlLabel setTextAlignment:NSTextAlignmentCenter];
    serviceUrlLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
    [self.scrollView addSubview:serviceUrlLabel];
    
    self.eventsViewController.view.frame = CGRectMake(0, 320, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
}

- (void) setupConnectedState
{
    [super setupConnectedState];
    
    self.eventsViewController.view.frame = CGRectMake(0, 240, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}


@end
