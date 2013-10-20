//
//  CardCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

@synthesize propertyLabel, actionLabel, bodyLabel, providerIconView, timestampLabel, lineDivider, shouldDrawShadow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 8)];/// change size as you need.
        separatorLineView.backgroundColor = [[UIColor alloc] initWithRed:239.0f/255.0f green:240.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:separatorLineView];

        providerIconView = [[UIImageView alloc] initWithFrame: CGRectZero];
        providerIconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: providerIconView];
        
        propertyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [propertyLabel setFont: [UIFont fontWithName:@"Avenir-Roman" size:17.0]];
        propertyLabel.textColor = [UIColor blackColor];
        [propertyLabel setLineBreakMode: NSLineBreakByClipping];
        propertyLabel.numberOfLines = 1;
        [self.contentView addSubview: propertyLabel];
        
        timestampLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [timestampLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:11.0]];
        timestampLabel.textColor = [[UIColor alloc] initWithRed:188.0f/255.0f green:188.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
        [timestampLabel setLineBreakMode: NSLineBreakByClipping];
        timestampLabel.numberOfLines = 1;
        timestampLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview: timestampLabel];
        
        
        UIImage *line = [UIImage imageNamed:@"line.png"];
        lineDivider = [[UIImageView alloc] initWithImage:line];
        [self.contentView addSubview:lineDivider];
        
        // Body
        
        actionLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [actionLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
        actionLabel.textColor = [UIColor blackColor];
        [actionLabel setLineBreakMode: NSLineBreakByClipping];
        actionLabel.numberOfLines = 1;
        [self.contentView addSubview: actionLabel];
        
        
        
        bodyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        bodyLabel.textColor = [[UIColor alloc] initWithRed:142.0f/255.0f green:142.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
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
    
    [providerIconView setFrame:CGRectMake(14, 22.0, 28.0, 28.0)];
    [propertyLabel setFrame:CGRectMake(58, 22.0, 200.0, 18.0)];
    [timestampLabel setFrame:CGRectMake(58, 40.0, 200.0, 16.0)];
    [lineDivider setFrame:CGRectMake(14, 65, 280, 1)];
    
    [actionLabel setFrame:CGRectMake(14, 79.0, 280.0, 16.0)];
    
    NSAttributedString *attributedBodyText = [CardCell attributedBodyText:bodyLabel.text];
    CGRect newFrame = CGRectMake(14, 98.0, 288, [CardCell heightOfBody:attributedBodyText]);
    [bodyLabel setFrame:newFrame];
    
//if (shouldDrawShadow) [self drawShadow];
    
}

- (void) drawShadow
{
    self.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = .05;
    CGRect shadowFrame =  CGRectMake(self.layer.bounds.origin.x, self.layer.bounds.origin.y + self.layer.bounds.size.height, self.layer.bounds.size.width, 2);
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.layer.shadowPath = shadowPath;

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
    paragraphStyle.lineSpacing = .5;
    UIFont *font = [UIFont fontWithName:@"Avenir-Light" size:14.0];
    
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
    return 120;
}

@end
