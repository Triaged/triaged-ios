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
    self.tableView.dataSource = self.feedItemsDataSource;
    self.tableView.delegate = self;
    
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
    return 200;
    //return [cellClass heightOfContent:item];
    
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
