//
//  MessageCell.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageCell : UITableViewCell

@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIImageView *moreMessagesIcon;
@property (strong, nonatomic) UILabel *moreMessagesLabel;
@property  BOOL shouldDrawShadow;
@property  BOOL shouldDrawMoreMessages;

+ (CGFloat) heightOfContent: (Message *)message hasMultipleMessages:(BOOL)multiple;

-(void) layoutMoreMessages;
-(void) removeMoreMessages;

@end
