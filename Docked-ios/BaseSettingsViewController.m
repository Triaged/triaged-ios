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

@synthesize scrollView, providerHeroImageView, eventsTableView, events, eventLabel, connectButton, followButton, connectedLabel, endLineView, pushLabel;

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
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    //scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.providerHeroImageView = [[UIImageView alloc] init];
    self.providerHeroImageView.frame = CGRectMake(45, 6, 230, 125);
    [scrollView addSubview:self.providerHeroImageView];
    
    // Connect Button
    connectButton = [[UIButton alloc] init];
    connectButton.frame = CGRectMake(24, 170, 272, 38);
    connectButton.layer.cornerRadius = 6; // this value vary as per your desire
    connectButton.clipsToBounds = YES;
    [connectButton addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
    // Follow Button
    followButton = [[UIButton alloc] init];
    followButton.frame = CGRectMake(64, 170, 192, 38);
    followButton.layer.cornerRadius = 3; // this value vary as per your desire
    followButton.clipsToBounds = YES;
    [followButton setBackgroundColor:
                        [UIColor colorWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f]];
    [followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [followButton addTarget:self action:@selector(toggleFollow) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *followTitle = ([self isFollowing] ? @"Following" : @"Follow");
    [followButton setTitle:followTitle forState:UIControlStateNormal];
    
    followButton.selected = [self isFollowing];
    
    // Connected State
    ([self isConnected] ?  [self setupConnectedState] : [self setupUnconnectedState]);

    // events
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 240, 100, 20)];
    eventLabel.text = @"Events";
    [eventLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    eventLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [eventLabel setLineBreakMode: NSLineBreakByClipping];
    eventLabel.numberOfLines = 1;
    [scrollView addSubview: eventLabel];
    
    pushLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 240, 60, 20)];
    pushLabel.text = @"Push";
    [pushLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    pushLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [pushLabel setLineBreakMode: NSLineBreakByClipping];
    pushLabel.numberOfLines = 1;
    [scrollView addSubview: pushLabel];

    
    UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView.frame = CGRectMake(0, 260, 320, 1);
    [scrollView addSubview: lineView];
    
    // Team Members
    eventsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 260, 320, 184)];
    eventsTableView.delegate = self;
    eventsTableView.dataSource = self;
    eventsTableView.scrollEnabled = NO;
    eventsTableView.allowsSelection = NO;
    eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [eventsTableView setSeparatorInset:UIEdgeInsetsZero];
    [scrollView addSubview:eventsTableView];
    
    UIImage *endLineSeparator = [UIImage imageNamed:@"line.png"];
    endLineView = [[UIImageView alloc] initWithImage:endLineSeparator];
    [scrollView addSubview: endLineView];

    
}

-(void)setupConnectedState
{
    UIImage *connectedStatusImage = [UIImage imageNamed:@"status_connected.png"];
    UIImageView *connectedStatusView = [[UIImageView alloc] initWithImage:connectedStatusImage];
    connectedStatusView.frame = CGRectMake(110, 152, 8, 8);
    [scrollView addSubview:connectedStatusView];
    
    connectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 146, 80, 20)];
    [connectedLabel setText:@"Connected"];
    [connectedLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:13.0]];
    connectedLabel.textColor = [[UIColor alloc] initWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
    [scrollView addSubview:connectedLabel];
    
    // remove views
    [connectButton removeFromSuperview];
}

-(void)setupUnconnectedState
{
    
}

- (void) layoutSubviews
{
    
    eventLabel.frame = CGRectMake(12, 380, 100, 20);
    
    // Layout Event Table size
    [eventsTableView layoutIfNeeded];
    CGRect frame = CGRectMake(eventsTableView.frame.origin.x, eventsTableView.frame.origin.y, eventsTableView.frame.size.width, [eventsTableView contentSize].height);
    eventsTableView.frame = frame;
    endLineView.frame = CGRectMake(0, eventsTableView.frame.origin.y + eventsTableView.frame.size.height, 320, 1);
}

- (void) viewDidLayoutSubviews
{
    [self setContentSize];
}

-(void)setContentSize {
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, eventsTableView.frame.origin.y + eventsTableView.contentSize.height + 200);
    scrollView.frame = self.view.frame;
}

- (BOOL) isConnected
{
    return self.provider.connected;
}

- (BOOL) isFollowing;
{
    return self.provider.follows;
}

-(void) toggleFollow
{
    if ([self isFollowing]) {
        [self.provider unfollow];
        [followButton setTitle:@"Follow" forState:UIControlStateNormal];
    } else {
        [self.provider follow];
        [followButton setTitle:@"Following" forState:UIControlStateNormal];
    }
    [followButton setNeedsDisplay];
    [[AppDelegate sharedDelegate].navVC showSGProgressWithDuration:1.5];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return events.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"eventCell";
    EventCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ EventCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
        NSArray *event = events[indexPath.row];
        cell.eventLabel.text = event[0];
        [cell.pushNotificationSwitch setOn:([event[1] boolValue] ? YES : NO)];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
