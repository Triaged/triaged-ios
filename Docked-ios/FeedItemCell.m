//
//  FeedItemCell.m
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "FeedItemCell.h"

@interface FeedItemCell ()



@end

@implementation FeedItemCell

@synthesize titleLabel, avatarView, lineDivider, propertyLabel, timestampLabel, separatorLineView, timestampIcon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self.layer setBorderWidth:1.0f];
        UIColor *borderColor = BORDER_COLOR;
        [self.layer setBorderColor:borderColor.CGColor];
        
        self.backgroundColor = [UIColor whiteColor];
        
        avatarView = [UIImageView newAutoLayoutView];
        avatarView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: avatarView];
        
        titleLabel = [UILabel newAutoLayoutView];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [titleLabel setFont: [UIFont fontWithName:@"Avenir-Medium" size:17.0]];
        titleLabel.textColor = TITLE_COLOR;
        [titleLabel setLineBreakMode: NSLineBreakByClipping];
        titleLabel.numberOfLines = 1;
        [self.contentView addSubview: titleLabel];
        
        propertyLabel = [UILabel newAutoLayoutView];
        propertyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [propertyLabel setFont: [UIFont fontWithName:@"Avenir-Roman" size:13]];
        propertyLabel.textColor = [[UIColor alloc] initWithRed:140.0f/255.0f green:149.0f/255.0f blue:165.0f/255.0f alpha:1.0f];
        [propertyLabel setLineBreakMode: NSLineBreakByClipping];
        propertyLabel.numberOfLines = 1;
        [self.contentView addSubview: propertyLabel];
        
        separatorLineView = [UIView newAutoLayoutView];/// change size as you need.
        separatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
        separatorLineView.backgroundColor = BG_COLOR;
        [self.contentView addSubview:separatorLineView];
        
        timestampIcon = [UIImageView newAutoLayoutView];
        timestampIcon.translatesAutoresizingMaskIntoConstraints = NO;
        timestampIcon.image = [UIImage imageNamed:@"feed_icon_time.png"];
        [self.contentView addSubview:timestampIcon];
    
        
        timestampLabel = [UILabel newAutoLayoutView];
        timestampLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [timestampLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:11.0]];
        timestampLabel.textColor = [[UIColor alloc] initWithRed:168.0f/255.0f green:175.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
        [timestampLabel setLineBreakMode: NSLineBreakByClipping];
        timestampLabel.numberOfLines = 1;
        timestampLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview: timestampLabel];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) {
        return;
    }
    
    // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
    // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
    //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
    self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
    
    [self.avatarView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.avatarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
    [self.avatarView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];

    
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
    [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.avatarView withOffset:kLabelHorizontalInsets];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
    
    
    [self.propertyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.propertyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:kLabelVerticalInsets];
    [self.propertyLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.avatarView withOffset:kLabelHorizontalInsets];
    [self.propertyLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
    
    [self.separatorLineView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.separatorLineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.propertyLabel withOffset:kLabelVerticalInsets];
    [self.separatorLineView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
    [self.separatorLineView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];

    
}


-(void) layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    //self.bodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bodyLabel.frame);
    
}

- (void)configureForItem:(MTLFeedItem *)item {
    assert("ConfigureForItem must be overidden");
}


@end
