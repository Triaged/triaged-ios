//
//  MessagesTableViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MessagesTableViewController.h"
#import "MessageCell.h"

@interface MessagesTableViewController ()

@end

@implementation MessagesTableViewController

@synthesize feedItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc]
                                 initWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.tableView.scrollEnabled = NO;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView layoutIfNeeded];
    CGRect frame = CGRectMake(6, self.tableView.frame.origin.y, 308.0, [self.tableView contentSize].height);
    self.tableView.frame = frame;
}

-(void)refreshTableView
{
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    CGRect frame = CGRectMake(6, self.tableView.frame.origin.y, 308.0, [self.tableView contentSize].height);
    self.tableView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return feedItem.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageCell";
    MessageCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ MessageCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    Message *message = feedItem.sortedMessages[indexPath.row];
    
    cell.authorLabel.text = message.authorName;
    cell.bodyLabel.text = message.body;
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Message *message = feedItem.sortedMessages[indexPath.row];
    return [MessageCell heightOfContent:message];
    
}

@end
