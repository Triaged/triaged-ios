//
//  SentrySettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "SentrySettingsViewController.h"
#import "HTCopyableLabel.h"

@interface SentrySettingsViewController ()

@end

@implementation SentrySettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.provider = [[AppDelegate sharedDelegate].store.account providerWithName:@"sentry"];
        
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Exception", @YES], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_sentry.png"];
    self.instructionsText = @"Login to Sentry.\nGo to your project settings and add a webhook with the url:";
    
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
