//
//  CardCell.h
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"

@interface CardCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIImageView *iconView;

- (void)configureForItem:(FeedItem *)item;
+ (CGFloat) estimatedHeightOfContent;
+ (CGFloat) heightOfContent: (NSString *)content;

@end
