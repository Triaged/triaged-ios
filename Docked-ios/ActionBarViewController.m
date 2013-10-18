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
    
    // Message button
    UIImage *messageIcon = [UIImage imageNamed:@"icn_chat.png"];
    UIButton *messageLinkButton = [[UIButton alloc] initWithFrame:CGRectMake(14, 10, 30, 30)];
    [messageLinkButton setTintColor:[UIColor whiteColor]];
    [messageLinkButton setImage:messageIcon forState:UIControlStateNormal];
    [messageLinkButton addTarget:self action:@selector(didTapMessagesButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageLinkButton];
    
    // Share
    UIImage *shareIcon = [UIImage imageNamed:@"icn_share.png"];
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(96, 10, 30, 30)];
    shareButton.tintColor = [UIColor whiteColor];
    [shareButton setImage:shareIcon forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(didTapShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];

    // Task list
    UIImage *taskIcon = [UIImage imageNamed:@"icn_todo.png"];
    UIButton *taskButton = [[UIButton alloc] initWithFrame:CGRectMake(182, 10, 30, 30)];
    taskButton.tintColor = [UIColor whiteColor];
    [taskButton setImage:taskIcon forState:UIControlStateNormal];
    [taskButton addTarget:self action:@selector(didTapTodoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:taskButton];

    // External Link
    UIImage *safariIcon = [UIImage imageNamed:@"icn_safari.png"];
    UIButton *externalLinkButton = [[UIButton alloc] initWithFrame:CGRectMake(264, 10, 30, 30)];
    externalLinkButton.tintColor = [UIColor whiteColor];
    [externalLinkButton setImage:safariIcon forState:UIControlStateNormal];
    [externalLinkButton addTarget:self action:@selector(didTapExternalLinkButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:externalLinkButton];
    
    self.view.layer.shadowOffset = CGSizeMake(0, 1);
    self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.view.layer.shadowRadius = 3;
    self.view.layer.shadowOpacity = .5;
    CGRect shadowFrame =  CGRectMake(self.view.layer.bounds.origin.x, self.view.layer.bounds.origin.y + self.view.layer.bounds.size.height, self.view.layer.bounds.size.width, 2);
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.view.layer.shadowPath = shadowPath;

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

-(IBAction)didTapMessagesButton:(id)sender
{
    DetailViewController *detailVC = (DetailViewController *)self.parentViewController;
    [detailVC presentNewMessageVC];
}

-(IBAction)didTapShareButton:(id)sender
{
    [SVProgressHUD showErrorWithStatus:@"Oops, we haven't quite implemented sharing yet"];
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
