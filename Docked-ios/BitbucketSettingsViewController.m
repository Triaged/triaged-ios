//
//  BitbucketSettingsViewController.m
//  Triage-ios
//
//  Created by Charlie White on 12/12/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "BitbucketSettingsViewController.h"

@interface BitbucketSettingsViewController ()

@end

@implementation BitbucketSettingsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.provider = [[AppDelegate sharedDelegate].store.account providerWithName:@"bitbucket"];
        self.oAuthController = YES;
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Commits", @YES], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_bitbucket.png"];
    
    // Connected State
    ([self isConnected] ?  [self setupConnectedState] : [self setupUnconnectedState]);
    
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    [self.connectButton setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:51.0f/255.0f blue:102.0f/255.0f alpha:1.0f]];
    [self.connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.connectButton setTitle:@"Connect to Bitbucket" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.connectButton];
    
    self.eventsViewController.view.frame = CGRectMake(0, 220, 240, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
}

- (void) setupConnectedState
{
    [super setupConnectedState];
    
    self.providerAccountTableVC.view.frame = CGRectMake(0, 190, 320, 44);
//    self.providerAccountTableVC.accountText = self.provider.account.name;
//    self.accountProperties  = self.provider.account.properties;
//    self.accountDetailsTitle = self.provider.account.propertyLabel;
    
    [self.scrollView addSubview:self.providerAccountTableVC.view];
    
    self.eventsViewController.view.frame = CGRectMake(0, 260, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
    
    UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView.frame = CGRectMake(0, self.providerAccountTableVC.tableView.frame.origin.y, 320, 1);
    [self.scrollView addSubview: lineView];
    
    
}


- (void)connect
{
    NSString *url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/services/authenticate_for/bitbucket"];
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
