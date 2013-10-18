//
//  NewRelicSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/11/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "NewRelicSettingsViewController.h"

@interface NewRelicSettingsViewController ()

@end

@implementation NewRelicSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [MTLJSONAdapter modelOfClass:Provider.class fromJSONDictionary:[[AppDelegate sharedDelegate].store.account.providers valueForKey:@"new_relic"] error:nil];
        
        self.events = [NSArray arrayWithObjects:@[@"App Alert", @YES], @[@"Appdex Alert", @YES], @[@"Deployment", @NO], @[@"Downtime", @YES], @[@"Error Threshold", @YES], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_newrelic.png"];
    [self.scrollView addSubview:self.followButton];
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
}

- (void) setupConnectedState
{
    [super setupConnectedState];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}


@end
