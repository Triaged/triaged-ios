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
        self.providerDict = [[AppDelegate sharedDelegate].store.account.providers
                                                        valueForKey:@"google_analytics"];
        
        self.provider = [MTLJSONAdapter modelOfClass:Provider.class fromJSONDictionary:self.providerDict
                                               error:nil];
        
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Daily visitors count", @NO], @[@"Daily visits count", @NO], @[@"Daily page views count", @NO], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_google.png"];
    
    
    self.eventsViewController.view.frame = CGRectMake(0, 220, 240, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    [self.connectButton setBackgroundColor:[UIColor colorWithRed:240.0f/255.0f green:86.0f/255.0f blue:32.0f/255.0f alpha:1.0f]];
    
    [self.connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.connectButton setTitle:@"Connect to Google Analytics" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.connectButton];

}

- (void) setupConnectedState
{
    [super setupConnectedState];

    self.providerAccountTableVC.view.frame = CGRectMake(0, 130, 320, 44);
    self.providerAccountTableVC.accountText = [[self.providerDict valueForKey:@"account_settings"] valueForKey:@"account"];
    self.accountDetails = [[self.providerDict valueForKey:@"account_settings"] valueForKey:@"properties"];
    self.accountDetailsTitle = @"Properties";

    [self.scrollView addSubview:self.providerAccountTableVC.view];
    
    UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView.frame = CGRectMake(0, self.providerAccountTableVC.tableView.frame.origin.y, 320, 1);
    [self.scrollView addSubview: lineView];
    

}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (void)connect
{
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:@"https://www.triaged.co/services/authenticate_for/google_oauth2"];
    oAuthVC.delegate = self;
    [self.navigationController presentViewController:oAuthVC animated:YES completion:nil];
}

-(void) oAuthRequestDidSucceed
{
    [self.provider connect];
    [self setupConnectedState];
    
    //update our store account from the server
    [[AppDelegate sharedDelegate].store fetchRemoteUserAccount];
}

-(void) oAuthRequestDidFail
{
    [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
}

@end
