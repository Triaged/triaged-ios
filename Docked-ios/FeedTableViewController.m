//
//  FeedTableViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FeedTableViewController.h"
#import "AppDelegate.h"
#import "Store.h"
#import "DockedAPIClient.h"
#import "FeedItem.h"
#import "CardCell.h"
#import "CardViewController.h"
#import "FeedItemsDataSource.h"
#import "UITableView+NXEmptyView.h"
#import "EmptyFeedViewController.h"
#import "BaseCard.h"
#import "MTLProvider.h"
#import "FeedItemCell.h"
#import "ProviderViewController.h"
#import "FeedSectionViewController.h"
#import "FetchedFeedItemsDataSource.h"




@interface FeedTableViewController () 

@property (nonatomic, strong) FetchedFeedItemsDataSource *feedItemsDataSource;
@property (nonatomic, strong) UIImageView* refreshIV;
@end

@implementation FeedTableViewController{
    NSFetchedResultsController *_fetchedResultsController;
}



@synthesize navController, rootController;

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(fetchFeedItems)
                                                     name:@"feedUpdated"
                                                   object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self setupTableView];

    EmptyFeedViewController *emptyVC = [[EmptyFeedViewController alloc] init];
    self.tableView.nxEV_emptyView = emptyVC.view;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchFeedItems) forControlEvents:UIControlEventValueChanged];
    
    [self fetchFeedItems];

}

-(void)viewWillAppear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden: YES animated:YES];
}

- (void)setupTableView
{
    self.feedItemsDataSource = [[FetchedFeedItemsDataSource alloc] init];
    self.feedItemsDataSource.fetchedResultsController = [self fetchedResultsController];
    self.feedItemsDataSource.tableViewController = self;
    self.tableView.dataSource = self.feedItemsDataSource;
    self.tableView.delegate = self.feedItemsDataSource;
    
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void) fetchFeedItems {
    [FeedItem feedItemsWithCompletionHandler:^(NSArray *feedItems, NSError *error) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}


- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [FeedItem MR_fetchAllSortedBy:@"timestamp"
                                                   ascending:NO
                                               withPredicate:nil
                                                     groupBy:@"sectionIdentifier"
                                                    delegate:self.feedItemsDataSource];
        _fetchedResultsController.fetchRequest.fetchBatchSize = 100;
    }
    return _fetchedResultsController;
}




@end
