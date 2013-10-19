//
//  SettingEventsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/18/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "SettingEventsViewController.h"
#import "EventCell.h"

@interface SettingEventsViewController ()

@end

@implementation SettingEventsViewController

@synthesize eventsTableView, eventLabel, endLineView, pushLabel, events;

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
    
    // events
    eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, 20)];
    eventLabel.text = @"Events";
    [eventLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    eventLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [eventLabel setLineBreakMode: NSLineBreakByClipping];
    eventLabel.numberOfLines = 1;
    [self.view addSubview: eventLabel];
    
    pushLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 0, 60, 20)];
    pushLabel.text = @"Push";
    [pushLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
    pushLabel.textColor = [[UIColor alloc] initWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    [pushLabel setLineBreakMode: NSLineBreakByClipping];
    pushLabel.numberOfLines = 1;
    [self.view addSubview: pushLabel];
    
    
    UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
    UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
    lineView.frame = CGRectMake(0, 20, 320, 1);
    [self.view addSubview: lineView];
    
    // Events
    eventsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, 184)];
    eventsTableView.delegate = self;
    eventsTableView.dataSource = self;

    eventsTableView.scrollEnabled = NO;
    eventsTableView.allowsSelection = NO;
    eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [eventsTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:eventsTableView];
    
    UIImage *endLineSeparator = [UIImage imageNamed:@"line.png"];
    endLineView = [[UIImageView alloc] initWithImage:endLineSeparator];
    //[self.view addSubview: endLineView];

    // Do any additional setup after loading the view from its nib.
}

- (void) layoutSubviews
{
    
    //eventLabel.frame = CGRectMake(12, 380, 100, 20);
    
    // Layout Event Table size
    [eventsTableView layoutIfNeeded];
    CGRect frame = CGRectMake(eventsTableView.frame.origin.x, eventsTableView.frame.origin.y, eventsTableView.frame.size.width, [eventsTableView contentSize].height);
    eventsTableView.frame = frame;
    //endLineView.frame = CGRectMake(0, eventsTableView.frame.origin.y + eventsTableView.frame.size.height, 320, 1);
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

@end
