//
//  GithubSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "GithubSettingsViewController.h"
#import "OAuthViewController.h"
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
    
    NSDictionary *settings = [[AppDelegate sharedDelegate].store.account.providers valueForKey:@"github"];
    NSLog(@"%@", settings);
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_github.png"];
    
    // Connect Button
    if (!self.provider.connected) {
        [self.connectButton setBackgroundColor:[UIColor blackColor]];
        [self.connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.connectButton setTitle:@"Connect to Github" forState:UIControlStateNormal];
        [self.view addSubview:self.connectButton];
    }
    
    
//    UIButton *followButton = [[UIButton alloc] init];
//    [followButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    followButton.frame = CGRectMake(100, 120, 90, 60);
//    [followButton setTitle:@"Follow" forState:UIControlStateNormal];
//    [followButton addTarget:self action:@selector(toggleFollow) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:followButton];
//    
//    
//
    //BOOL following = [AppDelegate sharedDelegate].store.account.userID;
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)connectToGithub {
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:@"http://triaged-staging.herokuapp.com/services/authenticate_for/github"];
    [self.navigationController presentViewController:oAuthVC animated:YES completion:nil];
}

-(void) toggleFollow
{
    if (self.provider.follows) {
        [self.provider follow];
    } else {
        [self.provider unfollow];
    }
}

@end
