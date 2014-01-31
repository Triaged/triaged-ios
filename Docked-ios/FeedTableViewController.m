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




@interface FeedTableViewController () <UITableViewDelegate>

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
    self.tableView.delegate = self;
    
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
    
        
    [self setupFetchedResultsController];
    
    // Appearance
    //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self.tableView setSeparatorInset:UIEdgeInsetsZero];
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






- (void)setupFetchedResultsController
{
    self.feedItemsDataSource = [[FeedItemsDataSource alloc] init];
    self.tableView.dataSource = self.feedItemsDataSource;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MTLFeedItem * item = [self.feedItemsDataSource itemAtIndexPath:indexPath];
    
    CardViewController *detailVC = [[CardViewController alloc] init];
    [detailVC setFeedItem:item];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.feedItemsDataSource.sortedDays objectAtIndex:section];
    
    FeedSectionViewController *feedSectionVC = [[FeedSectionViewController alloc] initWithDate:dateRepresentingThisDay];

    return feedSectionVC.view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 != 1)
        return 6;
    
    MTLFeedItem *item = [self.feedItemsDataSource itemAtIndexPath:indexPath];
    Class cellClass = item.itemCellClass;
    
    return [cellClass heightOfContent:item];
   
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 != 1)
        return 6;
    return 180;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 42;
}

@end
