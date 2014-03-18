//
//  TeammateViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "TeammateViewController.h"
#import "TeammateFeedTableViewController.h"

@interface TeammateViewController ()

@end

@implementation TeammateViewController

@synthesize user, teammateFeedTableVC;

- (id)initWithUser:(User *)newUser
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        if (newUser != user) {
            user = newUser;
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    teammateFeedTableVC = [[TeammateFeedTableViewController alloc] init];
    teammateFeedTableVC.user = user;
    teammateFeedTableVC.view.frame = self.view.frame;
    
    [self addChildViewController:teammateFeedTableVC];
    [self.view addSubview:teammateFeedTableVC.view];
    [teammateFeedTableVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
