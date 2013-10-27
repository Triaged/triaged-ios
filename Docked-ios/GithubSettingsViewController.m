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
#import "SVProgressHUD.h"


@interface GithubSettingsViewController ()

@end

@implementation GithubSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [MTLJSONAdapter modelOfClass:Provider.class fromJSONDictionary:[[AppDelegate sharedDelegate].store.account.providers valueForKey:@"github"] error:nil];
        
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Push", @NO], @[@"Commits", @NO], @[@"Issue opened", @YES], @[@"Issue closed", @NO], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_github.png"];
    
    self.eventsViewController.view.frame = CGRectMake(0, 200, 240, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    [self.connectButton setBackgroundColor:[UIColor blackColor]];
    [self.connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.connectButton setTitle:@"Connect to Github" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.connectButton];
    
}

- (void) setupConnectedState
{
    [super setupConnectedState];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (void)connect
{
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:@"https://www.triaged.co/services/authenticate_for/github"];
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
