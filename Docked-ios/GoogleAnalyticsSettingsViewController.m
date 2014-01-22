//
//  GoogleAnalyticsSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GoogleAnalyticsSettingsViewController.h"

@interface GoogleAnalyticsSettingsViewController ()

@end

@implementation GoogleAnalyticsSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [[AppDelegate sharedDelegate].store.account providerWithName:@"google_analytics"];
        self.oAuthController = YES;
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Daily visitors count", @NO], @[@"Daily visits count", @NO], @[@"Daily page views count", @NO], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_google.png"];
    
    // Connected State
    ([self isConnected] ?  [self setupConnectedState] : [self setupUnconnectedState]);

    
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    [self.connectButton setBackgroundColor:[UIColor colorWithRed:240.0f/255.0f green:86.0f/255.0f blue:32.0f/255.0f alpha:1.0f]];
    
    [self.connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.connectButton setTitle:@"Connect to Google Analytics" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.connectButton];
    
    self.eventsViewController.view.frame = CGRectMake(0, 220, 240, 200);
    [self.scrollView addSubview:self.eventsViewController.view];

}

- (void) setupConnectedState
{
    [super setupConnectedState];

    self.eventsViewController.view.frame = CGRectMake(0, 260, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
}


- (void)connect
{
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/services/authenticate_for/google_oauth2"];
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:url];
    oAuthVC.delegate = self;
    [self.navigationController presentViewController:oAuthVC animated:YES completion:nil];
}

-(void) oAuthRequestDidSucceed
{
    [self setupConnectedState];
}

-(void) oAuthRequestDidFail
{
    [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
}

@end
