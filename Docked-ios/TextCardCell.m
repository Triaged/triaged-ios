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
    id<TextCardProtocol> textCardItem = (id<TextCardProtocol>)item;
    
    self.propertyLabel.text = textCardItem.property;
    self.actionLabel.text = textCardItem.action;
    self.bodyLabel.attributedText = [CardCell attributedBodyText:textCardItem.body];
    self.providerIconView.image = textCardItem.providerIcon;
    self.timestampLabel.text = textCardItem.externalID; //[textCardItem.timestamp timeAgo];

}

+ (CGFloat) estimatedHeightOfContent
{
    return 160;
}

+ (CGFloat) heightOfContent: (FeedItem *)item {
    id<TextCardProtocol> textCardItem = (id<TextCardProtocol>)item;
    
    NSAttributedString *attributedBodyText = [CardCell attributedBodyText:textCardItem.body];
    CGFloat bodyHeight = [CardCell heightOfBody:attributedBodyText];
    return (120 + bodyHeight);
}

@end
