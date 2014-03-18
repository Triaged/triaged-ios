//
//  DetailViewController.m
//  Triage-ios
//
//  Created by Charlie White on 3/9/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize scrollView, actionBarVC, detailView, messageToolbarVC, gestureRecognizer, messagesVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor clearColor];
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.layer.zPosition = -9999;
    scrollView.userInteractionEnabled=YES;
    scrollView.bounces = YES;
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    
    detailView = [[UIView alloc] init];
    detailView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:detailView];
    
    
    actionBarVC = [[ActionBarViewController alloc] init];
    actionBarVC.feedItem = _feedItem;
    [actionBarVC.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Messages Table View
    NSLog(@"%d", _feedItem.messages.count);
    messagesVC = [[MessagesTableViewController alloc] init];
    messagesVC.messages = [NSMutableArray arrayWithArray:[_feedItem.messages array]];
    messagesVC.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    //    // Message Toolbar View
    messageToolbarVC = [[MessageToolbarViewController alloc] init];
    messageToolbarVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    messageToolbarVC.view.frame = CGRectMake(0, self.view.bounds.size.height, 320, 40);
    messageToolbarVC.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    messageToolbarVC.detailView = self;
    messageToolbarVC.view.layer.zPosition = MAXFLOAT;
    [self addChildViewController:messageToolbarVC];
    [self.view addSubview:messageToolbarVC.view];
    
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(handleTapGesture:)];
    gestureRecognizer.delegate = self;
    gestureRecognizer.enabled = NO;
    [self.scrollView addGestureRecognizer:gestureRecognizer];
    
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];

}

- (void)setFeedItem:(FeedItem *)newDetailItem
{
    if (_feedItem != newDetailItem) {
        _feedItem = newDetailItem;
    }
}

- (void)setContainer:(UIView *)container {
    self.containerView = container;
    self.containerView.detailVC = self;
    [scrollView addSubview:self.containerView];
}

- (void)setupViewDetails {
    
    float containerBottom = self.containerView.frame.origin.y + self.containerView.frame.size.height;
    float detailHeight = self.view.bounds.size.height - containerBottom;
    CGRect detailFrame = CGRectMake(5.0f, containerBottom, 310.0f, 0.0f);
    detailView.frame = detailFrame;
    
    
    // Animate Drawer Open
    [UIView animateWithDuration:0.3f animations:^{
        CGRect detailFrame = CGRectMake(5.0f, containerBottom, 310.0f, detailHeight);
        detailView.frame = detailFrame;
        
        
        [detailView addSubview:actionBarVC.view];
        [actionBarVC.view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [actionBarVC.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [actionBarVC.view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [actionBarVC.view  autoSetDimension:ALDimensionWidth toSize:310];
        [actionBarVC.view  autoSetDimension:ALDimensionHeight toSize:71];
        
        [self addChildViewController:messagesVC];
        [scrollView  addSubview:messagesVC.tableView];
        [messagesVC didMoveToParentViewController:self];
        [messagesVC.tableView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [messagesVC.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:actionBarVC.view  withOffset:0];
        [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [messagesVC.tableView autoSetDimension:ALDimensionWidth toSize:310];

        
        messageToolbarVC.view.frame = CGRectMake(0, self.view.bounds.size.height - 40, 320, 40);
    } completion:^(BOOL finished) {
        // this gives us a nice callback when it finishes the animation :)
    }];
}

- (void)teardownViewDetails {
    actionBarVC.view.hidden = YES;
    messagesVC.tableView.hidden = YES;
    
    
    [UIView animateWithDuration:0.3f animations:^{
        
        float containerBottom = self.containerView.frame.origin.y + self.containerView.frame.size.height;
        CGRect detailFrame = CGRectMake(4.0f, containerBottom, 312.0f, 0);
        detailView.frame = detailFrame;
        
        messageToolbarVC.view.frame = CGRectMake(0, self.view.bounds.size.height, 320, 40);
    } completion:^(BOOL finished) {
        // this gives us a nice callback when it finishes the animation :)
    }];
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
    
//    //Message *message = [Message MR_createEntity];
//    
//    Message *message = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Message class])
//                                                     inManagedObjectContext:[TRDataStoreManager sharedInstance].mainThreadManagedObjectContext];
//    
//    message.feedItem    = _feedItem;
//    message.body        = text;
//    message.timestamp   = [NSDate date];
//    message.author      = [AppDelegate sharedDelegate].store.currentAccount.currentUser;
//    message.uuid        = [[NSUUID UUID] UUIDString];
//    
//    
//    
//    [message createWithCompletionHandler:^(Message *message, NSError *error) {
//        messagesVC.messages = [NSMutableArray arrayWithArray:[_feedItem.messages array]];
//        [messagesVC refreshDataSource];
//        [self.dynamicTVHeight autoRemove];
//        [self viewDidLayoutSubviews];
//    }];
    
    //[Message buildNewMessageWithBody:text forFeedItem:_feedItem];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"feedUpdated" object:self];
}

- (void)handleTapGesture:(UIGestureRecognizer*)gesture {
    [messageToolbarVC handleTapGesture:gesture];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
