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
#import "FeedItemTableViewCell.h"
#import "TextCardViewController.h"
#import "RNBlurModalView.h"

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

    _objects = [[NSMutableArray alloc] init];
    self.tableView.backgroundColor = [[UIColor alloc]
                                      initWithRed:204.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:1.0f];
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedItemTableViewCell"
                                               bundle:[NSBundle mainBundle]]
                                                forCellReuseIdentifier:@"feedItemCell"];
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(loadFeedItems) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self loadFeedItems];
}

-(void)loadFeedItems {
    
    [[DockedAPIClient sharedClient] GET:@"feed/mock.json" parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
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
    static NSString *CellIdentifier = @"feedItemCell";
    FeedItemTableViewCell *cell = (FeedItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.layer.shadowOffset = CGSizeMake(6, 6);
    cell.layer.shadowColor = [[[UIColor alloc] initWithRed:190.0f/255.0f green:190.0f/255.0f blue:190.0f/255.0f alpha:1.0f] CGColor];

    cell.layer.shadowRadius = 6;
    cell.layer.shadowOpacity = 0.75f;
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];/// change size as you need.
    separatorLineView.backgroundColor = [[UIColor alloc] initWithRed:204.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:1.0f];
    [cell.contentView addSubview:separatorLineView];
    
    
    CGRect shadowFrame = cell.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    cell.layer.shadowPath = shadowPath;

    // Configure the cell...
    FeedItem *item = _objects[indexPath.row];
    cell.titleLabel.text = [item titleLabel];
    cell.bodyLabel.text = [item bodyLabel];
    cell.iconImage.image = [item icon];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedItem *item = _objects[indexPath.row];
//    CardViewController detailClass = (Class)[item detailViewControllerClass];
    TextCardViewController *detailVC = [[TextCardViewController alloc] init];
    [detailVC setDetailItem:item];
    
    //[navController presentViewController:detailVC animated:YES completion:nil];
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self view:detailVC.view];
    [modal show];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
@end
