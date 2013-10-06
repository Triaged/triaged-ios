//
//  TextCardCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TextCardCell.h"



@implementation TextCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForItem:(FeedItem *)item
{
    self.propertyLabel.text = item.property;
    self.actionLabel.text = item.action;
    self.bodyLabel.text = item.body;
    self.providerIconView.image = item.providerIcon;
    self.timestampLabel.text = [item.timestamp timeAgo];

}

+ (CGFloat) heightOfContent: (NSString *)bodyText {
    NSAttributedString *attributedBodyText = [CardCell attributedBodyText:bodyText];
    CGFloat bodyHeight = [CardCell heightOfBody:attributedBodyText];
    return (80 + bodyHeight);
}

@end
