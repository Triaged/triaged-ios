//
//  BeanstalkSettingsViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/25/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "BeanstalkSettingsViewController.h"
#import "HTCopyableLabel.h"

@interface BeanstalkSettingsViewController ()

@end

@implementation BeanstalkSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [[AppDelegate sharedDelegate].store.account providerWithName:@"beanstalk"];
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Deploy", @NO], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_beanstalk.png"];
    self.instructionsText = @"Login to Beanstalk.\nGo to Settings -> Integration -> Webhooks and add this webhook:";
    
    // Connected State
    ([self isConnected] ?  [self setupConnectedState] : [self setupUnconnectedState]);
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
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
