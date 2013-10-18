//
//  HerokuSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/11/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "HerokuSettingsViewController.h"

@interface HerokuSettingsViewController ()

@end

@implementation HerokuSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [MTLJSONAdapter modelOfClass:Provider.class fromJSONDictionary:[[AppDelegate sharedDelegate].store.account.providers valueForKey:@"heroku"] error:nil];
        
        self.events = [NSArray arrayWithObjects:@[@"Deployment", @YES], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_heroku.png"];
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
