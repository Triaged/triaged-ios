//
//  CardCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

@synthesize propertyLabel, actionLabel, bodyLabel, providerIconView, timestampLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];/// change size as you need.
        separatorLineView.backgroundColor = [[UIColor alloc] initWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:separatorLineView];
        
        
        CGRect shadowFrame = self.layer.bounds;
        CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
        self.layer.shadowPath = shadowPath;

        providerIconView = [[UIImageView alloc] initWithFrame: CGRectZero];
        providerIconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: providerIconView];
        
        propertyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [propertyLabel setFont: [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]];
        propertyLabel.textColor = [[UIColor alloc] initWithRed:100.0f/255.0f green:101.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
        [propertyLabel setLineBreakMode: NSLineBreakByClipping];
        propertyLabel.numberOfLines = 1;
        [self.contentView addSubview: propertyLabel];
        
        actionLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [actionLabel setFont: [UIFont fontWithName:@"AvenirNext-Medium" size:12.0]];
        actionLabel.textColor = [[UIColor alloc] initWithRed:141.0f/255.0f green:141.0f/255.0f blue:141.0f/255.0f alpha:1.0f];
        [actionLabel setLineBreakMode: NSLineBreakByClipping];
        actionLabel.numberOfLines = 1;
        [self.contentView addSubview: actionLabel];
        
        timestampLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [timestampLabel setFont: [UIFont fontWithName:@"AvenirNext-Medium" size:12.0]];
        timestampLabel.textColor = [[UIColor alloc] initWithRed:141.0f/255.0f green:141.0f/255.0f blue:141.0f/255.0f alpha:1.0f];
        [timestampLabel setLineBreakMode: NSLineBreakByClipping];
        timestampLabel.numberOfLines = 1;
        timestampLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview: timestampLabel];
        
        bodyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [bodyLabel setFont: [UIFont fontWithName:@"AvenirNext-Medium" size:13.0]];
        [bodyLabel setLineBreakMode: NSLineBreakByWordWrapping];
        bodyLabel.numberOfLines = 0;
        [bodyLabel sizeToFit];
        [self.contentView addSubview: bodyLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    [providerIconView setFrame:CGRectMake(10, 18.0, 30.0, 30.0)];
    [propertyLabel setFrame:CGRectMake(50, 18.0, 200.0, 18.0)];
    [actionLabel setFrame:CGRectMake(51, 35.0, 200.0, 16.0)];
    [timestampLabel setFrame:CGRectMake(250, 25.0, 50.0, 16.0)];
    
    NSAttributedString *attributedBodyText = [CardCell attributedBodyText:bodyLabel.text];
    CGRect newFrame = CGRectMake(10, 65.0, 288, [CardCell heightOfBody:attributedBodyText]);
    [bodyLabel setFrame:newFrame];
}

- (void)configureForItem:(FeedItem *)item
{
    NSAssert(NO, @"ConfigureForItem must be overwritten in a subclass.");
    
}

+ (NSAttributedString *) attributedBodyText:(NSString *)bodyText
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Medium" size:13.0];
    
    NSAttributedString *attributedBodyText = [[NSAttributedString alloc] initWithString:bodyText
                                              attributes:[NSDictionary
                                                  dictionaryWithObjectsAndKeys:font,
                                                  NSFontAttributeName,
                                                  paragraphStyle, NSParagraphStyleAttributeName,nil]];
    return attributedBodyText;
}

+ (CGFloat) heightOfBody:(NSAttributedString *)bodyText
{
    CGRect paragraphRect =
    [bodyText boundingRectWithSize:CGSizeMake(288.0, CGFLOAT_MAX)
                                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                context:nil];
    return paragraphRect.size.height;
}

+ (CGFloat) estimatedHeightOfContent
{
    return 88;
}

+ (CGFloat) heightOfContent:(FeedItem *)item
{
    return 88;
}

@end
