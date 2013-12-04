//
//  CrashlyticsSettingsViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/25/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "CrashlyticsSettingsViewController.h"
#import "HTCopyableLabel.h"

@interface CrashlyticsSettingsViewController ()

@end

@implementation CrashlyticsSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [[AppDelegate sharedDelegate].store.account providerWithName:@"crashlytics"];
        
        
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Issue", @YES], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_crashlytics.png"];
    self.instructionsText = @"Login to Crashlytics.\nGo to Settings -> App -> Integrations and add this token:";
    
    // Connected State
    ([self isConnected] ?  [self setupConnectedState] : [self setupUnconnectedState]);
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    self.eventsViewController.view.frame = CGRectMake(0, 300, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
    [self.serviceUrlLabel setText:[[AppDelegate sharedDelegate].store.account apiToken]];
    
}

- (void) setupConnectedState
{
    [super setupConnectedState];
    
    self.eventsViewController.view.frame = CGRectMake(0, 240, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
}

@end
