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

@protocol CardProtocol <NSObject>
-(NSString *)property;
-(NSString *)action;
-(UIImage *)providerIcon;
-(NSDate *)timestamp;
@end

@interface CardCell : UITableViewCell

@property (strong, nonatomic) UIImageView *providerIconView;
@property (strong, nonatomic) UIImageView *lineDivider;
@property (strong, nonatomic) UILabel *propertyLabel;
@property (strong, nonatomic) UILabel *actionLabel;
@property (strong, nonatomic) UILabel *timestampLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property CGFloat *heightCache;
@property  BOOL shouldDrawShadow;


- (void)configureForItem:(FeedItem *)item;
+ (CGFloat) estimatedHeightOfContent;
+ (CGFloat) heightOfContent: (FeedItem *)item;

+ (NSAttributedString *) attributedBodyText:(NSString *)bodyText;
+ (CGFloat) heightOfBody:(NSAttributedString *)bodyText;

@end
