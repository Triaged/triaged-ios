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
#import "Provider.h"
#import "FeedItemCell.h"
#import "ProviderViewController.h"
#import "FeedSectionViewController.h"




@interface FeedTableViewController () 

@property (nonatomic, strong) FeedItemsDataSource *feedItemsDataSource;
@property (nonatomic, strong) UIImageView* refreshIV;


@end

@implementation FeedTableViewController 

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
    
    self.title = @"Home";
    
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
    self.feedItemsDataSource = [[FeedItemsDataSource alloc] init];
    self.feedItemsDataSource.tableViewController = self;
    self.tableView.dataSource = self.feedItemsDataSource;
    self.tableView.delegate = self.feedItemsDataSource;
    
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void) fetchFeedItems {
    [self.refreshControl beginRefreshing];
    
    NSDictionary *params;
    [MTLFeedItem fetchNewRemoteFeedItemsWithParams:params andBlock:^(NSArray * feedItems) {
        [self.feedItemsDataSource setFeedItems:feedItems];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}




@end
