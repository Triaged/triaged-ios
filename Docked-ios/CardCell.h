//
//  CardCell.h
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"
#import "Message.h"
#import "MessageCell.h"
#import "NSDate+TimeAgo.h"

@interface CardCell : UITableViewCell

@property (strong, nonatomic) UIImageView *providerIconView;
@property (strong, nonatomic) UIImageView *lineDivider;
@property (strong, nonatomic) UILabel *propertyLabel;
@property (strong, nonatomic) UILabel *actionLabel;
@property (strong, nonatomic) UILabel *timestampLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIView* separatorLineView;
@property CGFloat *heightCache;
@property  BOOL shouldDrawShadow;
@property  BOOL shouldDrawSeparator;
@property  BOOL shouldCache;


- (void)configureForItem:(FeedItem *)item;
+ (CGFloat) estimatedHeightOfContent;
//+ (CGFloat) heightOfContent: (FeedItem *)item;

+ (NSAttributedString *) attributedBodyText:(NSString *)bodyText;
+ (CGFloat) heightOfBody:(NSAttributedString *)bodyText;

-(NSString *)propertyFormatter:(NSString *)property;

@end
