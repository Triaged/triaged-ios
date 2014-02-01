//
//  TeammateFeedTableViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "TeammateFeedTableViewController.h"
#import "FeedItemsDataSource.h"
#import "MTLFeedItem.h"
#import "FeedSectionViewController.h"
#import "CardViewController.h"

@interface TeammateFeedTableViewController () <UITableViewDelegate>

@property (nonatomic, strong) FeedItemsDataSource *feedItemsDataSource;

@end

@implementation TeammateFeedTableViewController

@synthesize user;

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
    
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.feedItemsDataSource = [[FeedItemsDataSource alloc] init];
    self.feedItemsDataSource.tableViewController = self;
    self.tableView.dataSource = self.feedItemsDataSource;
    self.tableView.delegate = self.feedItemsDataSource;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchFeedItems) forControlEvents:UIControlEventValueChanged];
    
    [self fetchFeedItems];
}

- (void) fetchFeedItems {
    [self.refreshControl beginRefreshing];
    
    [user fetchTeammateFeedItemsWithParams:nil andBlock:^(NSArray * feedItems) {
        [self.feedItemsDataSource setFeedItems:feedItems];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}


@end
