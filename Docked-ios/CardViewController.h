//
//  DetailViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/26/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTLFeedItem.h"
#import "ActionBarViewController.h"

@interface CardViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) MTLFeedItem *feedItem;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) ActionBarViewController *actionBarVC;
@property (strong, nonatomic) UITapGestureRecognizer *gestureRecognizer;


-(void)scrollToBottomAnimated:(BOOL)animated;
-(void)didSendText:(NSString *)text;

- (void)setFeedItem:(MTLFeedItem *)newFeedItem;

@end
