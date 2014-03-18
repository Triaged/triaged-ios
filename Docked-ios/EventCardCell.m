//
//  EventCardCell.m
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "EventCardCell.h"
#import "UIImageView+AFNetworking.h"
#import "ImageUtility.h"

#define kImageViewHeight      230.0f
#define kImageViewWidth      320.0f
#define klBodyVertical      30.0f
#define kLZeroInsets      0.0f


@implementation EventCardCell

@synthesize bodyLabel, footerLabel, imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        imageView = [UIImageView newAutoLayoutView];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        //imageView.backgroundColor = BG_COLOR;
        imageView.contentMode = UIViewContentModeCenter;
        imageView.userInteractionEnabled = YES;
        [self.containerView addSubview: imageView];
        
//        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                            action:@selector(showImageViewer)];
//        gestureRecognizer.delegate = self;
//        [self.imageView addGestureRecognizer:gestureRecognizer];
        
        bodyLabel = [UILabel newAutoLayoutView];
        bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        bodyLabel.textColor = BODY_COLOR;
        [bodyLabel setFont: [UIFont fontWithName:@"HelveticaNeue" size:14]];
        bodyLabel.numberOfLines = 0;
        bodyLabel.backgroundColor = [UIColor whiteColor];
        [bodyLabel sizeToFit];
        [self.containerView addSubview: bodyLabel];
        
        

//        footerLabel = [UILabel newAutoLayoutView];
//        footerLabel.textColor = BODY_COLOR;
//        //[[UIColor alloc] initWithRed:134.0f/255.0f green:139.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
//        footerLabel.numberOfLines = 0;
//        [footerLabel sizeToFit];
//        [self.contentView addSubview: footerLabel];
        
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
    // self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
    
    if (self.imageExists) {
        [self.imageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.imageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleBlockView withOffset:klBodyVertical];
        [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLZeroInsets];
        [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLZeroInsets];
        [self.imageView autoSetDimension:ALDimensionHeight toSize:kImageViewHeight];
        [self.bodyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView  withOffset:kLabelVerticalInsets];
    } else {
        [self.imageView autoRemoveConstraintsAffectingView];
        [self.bodyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleBlockView withOffset:klBodyVertical];
    }
    
    
    [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.bodyLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelFifteenInsets];
    [self.bodyLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelFifteenInsets];
    
    [self.separatorLineView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.separatorLineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bodyLabel withOffset:klBodyVertical];
    [self.separatorLineView autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.separatorLineView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLZeroInsets];
    [self.separatorLineView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLZeroInsets];

    
    [self.timestampIcon setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.timestampIcon autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.separatorLineView  withOffset:kLabelVerticalInsets];
    [self.timestampIcon autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelFifteenInsets];
    [self.timestampIcon autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12.0];
    [self.timestampIcon autoSetDimension:ALDimensionWidth toSize:12.0];
    [self.timestampIcon autoSetDimension:ALDimensionHeight toSize:12.0];
    
    [self.timestampLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.timestampLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.separatorLineView  withOffset:7.0];
    [self.timestampLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.timestampIcon  withOffset:6.0];
    [self.timestampLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelFifteenInsets];
    [self.timestampLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
    
    self.didSetupConstraints = YES;
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
    self.bodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bodyLabel.frame);
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.frame);
    
}



- (void)configureForItem:(FeedItem *)item
{
    EventCard *event = (EventCard *)item;
    
    
    [self.avatarView setProvider:event.provider andUser:event.user];
    
    if (event.imageUrl != nil) {
        self.imageExists = YES;
        [self.imageView setImageWithURL:[NSURL URLWithString:event.imageUrl]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
       
        
    } else {
        self.imageExists = NO;
        //[imageView removeFromSuperview];
    }
    
    self.titleLabel.text = [event.title capitalizedString];
    self.propertyLabel.text = [event.propertyName lowercaseString];
    self.bodyLabel.text = event.body;
    self.timestampLabel.text = [item.timestamp timeAgo];
}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    if ([presented isKindOfClass:TGRImageViewController.class]) {
//        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.imageView];
//    }
//    return nil;
//}
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
//        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.imageView];
//    }
//    return nil;
//}
//
//- (void)showImageViewer {
//
//    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:self.imageView.image];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//    // Don't forget to set ourselves as the transition delegate
//    viewController.transitioningDelegate = self;
//    [self.containerView.tableViewController presentViewController:viewController animated:YES completion:nil];
//}

@end
