//
//  MessagesTableViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MessagesTableViewController.h"
#import "MessageCell.h"
#import "FetchedMessagesDataSource.h"

@interface MessagesTableViewController ()

@property (nonatomic, strong) FetchedMessagesDataSource *fetchedMessagesDataSource;

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
    
    [self setupFetchedResultsController];
    self.view.backgroundColor = [[UIColor alloc]
                                 initWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.tableView.scrollEnabled = NO;
    
}

- (void)setupFetchedResultsController
{
    self.fetchedMessagesDataSource = [[FetchedMessagesDataSource alloc] init];
    self.fetchedMessagesDataSource.fetchedResultsController = feedItem.messagesFetchedResultsController;
    self.tableView.dataSource = self.fetchedMessagesDataSource;
    self.fetchedMessagesDataSource.fetchedResultsController.delegate = self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView layoutIfNeeded];
    CGRect frame = CGRectMake(0, self.tableView.frame.origin.y, 320.0, [self.tableView contentSize].height);
    self.tableView.frame = frame;
}

-(void)refreshTableView
{
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    CGRect frame = CGRectMake(0, self.tableView.frame.origin.y, 320.0, [self.tableView contentSize].height);
    self.tableView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Message *message = [self.fetchedMessagesDataSource messageAtIndexPath:indexPath];
    return [MessageCell heightOfContent:message hasMultipleMessages:NO];
    
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

@end
