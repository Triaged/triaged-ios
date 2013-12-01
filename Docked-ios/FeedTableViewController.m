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
#import "CustomPullToRefreshControl.h"
#import "UITableView+NXEmptyView.h"
#import "EmptyFeedViewController.h"
#import "UIScrollView+UzysCircularProgressPullToRefresh.h"

@interface FeedTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FetchedFeedItemsDataSource *fetchedFeedItemsDataSource;
@property (nonatomic, strong) CustomPullToRefreshControl* customRefreshControl;
@property (nonatomic, strong) UIImageView* refreshIV;

@end

@implementation FeedTableViewController 

@synthesize navController, rootController;

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
    

    self.view.backgroundColor = BG_COLOR;
    [self setupTableView];
    self.tableView.delegate = self;

    EmptyFeedViewController *emptyVC = [[EmptyFeedViewController alloc] init];
    self.tableView.nxEV_emptyView = emptyVC.view;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Account for Status bar
    CGRect frame = self.view.frame;
    frame.origin.y = 20;
    self.tableView.frame = frame;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: YES animated:YES];
    
    //Because of self.automaticallyAdjustsScrollViewInsets you must add code below in viewWillApper
    [self.tableView addPullToRefreshActionHandler:^{
        [[AppDelegate sharedDelegate].store fetchRemoteFeedItems];
    }];
    
    [self.tableView.pullToRefreshView setImageIcon:[UIImage imageNamed:@"triangle.png"]];
    [self.tableView.pullToRefreshView setSize:CGSizeMake(30, 26.5)];
    [self.tableView.pullToRefreshView setBorderWidth:0];
    

    
    }

- (void)setupTableView
{
    
    [self setupFetchedResultsController];
    
    // Appearance
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    
    
    // Refresh control
//    UIRefreshControl *refreshControl = [UIRefreshControl new];
//    refreshControl.tintColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
//    [refreshControl addTarget:[AppDelegate sharedDelegate].store action:@selector(fetchRemoteFeedItems) forControlEvents:UIControlEventValueChanged];
//     self.refreshControl = refreshControl;
    // Pull to refresh control
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
    [self.tableView stopRefreshAnimation];
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
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ssVC ];
//    nav.navigationBar.barTintColor = [[UIColor alloc] initWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];

    
    [self.navController pushViewController:ssVC animated:NO];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   if (indexPath.row == 0) {
       FeedItem *item = [self.fetchedFeedItemsDataSource feedItemAtIndexPath:indexPath];
       
       NSEntityDescription *entityDescription = item.entity;
       NSString *cellID = entityDescription.userInfo[@"cell"];
       Class cellClass = NSClassFromString(cellID);
       
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

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    if( [scrollView.panGestureRecognizer translationInView:self.view].y  < 0.0f ) {
//        [[self navigationController] setNavigationBarHidden:YES animated:YES];
//    } else if ([scrollView.panGestureRecognizer translationInView:self.view].y  > 0.0f  ) {
//            [[self navigationController] setNavigationBarHidden:NO animated:YES];
//
//    }
//    
//  
//    
//}

@end
