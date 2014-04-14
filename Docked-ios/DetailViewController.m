//
//  DetailViewController.m
//  Triage-ios
//
//  Created by Charlie White on 3/9/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "DetailViewController.h"

#define kActionBarHeight      71.0f

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
    scrollView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 40.0);
    scrollView.userInteractionEnabled = YES;
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
    messagesVC = [[MessagesTableViewController alloc] init];
    messagesVC.feedItem = self.feedItem;
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
    CGRect detailFrame = CGRectMake(5.0f, containerBottom-71.0, 310.0f, kActionBarHeight);
    //detailView.alpha = 0.0;
    detailView.frame = detailFrame;
    
    [self drawActionBarBottomBorder];
    
    [detailView addSubview:actionBarVC.view];
    [actionBarVC.view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [actionBarVC.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [actionBarVC.view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [actionBarVC.view  autoSetDimension:ALDimensionWidth toSize:310];
    [actionBarVC.view  autoSetDimension:ALDimensionHeight toSize:kActionBarHeight];
    
    [self addChildViewController:messagesVC];
    [messagesVC.tableView layoutIfNeeded];
    [detailView  addSubview:messagesVC.tableView];
    float tableHeight = [messagesVC.tableView contentSize].height;

    [messagesVC didMoveToParentViewController:self];
    [messagesVC.tableView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [messagesVC.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:actionBarVC.view  withOffset:0];
    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [messagesVC.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [messagesVC.tableView autoSetDimension:ALDimensionWidth toSize:310];
    
    // Animate Drawer Open
    [UIView animateWithDuration:0.15f animations:^{
        
        CGRect detailFrame = CGRectMake(5.0f, containerBottom, 310.0f, tableHeight + kActionBarHeight);
        detailView.frame = detailFrame;
        
        [self setDetailMaskPath];
        [self setScrollViewContentSize];
        

        messageToolbarVC.view.frame = CGRectMake(0, self.view.bounds.size.height - 40, 320, 40);
    } completion:^(BOOL finished) {
        // this gives us a nice callback when it finishes the animation :)
    }];
}

- (void) setDetailMaskPath {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:detailView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(4.0, 4.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = detailView.bounds;
    maskLayer.path = maskPath.CGPath;
    detailView.layer.mask = maskLayer;
}

- (void) setScrollViewContentSize {
    
    CGFloat detailSize = detailView.frame.origin.y + detailView.frame.size.height;
    NSLog(@"%f", detailSize);
    NSLog(@"%f", scrollView.frame.size.height);
    
    if (detailSize > scrollView.frame.size.height) {
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, detailSize + 20);
    } else {
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
    }
    

}

-(void)drawActionBarBottomBorder {
    if ([_feedItem.messages count] > 0) {
        [actionBarVC drawBottomBorder];
    }
}


- (void)teardownViewDetails {
    actionBarVC.view.hidden = YES;
    messagesVC.tableView.hidden = YES;
    
    
    [UIView animateWithDuration:0.3f animations:^{
        
        float containerBottom = self.containerView.frame.origin.y + self.containerView.frame.size.height;
        CGRect detailFrame = CGRectMake(5.0f, containerBottom, 310.0f, 0);
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
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
    
    Message *message = [Message MR_createEntity];

    message.feedItem    = _feedItem;
    message.body        = text;
    message.timestamp   = [NSDate date];
    message.author      = [AppDelegate sharedDelegate].store.currentAccount.currentUser;
    message.uuid        = [[NSUUID UUID] UUIDString];
    
    [messagesVC refreshDataSource];
    
    // Update Message Count
    //_feedItem.messagesCount = [NSNumber numberWithInt:[_feedItem.messagesCount intValue] + 1];
    //[localContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {}];

    
    
    [UIView animateWithDuration:1.15f animations:^{
        [self drawActionBarBottomBorder];
        float tableHeight = [messagesVC.tableView contentSize].height;
        CGRect detailFrame = CGRectMake(detailView.frame.origin.x, detailView.frame.origin.y, detailView.frame.size.width, tableHeight + kActionBarHeight);
        detailView.frame = detailFrame;
        
        [self setDetailMaskPath];
        [self setScrollViewContentSize];
        
    } completion:^(BOOL finished) {
        // this gives us a nice callback when it finishes the animation :)
    }];

    [message createWithCompletionHandler:^(Message *message, NSError *error) {
    }];
    
   
   
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
