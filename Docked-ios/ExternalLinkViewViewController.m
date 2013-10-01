//
//  ExternalLinkViewViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ExternalLinkViewViewController.h"

@interface ExternalLinkViewViewController ()

@end

@implementation ExternalLinkViewViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)setExternalLink:(NSString *)newExternalLink
{
    if (_externalLink != newExternalLink) {
        _externalLink = newExternalLink;
    }
}

-(IBAction)didTapExternalLinkButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_externalLink]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
