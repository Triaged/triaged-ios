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
    [self setupTableView];
    
}

- (void)setupTableView
{
    
    [self setupFetchedResultsController];
    
    // Appearance
    self.tableView.backgroundColor = [[UIColor alloc] initWithRed:239.0f/255.0f green:240.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    

    
    //self.tableView.directionalLockEnabled = true;
    
    // Refresh control
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    [refreshControl addTarget:[AppDelegate sharedDelegate].store action:@selector(fetchRemoteFeedItems) forControlEvents:UIControlEventValueChanged];
     self.refreshControl = refreshControl;
    // Pull to refresh control
    
    
    
//    
//	self.refreshIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_navbar.png"]];
//	self.customRefreshControl = [[CustomPullToRefreshControl alloc]
//                           initInScrollView:self.tableView
//                           activityIndicatorView:self.refreshIV];
//	self.customRefreshControl.backgroundColor = [UIColor clearColor];
//	self.customRefreshControl.tintColor = [UIColor clearColor];
//	self.customRefreshControl.strokeColor = [UIColor clearColor];
//	self.customRefreshControl.pullView = [[UIImageView alloc] initWithImage:self.refreshIV.image];
//	self.customRefreshControl.drawDiskWhenPulling = false;
//	self.customRefreshControl.enableDiskDripEffect = false;
//	self.customRefreshControl.stickToTopWhenRefreshing = false;
//	self.customRefreshControl.scrollUpToCancel = false;
//	self.customRefreshControl.refreshStyle = CustomPullToRefreshSpin;
//	self.customRefreshControl.refreshEasing = CustomPullToRefreshContinuous;
//    [self.customRefreshControl addTarget:self action:@selector(pulledToRefresh:)
//                  forControlEvents:UIControlEventValueChanged];
//    [self.customRefreshControl addTarget:self action:@selector(cancelledRefresh:)
//                  forControlEvents:UIControlEventTouchCancel];
    
   
}

///** @brief Pull to refresh was canceled */
//- (void)cancelledRefresh:(id)sender
//{
//	// Do something
//}
//
///** @brief Pull to refresh initiated */
//- (void)pulledToRefresh:(id)sender
//{
//	// Animate refreshIV while loading
//	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//	//CATransform3D transform = self.refreshIV.layer.transform;
//    CATransform3D transform = self.navigationItem.titleView.layer.transform;
//	transform.m34 = -1/500;
//	transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
//	animation.autoreverses = true;
//	animation.toValue = [NSValue valueWithCATransform3D:transform];
//	animation.duration = 0.3;
//	animation.repeatCount = HUGE_VALF;
//	[self.refreshIV.layer addAnimation:animation forKey:@"rotate"];
//    
//	// End refreshing after some time
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)),
//                   dispatch_get_main_queue(), ^(void){
//                       [self.customRefreshControl endRefreshing];
//                   });
//}

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

@end
