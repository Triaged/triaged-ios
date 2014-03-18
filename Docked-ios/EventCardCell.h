//
//  EventCardCell.h
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventCard.h"
#import "FeedItemCell.h"
#import "TGRImageViewController.h"
#import "TGRImageZoomAnimationController.h"


@interface EventCardCell : FeedItemCell <UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UILabel *footerLabel;
@property BOOL imageExists;




@end
