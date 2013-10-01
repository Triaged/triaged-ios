//
//  FeedTableViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FeedTableViewController.h"
#import "DockedAPIClient.h"
#import "FeedItem.h"
#import "CardCell.h"
#import "DetailViewController.h"
#import "SmokescreenViewController.h"

@interface FeedTableViewController () {
    NSMutableArray *_objects;
}

@end

@implementation FeedTableViewController

@synthesize navController;

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadFeedItems)
                                                     name:@"login"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];

    _objects = [[NSMutableArray alloc] init];
    [self loadFeedItems];
}

-(void)setupTableView {
    self.tableView.backgroundColor = [[UIColor alloc] initWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(loadFeedItems) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;

}

-(void)loadFeedItems {
    [[DockedAPIClient sharedClient] GET:@"feed.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        NSArray *results = [JSON valueForKeyPath:@"feed"];
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:FeedItem.class];
        _objects = [transformer transformedValue:results];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure");
    }];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedItem *item = _objects[indexPath.row];

    // Determine the cell class
    id<DataSourceItem> cellSource = (id<DataSourceItem>)item;
    Class cellClass = [ cellSource tableViewCellClass ] ;
    NSString * cellID = NSStringFromClass( cellClass ) ;
    CardCell *cell = [ tableView dequeueReusableCellWithIdentifier:cellID ] ;
    if ( !cell )
    {
        cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    }
    // Configure the cell...
    [cell configureForItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedItem *item = _objects[indexPath.row];
    
    
    CardCell *cell = (CardCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    UIGraphicsBeginImageContextWithOptions(cell.contentView.bounds.size, cell.contentView.opaque, 0.0);
    [cell.contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *cardImageView = [[UIImageView alloc] initWithImage:viewImage];
    cardImageView.backgroundColor = [UIColor whiteColor];
    cardImageView.frame = [cell.contentView convertRect:cell.contentView.frame toView:nil];

    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [detailVC setFeedItem:item];
    [detailVC setContentView:cell.contentView];
    
    
    
    SmokescreenViewController *ssVC = [[SmokescreenViewController alloc] init];
    [ssVC setCardImageView:cardImageView];
    [ssVC setDetailViewController:detailVC];
    [ssVC setNavController:navController];
    [self presentViewController:ssVC animated:NO completion:nil];
    //[navController pushViewController:ssVC animated:NO];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CardCell *cell = (CardCell *)[tableView cellForRowAtIndexPath:indexPath];
//    return [cell.class estimatedHeightOfContent];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = @"blah blah";
    
    FeedItem *item = _objects[indexPath.row];
    id<DataSourceItem> cellSource = (id<DataSourceItem>)item;
    Class cellClass = [ cellSource tableViewCellClass ] ;
    return [cellClass heightOfContent:content];

}
@end
