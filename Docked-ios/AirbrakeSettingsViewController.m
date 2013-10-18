//
//  AirbrakeSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/11/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "AirbrakeSettingsViewController.h"

@interface AirbrakeSettingsViewController ()

@end

@implementation AirbrakeSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [MTLJSONAdapter modelOfClass:Provider.class fromJSONDictionary:[[AppDelegate sharedDelegate].store.account.providers valueForKey:@"airbrake"] error:nil];
        
        self.events = [NSArray arrayWithObjects:@[@"Exception", @YES], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_airbrake.png"];
    [self.scrollView addSubview:self.followButton];
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
}

- (void) setupConnectedState
{
    [super setupConnectedState];
    
    [self.scrollView addSubview:self.followButton];
    
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

@end
