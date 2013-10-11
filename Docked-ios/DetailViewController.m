//
//  DetailViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/26/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "DetailViewController.h"
#import "MessageTabViewController.h"
#import "MessagesTableViewController.h"
#import "ExternalLinkViewViewController.h"
#import "NewMessageViewController.h"
#import "CardCell.h"

@interface DetailViewController () {
    NewMessageViewController *newMessageVC;
    UIScrollView *scrollView;
    MessagesTableViewController *messagesVC;
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        newMessageVC = [[NewMessageViewController alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshView)
                                                     name:@"feedUpdated"
                                                   object:nil];
    }
    return self;
}

- (void)setDetailItem:(FeedItem *)newDetailItem
{
    if (_feedItem != newDetailItem) {
        _feedItem = newDetailItem;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [[UIColor alloc]
                                 initWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];

    UIImage * shareImage = [UIImage imageNamed:@"icn_share.png"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:shareImage style:UIBarButtonItemStyleDone target:nil action:nil];
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    UIView *contentView;
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,self.view.frame.size.height)];
    [scrollView addSubview:contentView];
    

    // Card View
    id<DataSourceItem> cellSource = (id<DataSourceItem>)_feedItem;
    Class cellClass = [ cellSource tableViewCellClass ] ;
    NSString * cellID = NSStringFromClass( cellClass ) ;
    CardCell *cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    cell.frame = CGRectMake(6, 0, 308, [cellClass heightOfContent:_feedItem] );
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [cell configureForItem:_feedItem];
    [contentView addSubview:cell];
    
    // External Link View
    ExternalLinkViewViewController *externalVC = [[ExternalLinkViewViewController alloc] init];
    [externalVC setExternalLink:[_feedItem htmlUrl]];
    externalVC.view.frame = CGRectMake(6, cell.frame.size.height, 308, 44);
    externalVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:externalVC];
    [contentView addSubview:externalVC.view];
    
    // Message Tab View
    MessageTabViewController *messageTabVC = [[MessageTabViewController alloc] init];
    messageTabVC.view.frame = CGRectMake(0, self.view.bounds.size.height - 44, 320, 44);
    messageTabVC.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addChildViewController:messageTabVC];
    [self.view addSubview:messageTabVC.view];

    // Messages Table View
     messagesVC = [[MessagesTableViewController alloc] init];
    //commentsVC.delegate = self;
    messagesVC.feedItem = _feedItem;
    [self addChildViewController:messagesVC];
    CGRect frame = CGRectMake(6, cell.frame.size.height + 44, 308.0, self.view.frame.size.height - (cell.frame.size.height + 44));
    messagesVC.tableView.frame = frame;
    [contentView  addSubview:messagesVC.tableView];
    [messagesVC didMoveToParentViewController:self];

}


-(void)viewDidLayoutSubviews
{
    [self setContentSize];
}

-(void)refreshView {
    [messagesVC refreshTableView];
    [self setContentSize];
}

-(void)setContentSize {
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, messagesVC.tableView.frame.origin.y + messagesVC.tableView.contentSize.height);
    scrollView.frame = self.view.frame;
}

-(void)presentNewMessageVC
{
    [newMessageVC setFeedItem:_feedItem];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newMessageVC ];
    nav.navigationBar.barTintColor = [[UIColor alloc] initWithRed:35.0f/255.0f green:36.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
    [self presentViewController:nav animated:YES completion:nil];
}

@end