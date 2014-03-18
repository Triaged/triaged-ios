//
//  HockeyAppSettingsViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/25/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "HockeyAppSettingsViewController.h"
#import "HTCopyableLabel.h"

@interface HockeyAppSettingsViewController ()

@end

@implementation HockeyAppSettingsViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.provider = [[AppDelegate sharedDelegate].store.account providerWithName:@"hockey_app"];
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"New Build", @NO],@[@"Crash", @YES], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_hockey_app.png"];
    self.instructionsText = @"Login to HockeyApp.\nGo to your app settings and add this webhook:";
    
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
