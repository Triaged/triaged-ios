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

@property (nonatomic, strong) NSDictionary *settings;

@end

@implementation GithubSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _settings = [[AppDelegate sharedDelegate].store.account.providers valueForKey:@"github"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    
    //BOOL following = [AppDelegate sharedDelegate].store.account.userID;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectToGithub {
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:@"http://cwhite.local:3000/services/authenticate_for/github"];
    [self.navigationController presentViewController:oAuthVC animated:YES completion:nil];
}



@end
