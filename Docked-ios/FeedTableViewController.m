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
#import "DetailViewController.h"
#import "SmokescreenViewController.h"
#import "FetchedFeedItemsDataSource.h"

@interface FeedTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FetchedFeedItemsDataSource *fetchedFeedItemsDataSource;

@end

@implementation FeedTableViewController 

@synthesize navController;

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshFeed)
                                                     name:@"feedUpdated"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    
}

- (void)setupTableView
{
    
    [self setupFetchedResultsController];
    
    // Appearance
    self.tableView.backgroundColor = [[UIColor alloc] initWithRed:239.0f/255.0f green:240.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    // Refresh control
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    [refreshControl addTarget:[AppDelegate sharedDelegate].store action:@selector(fetchRemoteFeedItems) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;
}

- (void)setupFetchedResultsController
{
    self.fetchedFeedItemsDataSource = [[FetchedFeedItemsDataSource alloc] init];
    self.fetchedFeedItemsDataSource.fetchedResultsController = [AppDelegate sharedDelegate].store.feedItemsFetchedResultsController;
    self.tableView.dataSource = self.fetchedFeedItemsDataSource;
}


-(void)refreshFeed
{
    [self.fetchedFeedItemsDataSource.fetchedResultsController performFetch:NULL];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FeedItem *item;
    CardCell *cell;
    
    if(indexPath.row == 0) { // Feed Item
        item = [self.fetchedFeedItemsDataSource feedItemAtIndexPath:indexPath];
        cell = (CardCell *)[tableView cellForRowAtIndexPath:indexPath];
    } else {
        item = [self.fetchedFeedItemsDataSource feedItemAtForMessageIndexPath:indexPath];
        cell = (CardCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    }
    
    
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, cell.opaque, 0.0);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *cardImageView = [[UIImageView alloc] initWithImage:viewImage];
    cardImageView.backgroundColor = [UIColor whiteColor];
    cardImageView.frame = [cell.contentView convertRect:cell.contentView.frame toView:nil];

    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [detailVC setFeedItem:item];
    detailVC.actionBarVC.screenShot = viewImage;
    
    SmokescreenViewController *ssVC = [[SmokescreenViewController alloc] init];
    [ssVC setCardImageView:cardImageView];
    [ssVC setDetailViewController:detailVC];
    [ssVC setNavController:navController];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ssVC ];
    nav.navigationBar.barTintColor = [[UIColor alloc] initWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];

    
    [self presentViewController:nav animated:NO completion:nil];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   if (indexPath.row == 0) {
        FeedItem *item = [self.fetchedFeedItemsDataSource feedItemAtIndexPath:indexPath];
       
       id<DataSourceItem> cellSource = (id<DataSourceItem>)item;
        Class cellClass = [ cellSource tableViewCellClass ] ;
       
       return [cellClass heightOfContent:item];

   } else if (indexPath.row == 1) {
       FeedItem *item = [self.fetchedFeedItemsDataSource feedItemAtForMessageIndexPath:indexPath];
       Message *message = [item previewMessage];
       
       return [MessageCell heightOfContent:message hasMultipleMessages:[item hasMultipleMessages]];
   } else {
        return 140;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

@end
