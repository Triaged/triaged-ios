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
    self.titleLabel.text = item.titleLabel;
    self.bodyLabel.text = item.bodyLabel;
    self.iconView.image = item.icon;
    
//    CGRect paragraphRect =
//    [self.bodyLabel.attributedText boundingRectWithSize:CGSizeMake(300.f, CGFLOAT_MAX)
//                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                 context:nil];
//    
//    CGRect newFrame = self.bodyLabel.frame;
//    newFrame.size.height = paragraphRect.size.height;
//    self.bodyLabel.frame = newFrame;

}


+ (CGFloat) heightOfContent: (NSString *)content
{
//    CGFloat contentHeight =
//    [content sizeWithFont: DefaultContentLabelFont
//        constrainedToSize: CGSizeMake( DefaultCellSize.width, DefaultContentLabelHeight * DefaultContentLabelNumberOfLines )
//            lineBreakMode: UILineBreakModeWordWrap].height;
//    return contentHeight + DefaultCellPaddingHeight;
    return 140;
}

@end
