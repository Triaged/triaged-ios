//
//  DetailViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/26/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "CardViewController.h"
#import "MessagesTableViewController.h"
#import "MessageToolbarViewController.h"
#import "FeedItemCell.h"
#import "UIView+BlurredSnapshot.h"
#import "AppDelegate.h"


@interface CardViewController () {
    MessagesTableViewController *messagesVC;
    MessageToolbarViewController *messageToolbarVC;
}

@end

@implementation CardViewController

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

- (void)setFeedItem:(MTLFeedItem *)newDetailItem
{
    if (_feedItem != newDetailItem) {
        _feedItem = newDetailItem;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;

    self.view.backgroundColor = BG_COLOR;
    self.view.layer.zPosition = -9999;
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    scrollView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height - 40);
    scrollView.layer.zPosition = -9999;
    scrollView.userInteractionEnabled=YES;
    [self.view addSubview:scrollView];
    
//    UIView *contentView;
//    contentView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,self.view.frame.size.height-45)];
//    [scrollView addSubview:contentView];
    

    Class cellClass = _feedItem.itemCellClass;
    FeedItemCell *cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedItemCell" ];
    cell.translatesAutoresizingMaskIntoConstraints = NO;
    [cell configureForItem:_feedItem];
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [scrollView addSubview:cell];
    
    
    // External Link View
    
    //actionBarVC.feedItem = _feedItem;
//    actionBarVC.view.frame = CGRectMake(0, cell.frame.size.height, 320, 40);
//    [contentView addSubview:actionBarVC.view];
//
//
    // Messages Table View
//    messagesVC = [[MessagesTableViewController alloc] init];
//    messagesVC.feedItem = _feedItem;
//    messagesVC.tableView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addChildViewController:messagesVC];
//    [scrollView  addSubview:messagesVC.tableView];
//    [messagesVC didMoveToParentViewController:self];
    
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    
    
    [cell setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [cell autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [cell autoSetDimension:ALDimensionWidth toSize:320];
    [cell autoSetDimension:ALDimensionHeight toSize:[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height];
    
//    [messagesVC.tableView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    [messagesVC.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cell  withOffset:0];
//    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
//    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
//    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    
    
    
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																					action:@selector(handleTapGesture:)];
    gestureRecognizer.delegate = self;
    gestureRecognizer.enabled = NO;
    [self.scrollView addGestureRecognizer:gestureRecognizer];
    
//    // Message Toolbar View
//    messageToolbarVC = [[MessageToolbarViewController alloc] init];
//    messageToolbarVC.view.frame = CGRectMake(0, self.view.bounds.size.height - 40, 320, 40);
//    messageToolbarVC.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    messageToolbarVC.detailView = self;
//    messageToolbarVC.view.layer.zPosition = MAXFLOAT;
//    [self addChildViewController:messageToolbarVC];
//    [self.view addSubview:messageToolbarVC.view];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}




-(void)refreshView {
    [messagesVC refreshTableView];
}

-(void)scrollToBottomAnimated:(BOOL)animated
{
    if (scrollView.contentSize.height > 300) {
        CGPoint bottomOffset = CGPointMake(0, scrollView.contentSize.height - scrollView.frame.size.height);
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
