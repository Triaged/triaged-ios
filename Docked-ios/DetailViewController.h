//
//  DetailViewController.h
//  Triage-ios
//
//  Created by Charlie White on 3/9/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionBarViewController.h"
#import "MessagesTableViewController.h"
#import "MessageToolbarViewController.h"
#import "ContainerViewCell.h"

@class MessageToolbarViewController;
@class ContainerViewCell;

@interface DetailViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) FeedItem *feedItem;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) ContainerViewCell *containerView;
@property (strong, nonatomic) UIView *detailView;
@property (strong, nonatomic) UITapGestureRecognizer *gestureRecognizer;
@property (strong, nonatomic) ActionBarViewController *actionBarVC;
@property (strong, nonatomic) MessagesTableViewController *messagesVC;
@property (strong, nonatomic) MessageToolbarViewController *messageToolbarVC;
@property (strong, nonatomic) UITableViewController *tableViewController;

@property (nonatomic) NSLayoutConstraint *dynamicTVHeight;

- (void)setFeedItem:(FeedItem *)newFeedItem;
- (void)setContainer:(UIView *)container;
- (void)setupViewDetails;
- (void)teardownViewDetails;

-(void)scrollToBottomAnimated:(BOOL)animated;
-(void)didSendText:(NSString *)text;

@end
