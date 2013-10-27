//
//  AtReplyMessageCell.m
//  Triage-ios
//
//  Created by Charlie White on 10/24/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "AtReplyMessageCell.h"

@implementation AtReplyMessageCell

@synthesize nameLabel, avatarView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        lineView.frame = CGRectMake(70, 0, 250, 1);
        [self.contentView addSubview: lineView];
        
        // Avatar image
        UIImage *avatarIcon = [UIImage imageNamed:@"avatar.png"];
        avatarView = [[UIImageView alloc] initWithImage:avatarIcon];
        avatarView.frame = CGRectMake(14, 3, 36, 36);
        [self.contentView addSubview: avatarView];
        
        nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(70, 8, 200, 30)];
        [nameLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:17.0]];
        nameLabel.textColor = [UIColor blackColor];
        [nameLabel setLineBreakMode: NSLineBreakByClipping];
        nameLabel.numberOfLines = 1;
        [self.contentView addSubview: nameLabel];
        
    }
    return self;
}

@end
