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
    self.view.backgroundColor =  [UIColor whiteColor];
    
    // Line Separator
    UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView.frame = CGRectMake(6, 0, 296, 1);
    [self.view addSubview: lineView];
    
    // Safari image
    UIImage *safariIcon = [UIImage imageNamed:@"icn_safari.png"];
    UIImageView *safariIconView = [[UIImageView alloc] initWithImage:safariIcon];
    safariIconView.frame = CGRectMake(15, 15, 16, 16);
    [self.view addSubview: safariIconView];

    
    
    UIButton *externalLinkButton = [[UIButton alloc] initWithFrame:CGRectMake(48,13, 118, 21)];
    externalLinkButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:15.0];
    [externalLinkButton setTitleColor:[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [externalLinkButton addTarget:self action:@selector(didTapExternalLinkButton:) forControlEvents:UIControlEventTouchUpInside];
    [externalLinkButton setTitle:@"View on Github" forState:UIControlStateNormal];
    [self.view addSubview:externalLinkButton];
}

- (void)setExternalLink:(NSString *)newExternalLink
{
    if (_externalLink != newExternalLink) {
        _externalLink = newExternalLink;
    }
}

-(IBAction)didTapExternalLinkButton:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_externalLink]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
