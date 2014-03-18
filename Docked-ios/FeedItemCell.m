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

@synthesize containerView, titleLabel, avatarView, lineDivider, propertyLabel, timestampLabel, separatorLineView, timestampIcon, titleBlockView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setMasksToBounds:YES];

        self.contentView.layer.shadowOffset = CGSizeMake(0,0);
        UIColor *shadowColor = SHADOW_COLOR;
        self.containerView.backgroundColor = shadowColor;
        self.contentView.layer.shadowColor = [shadowColor CGColor];
        self.contentView.layer.shadowRadius = 4;
        self.contentView.layer.shadowOpacity = 0.75;
        [self.contentView.layer setCornerRadius:4.0f];
        
        containerView = [[ContainerViewCell alloc] initForAutoLayout];
        [self.contentView addSubview:containerView];
        
        avatarView = [[AvatarCellView alloc] initForAutoLayout];
        [containerView addSubview: avatarView];
        
        titleBlockView = [UIView newAutoLayoutView];
        [containerView addSubview:titleBlockView];
        
        titleLabel = [UILabel newAutoLayoutView];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [titleLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:17.0]];
        titleLabel.textColor = TITLE_COLOR;
        [titleLabel setLineBreakMode: NSLineBreakByClipping];
        titleLabel.numberOfLines = 2;
        titleLabel.backgroundColor = [UIColor whiteColor];
        [titleBlockView addSubview: titleLabel];
        
        propertyLabel = [UILabel newAutoLayoutView];
        propertyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [propertyLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:12]];
        propertyLabel.textColor = [[UIColor alloc] initWithRed:139.0f/255.0f green:146.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
        [propertyLabel setLineBreakMode: NSLineBreakByClipping];
        propertyLabel.numberOfLines = 1;
        [titleBlockView addSubview: propertyLabel];
        
        separatorLineView = [UIView newAutoLayoutView];/// change size as you need.
        separatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
        separatorLineView.backgroundColor = BORDER_COLOR;
        [containerView addSubview:separatorLineView];
        
        timestampIcon = [UIImageView newAutoLayoutView];
        timestampIcon.translatesAutoresizingMaskIntoConstraints = NO;
        timestampIcon.image = [UIImage imageNamed:@"feed_icon_time.png"];
        timestampIcon.backgroundColor = [UIColor whiteColor];
        [containerView addSubview:timestampIcon];
    
        
        timestampLabel = [UILabel newAutoLayoutView];
        timestampLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [timestampLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:11.0]];
        timestampLabel.textColor = [[UIColor alloc] initWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0f];
        [timestampLabel setLineBreakMode: NSLineBreakByClipping];
        timestampLabel.numberOfLines = 1;
        timestampLabel.textAlignment = NSTextAlignmentLeft;
        timestampLabel.backgroundColor = [UIColor whiteColor];
        [containerView addSubview: timestampLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 4.0f;
    frame.size.width = 312.0f;
    [super setFrame:frame];
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef ref = UIGraphicsGetCurrentContext();
//    
//    /* We can only draw inside our view, so we need to inset the actual 'rounded content' */
//    CGRect contentRect = CGRectInset(rect, 2, 2);
//    
//    UIColor *fillColer = BORDER_COLOR
//    /* Create the rounded path and fill it */
//    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:contentRect cornerRadius:4];
//    CGContextSetFillColorWithColor(ref, BORDER_COLOR.CGColor);
//    CGContextSetShadowWithColor(ref, CGSizeMake(0.0, 0.0), 2, [[UIColor blackColor] CGColor]);
//    [roundedPath fill];
//    
//    /* Draw a subtle white line at the top of the view */
//    [roundedPath addClip];
//    CGContextSetStrokeColorWithColor(ref, [UIColor colorWithWhite:1.0 alpha:0.6].CGColor);
//    CGContextSetBlendMode(ref, kCGBlendModeOverlay);
//    
//    CGContextMoveToPoint(ref, CGRectGetMinX(contentRect), CGRectGetMinY(contentRect)+0.5);
//    CGContextAddLineToPoint(ref, CGRectGetMaxX(contentRect), CGRectGetMinY(contentRect)+0.5);
//    CGContextStrokePath(ref);
//}

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
    
    [self.containerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.5];
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:1];
    [self.containerView autoSetDimension:ALDimensionWidth toSize:310.0];
    self.bottomContainerViewContrainst = [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:1];


    [self.avatarView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.avatarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelFifteenInsets];
    [self.avatarView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelFifteenInsets];
    [self.avatarView autoSetDimension:ALDimensionHeight toSize:44.0];
    [self.avatarView autoSetDimension:ALDimensionWidth toSize:40.0];
    
    [self.titleBlockView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.titleBlockView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0];
    [self.titleBlockView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.avatarView withOffset:kLabelThirteenInsets];
    [self.titleBlockView autoSetDimension:ALDimensionHeight toSize:48.0];
    [self.titleBlockView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelFifteenInsets];

    
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.titleLabel autoConstrainAttribute:ALAxisHorizontal toAttribute:ALAxisHorizontal ofView:self.titleBlockView withMultiplier:1.0 relation:NSLayoutRelationEqual];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelFifteenInsets];
    
    
    [self.propertyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.propertyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:0.0];
    [self.propertyLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0];
    [self.propertyLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelFifteenInsets];
    
    
    
}



-(void) layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    //self.contentView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.contentView.bounds] CGPath];
//    [self.contentView.layer setMasksToBounds:YES];
      self.contentView.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds cornerRadius:4] CGPath];
    [self.contentView.layer setMasksToBounds:YES];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    //self.bodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bodyLabel.frame);
    
}

- (void)configureForItem:(FeedItem *)item {
    assert("ConfigureForItem must be overidden");
}


@end
