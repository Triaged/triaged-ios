//
//  ProviderViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "ProviderViewController.h"

@interface ProviderViewController ()

@end

@implementation ProviderViewController

@synthesize provider, providerFeedTableVC;

- (id)initWithProvider:(Provider *)newProvider
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        if (newProvider != provider) {
            provider = newProvider;
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = provider.shortTitle;
    
    UIBarButtonItem *ignoreButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(displaySettings)];
    [self.navigationItem setRightBarButtonItem:ignoreButton];
    
    providerFeedTableVC = [[ProviderFeedTableViewController alloc] init];
    providerFeedTableVC.provider = provider;
    providerFeedTableVC.view.frame = self.view.frame;
    
    [self addChildViewController:providerFeedTableVC];
    [self.view addSubview:providerFeedTableVC.view];
    [providerFeedTableVC didMoveToParentViewController:self];
    
}

-(void)displaySettings {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
