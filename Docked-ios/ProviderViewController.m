//
//  ProviderViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "ProviderViewController.h"

@interface ProviderViewController ()

@property (nonatomic, retain) UIImageView *navBarHairlineImageView;

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
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
//    
//    UIBarButtonItem *ignoreButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(displaySettings)];
//    [self.navigationItem setRightBarButtonItem:ignoreButton];
    
    providerFeedTableVC = [[ProviderFeedTableViewController alloc] init];
    providerFeedTableVC.provider = provider;
    providerFeedTableVC.view.frame = self.view.frame;
    
    [self addChildViewController:providerFeedTableVC];
    [self.view addSubview:providerFeedTableVC.view];
    [providerFeedTableVC didMoveToParentViewController:self];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)displaySettings {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
