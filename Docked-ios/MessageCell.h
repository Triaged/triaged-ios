//
//  MessageCell.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UILabel *moreMessagesLabel;

+ (CGFloat) heightOfContent: (NSString *)bodyText;

@end
