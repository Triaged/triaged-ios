//
//  BaseSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/11/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "BaseSettingsViewController.h"
#import "EventCell.h"

@interface BaseSettingsViewController ()

@end

@implementation BaseSettingsViewController

@synthesize providerHeroImageView, eventsTableView, events, eventLabel, connectButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView = [[UIImageView alloc] init];
    self.providerHeroImageView.frame = CGRectMake(100, 70, 104, 134);
    [self.view addSubview:self.providerHeroImageView];
    
    // Connect Button
    connectButton = [[UIButton alloc] init];
    connectButton.frame = CGRectMake(24, 240, 272, 38);
    connectButton.layer.cornerRadius = 6; // this value vary as per your desire
    connectButton.clipsToBounds = YES;
    //[connectButton addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    // events
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 320, 100, 20)];
    eventLabel.text = @"Events";
    [eventLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    eventLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [eventLabel setLineBreakMode: NSLineBreakByClipping];
    eventLabel.numberOfLines = 1;
    [self.view addSubview: eventLabel];
    
    UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView.frame = CGRectMake(0, 340, 320, 1);
    [self.view addSubview: lineView];
    
    // Team Members
    eventsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 340, 320, 184)];
    eventsTableView.delegate = self;
    eventsTableView.dataSource = self;
    eventsTableView.scrollEnabled = NO;
    eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [eventsTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:eventsTableView];
    
    
    UIImage *endLineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *endLineView = [[UIImageView alloc] initWithImage:endLineSeparator];
    endLineView.frame = CGRectMake(0, 524, 320, 1);
    [self.view addSubview: endLineView];

    

}

- (void) layoutSubviews
{
    eventLabel.frame = CGRectMake(12, 380, 100, 20);
}

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
    
        NSString *event = events[indexPath.row];
        cell.eventLabel.text = event;

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
