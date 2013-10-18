//
//  GithubSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GithubSettingsViewController.h"
#import "AppDelegate.h"
#import "Store.h"


@interface GithubSettingsViewController ()

@end

@implementation GithubSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [MTLJSONAdapter modelOfClass:Provider.class fromJSONDictionary:[[AppDelegate sharedDelegate].store.account.providers valueForKey:@"github"] error:nil];
        
        self.events = [NSArray arrayWithObjects:@"push", @"commits", @"issue opened", @"issue closed", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_github.png"];
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    [self.connectButton setBackgroundColor:[UIColor blackColor]];
    [self.connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.connectButton setTitle:@"Connect to Github" forState:UIControlStateNormal];
    [self.view addSubview:self.connectButton];
}

- (void) setupConnectedState
{
    [super setupConnectedState];
    
    [self.view addSubview:self.followButton];

}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connect
{
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:@"http://www.docked.io/services/authenticate_for/github"];
    oAuthVC.delegate = self;
    [self.navigationController presentViewController:oAuthVC animated:YES completion:nil];
}

-(void) oAuthRequestDidSucceed
{
    [self.provider connect];
    [self setupConnectedState];
    
    // Set this automatically on succesful oAuth
    [self toggleFollow];
    
    //update our store account from the server
    [[AppDelegate sharedDelegate].store fetchRemoteUserAccount];
}

-(void) oAuthRequestDidFail
{
    
}

@end
