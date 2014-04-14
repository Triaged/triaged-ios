//
//  ProviderFeedTableViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "ProviderFeedTableViewController.h"
#import "FetchedFeedItemsDataSource.h"
#import "MTLFeedItem.h"
#import "FeedSectionViewController.h"
#import "CardViewController.h"
#import "ProviderHeaderViewController.h"

@interface ProviderFeedTableViewController () <UITableViewDelegate>

@property (nonatomic, strong) FetchedFeedItemsDataSource *feedItemsDataSource;
@property (nonatomic, strong) NSFetchedResultsController *_fetchedResultsController;

@end

@implementation ProviderFeedTableViewController

@synthesize provider, _fetchedResultsController;

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
    
    self.feedItemsDataSource = [[FetchedFeedItemsDataSource alloc] init];
    self.feedItemsDataSource.fetchedResultsController = [self fetchedResultsController];
    self.feedItemsDataSource.tableViewController = self;
    self.tableView.dataSource = self.feedItemsDataSource;
    self.tableView.delegate = self.feedItemsDataSource;
    
    ProviderHeaderViewController *providerHeaderVC = [[ProviderHeaderViewController alloc] init];
    providerHeaderVC.provider = provider;
    self.tableView.tableHeaderView = providerHeaderVC.view;
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchFeedItems) forControlEvents:UIControlEventValueChanged];
    
    // Load local records first, then find new items
    [self fetchFeedItems];
}

- (void) fetchFeedItems {
    [provider feedItemsWithCompletionHandler:^(NSArray *feedItems, NSError *error) {
        [[self fetchedResultsController] performFetch:nil];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(provider == %@)", provider];
        
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
