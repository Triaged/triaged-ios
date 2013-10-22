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
    self.timestampLabel.text = [textCardItem.timestamp timeAgo];

}

+ (CGFloat) estimatedHeightOfContent
{
    return 160;
}

+ (CGFloat) heightOfContent: (FeedItem *)item {
    static NSCache* heightCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        heightCache = [NSCache new];
    });
    
    NSAssert(heightCache, @"Height cache must exist");
    
    NSString* key = item.externalID; //Create a unique key here
    NSNumber* cachedValue = [heightCache objectForKey: key];
    
    if( cachedValue )
        return [cachedValue floatValue];
    else {
        id<TextCardProtocol> textCardItem = (id<TextCardProtocol>)item;
        
        NSAttributedString *attributedBodyText = [CardCell attributedBodyText:textCardItem.body];
        CGFloat bodyHeight = [CardCell heightOfBody:attributedBodyText];
        CGFloat height = (120 + bodyHeight);
        
        [heightCache setObject: [NSNumber numberWithFloat: height] forKey: key];
        return height;
    }
}

@end
