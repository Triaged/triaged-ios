//
//  ProviderHeaderViewController.m
//  Triage-ios
//
//  Created by Charlie White on 3/3/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "ProviderHeaderViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProviderHeaderViewController ()

@end

@implementation ProviderHeaderViewController

@synthesize providerIconView, providerNameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BG_COLOR;
    
    // Do any additional setup after loading the view from its nib.
    NSURL *iconUrl = [NSURL URLWithString:self.provider.largeIcon];
    [providerIconView setImageWithURL:iconUrl];
    providerNameLabel.text = self.provider.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
