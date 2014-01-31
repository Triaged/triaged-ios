//
//  FeedItemCell.m
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "FeedItemCell.h"

@implementation FeedItemCell

@synthesize titleLabel, avatarView, lineDivider, propertyLabel, timestampLabel, separatorLineView, timestampIcon, shouldSetFrame;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self.layer setBorderWidth:1.0f];
        UIColor *borderColor = BORDER_COLOR;
        [self.layer setBorderColor:borderColor.CGColor];
        
        avatarView = [[UIImageView alloc] initWithFrame: CGRectZero];
        avatarView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: avatarView];
        
        titleLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [titleLabel setFont: [UIFont fontWithName:@"Avenir-Medium" size:17.0]];
        titleLabel.textColor = TITLE_COLOR;
        //[[UIColor alloc] initWithRed:134.0f/255.0f green:139.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
        [titleLabel setLineBreakMode: NSLineBreakByClipping];
        titleLabel.numberOfLines = 1;
        [self.contentView addSubview: titleLabel];
        
        propertyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [propertyLabel setFont: [UIFont fontWithName:@"Avenir-Roman" size:13]];
        propertyLabel.textColor = [[UIColor alloc] initWithRed:140.0f/255.0f green:149.0f/255.0f blue:165.0f/255.0f alpha:1.0f];
        [propertyLabel setLineBreakMode: NSLineBreakByClipping];
        propertyLabel.numberOfLines = 1;
        [self.contentView addSubview: propertyLabel];
        
        separatorLineView = [[UIView alloc] initWithFrame: CGRectZero];/// change size as you need.
        separatorLineView.backgroundColor = BG_COLOR;
        [self.contentView addSubview:separatorLineView];
        
        timestampIcon = [[UIImageView alloc] initWithFrame: CGRectZero];
        timestampIcon.image = [UIImage imageNamed:@"feed_icon_time.png"];
        [self.contentView addSubview:timestampIcon];
    
        
        timestampLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [timestampLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:11.0]];
        timestampLabel.textColor = [[UIColor alloc] initWithRed:168.0f/255.0f green:175.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
        [timestampLabel setLineBreakMode: NSLineBreakByClipping];
        timestampLabel.numberOfLines = 1;
        timestampLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview: timestampLabel];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame {
//    
//    if (shouldSetFrame) {
//    
////        frame.origin.x = 6.0f;
////        frame.size.width = 308.0f;
////        [super setFrame:frame];
////        
////        [self.layer setCornerRadius:7.0f];
////        [self.layer setMasksToBounds:YES];
//        [self.layer setBorderWidth:1.0f];
//        UIColor *borderColor = BORDER_COLOR;
//        [self.layer setBorderColor:borderColor.CGColor];
//    } else {
//        [super setFrame:frame];
//    }
//}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    [avatarView setFrame:CGRectMake(12, 12, 40, 40)];
    [titleLabel setFrame:CGRectMake(65, 12.0, 200.0, 34.0)];
    [propertyLabel setFrame:CGRectMake(65, 46.0, 200.0, 18.0)];
    [separatorLineView setFrame:CGRectMake(16.0, 78.0, 292.0, 1)];
    
}

- (void)configureForItem:(MTLFeedItem *)item {
    assert("ConfigureForItem must be overidden");
}


@end
