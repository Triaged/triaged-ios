//
//  TextCardCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TextCardCell.h"
#import "TextItem.h"



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

- (void)configureForItem:(TextItem *)item
{
    self.propertyLabel.text = item.property;
    self.actionLabel.text = item.action;
    self.bodyLabel.attributedText = [CardCell attributedBodyText:item.body];
    NSString *providerIconString = [NSString stringWithFormat:@"%@.png", item.provider];
    self.providerIconView.image = [UIImage imageNamed:providerIconString];
    self.timestampLabel.text = [item.timestamp timeAgo];

}

+ (CGFloat) estimatedHeightOfContent
{
    return 160;
}

+ (CGFloat) heightOfContent: (TextItem *)item {
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
        NSAttributedString *attributedBodyText = [CardCell attributedBodyText:item.body];
        CGFloat bodyHeight = [CardCell heightOfBody:attributedBodyText];
        CGFloat height = (120 + bodyHeight);
        
        [heightCache setObject: [NSNumber numberWithFloat: height] forKey: key];
        return height;
    }
}

@end
