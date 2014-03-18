//
//  TeammateFeedTableViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "TeammateFeedTableViewController.h"
#import "FetchedFeedItemsDataSource.h"
#import "MTLFeedItem.h"
#import "FeedSectionViewController.h"
#import "CardViewController.h"
#import "TeammateHeaderViewController.h"

@interface TeammateFeedTableViewController () <UITableViewDelegate>

@property (nonatomic, strong) FetchedFeedItemsDataSource *feedItemsDataSource;
@property (nonatomic, strong) NSFetchedResultsController *_fetchedResultsController;

@end

@implementation TeammateFeedTableViewController

@synthesize user, _fetchedResultsController;

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
    
    
    TeammateHeaderViewController *headerView = [[TeammateHeaderViewController alloc] init];
    headerView.user = user;
    self.tableView.tableHeaderView = headerView.view;
    
    self.feedItemsDataSource = [[FetchedFeedItemsDataSource alloc] init];
    self.feedItemsDataSource.fetchedResultsController = [self fetchedResultsController];
        self.feedItemsDataSource.tableViewController = self;
    self.tableView.dataSource = self.feedItemsDataSource;
    self.tableView.delegate = self.feedItemsDataSource;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchFeedItems) forControlEvents:UIControlEventValueChanged];
    
    [self fetchFeedItems];
}

- (void) fetchFeedItems {
    [user feedItemsWithCompletionHandler:^(NSArray *feedItems, NSError *error) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(user == %@)", user];
        
        _fetchedResultsController = [FeedItem MR_fetchAllSortedBy:@"timestamp"
                                                        ascending:NO
                                                    withPredicate:predicate
                                                          groupBy:@"sectionIdentifier"
                                                         delegate:self.feedItemsDataSource];
        _fetchedResultsController.fetchRequest.fetchBatchSize = 100;
    }
    return _fetchedResultsController;
}



@end
