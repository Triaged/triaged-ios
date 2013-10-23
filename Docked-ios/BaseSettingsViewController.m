//
//  BaseSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/11/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "BaseSettingsViewController.h"
#import "EventCell.h"
#import "AppDelegate.h"
#import "UINavigationController+SGProgress.h"


@interface BaseSettingsViewController ()

@end

@implementation BaseSettingsViewController

@synthesize scrollView, providerHeroImageView, connectButton, connectedLabel, eventsViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        eventsViewController = [[SettingEventsViewController alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    //scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.providerHeroImageView = [[UIImageView alloc] init];
    self.providerHeroImageView.frame = CGRectMake(45, 0, 230, 125);
    [scrollView addSubview:self.providerHeroImageView];
    
    // Connect Button
    connectButton = [[UIButton alloc] init];
    connectButton.frame = CGRectMake(24, 115, 272, 38);
    connectButton.layer.cornerRadius = 6; // this value vary as per your desire
    connectButton.clipsToBounds = YES;
    [connectButton addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
    // Connected State
    ([self isConnected] ?  [self setupConnectedState] : [self setupUnconnectedState]);

    
}

-(void)setupConnectedState
{
    // remove views
    [connectButton removeFromSuperview];
    
    UIImage *connectedStatusImage = [UIImage imageNamed:@"status_connected.png"];
    UIImageView *connectedStatusView = [[UIImageView alloc] initWithImage:connectedStatusImage];
    connectedStatusView.frame = CGRectMake(118, 100, 8, 8);
    [scrollView addSubview:connectedStatusView];
    
    connectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(127.5, 94, 65, 20)];
    [connectedLabel setText:@"Connected"];
    [connectedLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:13.0]];
    connectedLabel.textColor = [[UIColor alloc] initWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
    [scrollView addSubview:connectedLabel];
}

-(void)setupUnconnectedState
{
    
}

- (void) layoutSubviews
{
    
    //eventLabel.frame = CGRectMake(12, 380, 100, 20);
    
    // Layout Event Table size
    [eventsViewController.eventsTableView layoutIfNeeded];
    CGRect frame = CGRectMake(eventsViewController.eventsTableView.frame.origin.x, eventsViewController.eventsTableView.frame.origin.y, eventsViewController.eventsTableView.frame.size.width, [eventsViewController.eventsTableView contentSize].height);
    eventsViewController.eventsTableView.frame = frame;
    eventsViewController.eventsTableView.frame = CGRectMake(0, eventsViewController.eventsTableView.frame.origin.y + eventsViewController.eventsTableView.frame.size.height, 320, 1);
}

- (void) viewDidLayoutSubviews
{
    [self setContentSize];
}

-(void)setContentSize {
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, eventsViewController.eventsTableView.frame.origin.y + eventsViewController.eventsTableView.contentSize.height + 200);
    scrollView.frame = self.view.frame;
}

- (BOOL) isConnected
{
    return self.provider.connected;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
