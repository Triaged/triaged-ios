//
//  TeammateCell.m
//  Docked-ios
//
//  Created by Charlie White on 10/16/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TeammateCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TeammateCell

@synthesize nameLabel, avatarView, cellIsForInvite;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 56, 0, 0);
        self.userInteractionEnabled = NO;
//        
//        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
//        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
//        lineView.frame = CGRectMake(70, 0, 250, .5);
//        [self.contentView addSubview: lineView];
        
        // Avatar image
        UIImage *avatarIcon = [UIImage imageNamed:@"avatar.png"];
        avatarView = [[UIImageView alloc] initWithImage:avatarIcon];
        avatarView.frame = CGRectMake(14, 7, 30, 30);
        [self.contentView addSubview: avatarView];
        
        nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(56, 7, 200, 30)];
        [nameLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:17.0]];
        nameLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        [nameLabel setLineBreakMode: NSLineBreakByClipping];
        nameLabel.numberOfLines = 1;
        [self.contentView addSubview: nameLabel];

    }
    return self;
}


- (void)setFrame:(CGRect)frame {
    frame.origin.x = 6.0f;
    frame.size.width = 272.0f;
    [super setFrame:frame];
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

- (void)configureForItem:(User *)user {
    
    nameLabel.text = user.name;
    NSURL *avatarUrl = [NSURL URLWithString:user.avatarUrl];
    [avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];

}

@end
