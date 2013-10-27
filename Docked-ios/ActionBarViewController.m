//
//  ExternalLinkViewViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ActionBarViewController.h"
#import "DetailViewController.h"
#import "SVProgressHUD.h"

@interface ActionBarViewController ()

@end

@implementation ActionBarViewController

@synthesize screenShot;

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
    self.view.backgroundColor =  [[UIColor alloc] initWithRed:249.0f/255.0f green:249.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
//    self.view.backgroundColor = [[UIColor alloc] initWithRed:122.0f/255.0f green:141.0f/255.0f blue:196.0f/255.0f alpha:0.6f];
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];/// change size as you need.
    separatorLineView.backgroundColor = [[UIColor alloc] initWithRed:241.0f/255.0f green:241.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    [self.view addSubview:separatorLineView];
    
    
    // Explore
    UIImage *exploreIcon = [UIImage imageNamed:@"icn_explore.png"];
    UIButton *exploreLinkButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 8, 81, 30)];
    [exploreLinkButton setTitle:@"  explore" forState:UIControlStateNormal];
    [exploreLinkButton setImage:exploreIcon forState:UIControlStateNormal];
    exploreLinkButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0];
    [exploreLinkButton setTitleColor:[[UIColor alloc] initWithRed:122.0f/255.0f green:141.0f/255.0f blue:196.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [exploreLinkButton addTarget:self action:@selector(didTapExternalLinkButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exploreLinkButton];
    
    // Assign
    UIImage *assignIcon = [UIImage imageNamed:@"icn_assign.png"];
    UIButton *assignButton = [[UIButton alloc] initWithFrame:CGRectMake(114, 8, 78, 30)];
    [assignButton setTitle:@"  assign" forState:UIControlStateNormal];
    [assignButton setImage:exploreIcon forState:UIControlStateNormal];
    assignButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0];
    [assignButton setTitleColor:[[UIColor alloc] initWithRed:122.0f/255.0f green:141.0f/255.0f blue:196.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [assignButton setImage:assignIcon forState:UIControlStateNormal];
    [assignButton addTarget:self action:@selector(didTapTodoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:assignButton];

    
    // Share
    UIImage *shareIcon = [UIImage imageNamed:@"icn_share.png"];
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(231, 8, 66, 30)];
    [shareButton setTitle:@"  share" forState:UIControlStateNormal];
    [shareButton setImage:exploreIcon forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0];
    [shareButton setTitleColor:[[UIColor alloc] initWithRed:122.0f/255.0f green:141.0f/255.0f blue:196.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [shareButton setImage:shareIcon forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(didTapShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    
    UIView* separator1LineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, self.view.frame.size.width, 1)];/// change size as you need.
    separator1LineView.backgroundColor = [[UIColor alloc] initWithRed:241.0f/255.0f green:241.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    [self.view addSubview:separator1LineView];

    
//    self.view.layer.shadowOffset = CGSizeMake(0, 1);
//    self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.view.layer.shadowRadius = 3;
//    self.view.layer.shadowOpacity = .5;
//    CGRect shadowFrame =  CGRectMake(self.view.layer.bounds.origin.x, self.view.layer.bounds.origin.y + self.view.layer.bounds.size.height, self.view.layer.bounds.size.width, 2);
//    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
//    self.view.layer.shadowPath = shadowPath;

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

-(IBAction)didTapShareButton:(id)sender
{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:@"Your Note.", screenShot, @"Sent with Triage. (triaged.co)", nil] applicationActivities:nil];
    activityVC.excludedActivityTypes = @[ UIActivityTypeAddToReadingList, UIActivityTypePostToTwitter, UIActivityTypePostToFacebook, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
}


-(IBAction)didTapTodoButton:(id)sender
{
    [SVProgressHUD showErrorWithStatus:@"Oops, we haven't quite implemented assigning to task lists yet"];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
