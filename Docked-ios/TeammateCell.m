//
//  TeammateCell.m
//  Docked-ios
//
//  Created by Charlie White on 10/16/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TeammateCell.h"

@implementation TeammateCell

@synthesize nameLabel, avatarView, cellIsForInvite;

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

-(void) layoutSubviews {
    [super layoutSubviews];
    
    if (cellIsForInvite) {
        nameLabel.textColor =
            [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
        nameLabel.text = @"Invite New Member";
        avatarView.image = [UIImage imageNamed:@"icn_newmember.png"];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
