//
//  DetailViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/26/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"
#import "ActionBarViewController.h"

@interface DetailViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) FeedItem *feedItem;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) ActionBarViewController *actionBarVC;
@property (strong, nonatomic) UITapGestureRecognizer *gestureRecognizer;


-(void)scrollToBottomAnimated:(BOOL)animated;
-(void)didSendText:(NSString *)text;


@end
