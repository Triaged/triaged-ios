//
//  FeedItemCell.h
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTLFeedItem.h"
#import "NSDate+TimeAgo.h"

@interface FeedItemCell : UITableViewCell

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UIImageView *lineDivider;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *propertyLabel;
@property (strong, nonatomic) UIView* separatorLineView;
@property (strong, nonatomic) UIImageView *timestampIcon;
@property (strong, nonatomic) UILabel *timestampLabel;
@property  BOOL shouldSetFrame;



- (void)configureForItem:(MTLFeedItem *)item;
+ (CGFloat) heightOfContent: (MTLFeedItem *)item;

@end
