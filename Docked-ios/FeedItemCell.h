//
//  FeedItemCell.h
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"
#import "NSDate+TimeAgo.h"
#import "ContainerViewCell.h"
#import "AvatarCellView.h"


#define kLabelFifteenInsets      15.0f
#define kLabelSeventeenInsets      17.0f
#define kLabelThirteenInsets      13.0f
#define kLabelVerticalInsets        10.0f
#define kLSixInsets      6.0f

@interface FeedItemCell : UITableViewCell

@property (strong, nonatomic) ContainerViewCell *containerView;
@property (strong, nonatomic) AvatarCellView *avatarView;
@property (strong, nonatomic) UIView* titleBlockView;
@property (strong, nonatomic) UIImageView *lineDivider;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *propertyLabel;
@property (strong, nonatomic) UIView* separatorLineView;
@property (strong, nonatomic) UIImageView *timestampIcon;
@property (strong, nonatomic) UILabel *timestampLabel;
@property (strong, nonatomic) UIImageView *messagesIcon;
@property (strong, nonatomic) UILabel *messagesLabel;
@property (strong, nonatomic) NSLayoutConstraint *bottomContainerViewContrainst;

@property (nonatomic, assign) BOOL didSetupConstraints;




- (void)configureForItem:(FeedItem *)item;
+ (CGFloat) heightOfContent: (FeedItem *)item;

@end
