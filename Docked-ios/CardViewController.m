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
#import "TRDataStoreManager.h"

#define kLMessageToolbarHeight      40.0f
#define kLTabbarHeight      49.0f


@interface CardViewController () {
    MessagesTableViewController *messagesVC;
    MessageToolbarViewController *messageToolbarVC;
}

@end

@implementation CardViewController

@synthesize scrollView, actionBarVC, gestureRecognizer, dynamicTVHeight;

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

- (void)setFeedItem:(FeedItem *)newDetailItem
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
    scrollView.layer.zPosition = -9999;
    scrollView.userInteractionEnabled=YES;
    [self.view addSubview:scrollView];
    
//    UIView *contentView;
//    contentView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,self.view.frame.size.height-45)];
//    [scrollView addSubview:contentView];
    
    
    Class cellClass = _feedItem.itemCellClass;
    NSString *cellID = NSStringFromClass(cellClass);
    
    if (_feedItem.imageUrl) {
        cellID = [NSString stringWithFormat:@"%@-image",cellID];
    }
    
    FeedItemCell *cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ];
    cell.translatesAutoresizingMaskIntoConstraints = NO;
    [cell configureForItem:_feedItem];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    [scrollView addSubview:cell];
    
    
    // External Link View
    
    actionBarVC.feedItem = _feedItem;
    actionBarVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:actionBarVC.view];
    //    actionBarVC.view.frame = CGRectMake(0, cell.frame.size.height, 320, 40);

    // Messages Table View
            NSLog(@"%d", _feedItem.messages.count);
    messagesVC = [[MessagesTableViewController alloc] init];
    messagesVC.messages = [NSMutableArray arrayWithArray:[_feedItem.messages array]];
    messagesVC.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:messagesVC];
    [scrollView  addSubview:messagesVC.tableView];
    [messagesVC didMoveToParentViewController:self];
    
    
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(handleTapGesture:)];
    gestureRecognizer.delegate = self;
    gestureRecognizer.enabled = NO;
    [self.scrollView addGestureRecognizer:gestureRecognizer];
    
    //    // Message Toolbar View
    messageToolbarVC = [[MessageToolbarViewController alloc] init];
    messageToolbarVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    //messageToolbarVC.view.frame = CGRectMake(0, self.view.bounds.size.height - 40, 320, 40);
    messageToolbarVC.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    messageToolbarVC.detailView = self;
    messageToolbarVC.view.layer.zPosition = MAXFLOAT;
    [self addChildViewController:messageToolbarVC];
    [self.view addSubview:messageToolbarVC.view];
    
    // Autolayout
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLMessageToolbarHeight + kLTabbarHeight];
    
    
    [cell setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [cell autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [cell autoSetDimension:ALDimensionWidth toSize:320];
    [cell autoSetDimension:ALDimensionHeight toSize:[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height];
    
    [actionBarVC.view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [actionBarVC.view  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cell withOffset:0];
    [actionBarVC.view  autoSetDimension:ALDimensionWidth toSize:320];
    [actionBarVC.view  autoSetDimension:ALDimensionHeight toSize:71];

    
    [messagesVC.tableView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [messagesVC.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:actionBarVC.view  withOffset:0];
    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [messagesVC.tableView autoSetDimension:ALDimensionWidth toSize:320];

    
    [messageToolbarVC.view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [messageToolbarVC.view autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [messageToolbarVC.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLTabbarHeight];
    [messageToolbarVC.view  autoSetDimension:ALDimensionHeight toSize:kLMessageToolbarHeight];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidLayoutSubviews
{
    [messagesVC.tableView layoutIfNeeded];
    self.dynamicTVHeight = [messagesVC.tableView autoSetDimension:ALDimensionHeight toSize:messagesVC.tableView.contentSize.height];
    [self.view layoutIfNeeded];
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

    //Message *message = [Message MR_createEntity];
    
    Message *message = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Message class])
                                  inManagedObjectContext:[TRDataStoreManager sharedInstance].mainThreadManagedObjectContext];
    
    message.feedItem    = _feedItem;
    message.body        = text;
    message.timestamp   = [NSDate date];
    message.author      = [AppDelegate sharedDelegate].store.currentAccount.currentUser;
    message.uuid        = [[NSUUID UUID] UUIDString];
    

    
    [message createWithCompletionHandler:^(Message *message, NSError *error) {
        messagesVC.messages = [NSMutableArray arrayWithArray:[_feedItem.messages array]];
        [messagesVC refreshDataSource];
        [self.dynamicTVHeight autoRemove];
        [self viewDidLayoutSubviews];
    }];

    //[Message buildNewMessageWithBody:text forFeedItem:_feedItem];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"feedUpdated" object:self];
}

- (void)handleTapGesture:(UIGestureRecognizer*)gesture {
    [messageToolbarVC handleTapGesture:gesture];
}

@end
