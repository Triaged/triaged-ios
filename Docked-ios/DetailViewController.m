//
//  DetailViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/26/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "DetailViewController.h"
#import "MessagesTableViewController.h"
#import "MessageToolbarViewController.h"
#import "CardCell.h"
#import "UIView+BlurredSnapshot.h"
#import "DetailView.h"
#import "AppDelegate.h"

@interface DetailViewController () {
    MessagesTableViewController *messagesVC;
    MessageToolbarViewController *messageToolbarVC;
}

@end

@implementation DetailViewController

@synthesize scrollView, actionBarVC, gestureRecognizer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(refreshView)
                                                     name:@"feedUpdated"
                                                   object:nil];
        actionBarVC = [[ActionBarViewController alloc] init];
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
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;

    self.view.backgroundColor = [[UIColor alloc]
                                 initWithRed:239.0f/255.0f green:240.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    self.view.layer.zPosition = -9999;
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height - 40);
    scrollView.layer.zPosition = -9999;
    scrollView.userInteractionEnabled=YES;
    [self.view addSubview:scrollView];
    
    UIView *contentView;
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,self.view.frame.size.height)];
    [scrollView addSubview:contentView];
    

    NSEntityDescription *entityDescription = _feedItem.entity;
    NSString *cellID = entityDescription.userInfo[@"cell"];
    Class cellClass = NSClassFromString(cellID);
    CardCell *cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    
    cell.frame = CGRectMake(8, 0, 304, [cellClass heightOfContent:_feedItem] );
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [cell configureForItem:_feedItem];
    [contentView addSubview:cell];
    
    // External Link View
    
    actionBarVC.feedItem = _feedItem;
    actionBarVC.view.frame = CGRectMake(8, cell.frame.size.height, 304, 100);
    [self addChildViewController:actionBarVC];
    [contentView addSubview:actionBarVC.view];
    

    // Messages Table View
    messagesVC = [[MessagesTableViewController alloc] init];
    messagesVC.feedItem = _feedItem;
    [self addChildViewController:messagesVC];
    CGRect frame = CGRectMake(8, cell.frame.size.height + 96, 304.0, self.view.frame.size.height - (cell.frame.size.height + 44));
    messagesVC.tableView.frame = frame;
    [contentView  addSubview:messagesVC.tableView];
    [messagesVC didMoveToParentViewController:self];
    
    
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																					action:@selector(handleTapGesture:)];
    gestureRecognizer.delegate = self;
    gestureRecognizer.enabled = NO;
    [self.scrollView addGestureRecognizer:gestureRecognizer];
    
    // Message Toolbar View
    messageToolbarVC = [[MessageToolbarViewController alloc] init];
    messageToolbarVC.view.frame = CGRectMake(0, self.view.bounds.size.height - 40, 320, 40);
    messageToolbarVC.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    messageToolbarVC.detailView = self;
    messageToolbarVC.view.layer.zPosition = MAXFLOAT;
    [self addChildViewController:messageToolbarVC];
    [self.view addSubview:messageToolbarVC.view];
    
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
    
    CGFloat height = (messagesVC.tableView.frame.origin.y + messagesVC.tableView.contentSize.height + 20);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
    [self.view sendSubviewToBack:scrollView];
}

-(void)scrollToBottomAnimated:(BOOL)animated
{
    if (scrollView.contentSize.height > 300) {
        CGPoint bottomOffset = CGPointMake(0, scrollView.contentSize.height - scrollView.frame.size.height);
        NSLog(@"height: %f", bottomOffset.y);
        [scrollView setContentOffset:bottomOffset animated:YES];
    }
}


-(void) didSendText:(NSString *)text
{
    [Message buildNewMessageWithBody:text forFeedItem:_feedItem];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"feedUpdated" object:self];
}

- (void)handleTapGesture:(UIGestureRecognizer*)gesture {
    [messageToolbarVC handleTapGesture:gesture];
}

@end
