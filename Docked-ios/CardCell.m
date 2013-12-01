//
//  CardCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

@synthesize propertyLabel, actionLabel, bodyLabel, providerIconView, timestampLabel, lineDivider, shouldDrawShadow, heightCache, shouldCache, shouldDrawSeparator, separatorLineView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        shouldCache = YES;
        shouldDrawSeparator = YES;

        separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];/// change size as you need.
        separatorLineView.backgroundColor = BG_COLOR;

        providerIconView = [[UIImageView alloc] initWithFrame: CGRectZero];
        providerIconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: providerIconView];
        
        propertyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [propertyLabel setFont: [UIFont fontWithName:@"Avenir-Roman" size:16.0]];
        propertyLabel.textColor = BODY_COLOR;
//[[UIColor alloc] initWithRed:134.0f/255.0f green:139.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
        [propertyLabel setLineBreakMode: NSLineBreakByClipping];
        propertyLabel.numberOfLines = 1;
        [self.contentView addSubview: propertyLabel];
        
        timestampLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [timestampLabel setFont: [UIFont fontWithName:@"Avenir-Roman" size:11.0]];
        timestampLabel.textColor = [[UIColor alloc] initWithRed:191.0f/255.0f green:198.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
        [timestampLabel setLineBreakMode: NSLineBreakByClipping];
        timestampLabel.numberOfLines = 1;
        timestampLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview: timestampLabel];
        
        // Body
        
        actionLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [actionLabel setFont: [UIFont fontWithName:@"Avenir-Medium" size:16]];
        actionLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        [actionLabel setLineBreakMode: NSLineBreakByClipping];
        actionLabel.numberOfLines = 1;
        [self.contentView addSubview: actionLabel];
        
        bodyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        bodyLabel.textColor = BODY_COLOR;
        //[[UIColor alloc] initWithRed:134.0f/255.0f green:139.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
        bodyLabel.numberOfLines = 0;
        [bodyLabel sizeToFit];
        [self.contentView addSubview: bodyLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 6.0f;
    frame.size.width = 308.0f;
    [super setFrame:frame];
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
    [propertyLabel setFrame:CGRectMake(56, 26.0, 200.0, 20.0)];
    [timestampLabel setFrame:CGRectMake(224, 30.0, 70.0, 16.0)];
    
    [actionLabel setFrame:CGRectMake(14, 66.0, 280.0, 18.0)];
    
    NSAttributedString *attributedBodyText = [CardCell attributedBodyText:bodyLabel.text];
    CGRect newFrame = CGRectMake(14, 100.0, 280, [CardCell heightOfBody:attributedBodyText]);
    [bodyLabel setFrame:newFrame];
    
    [self drawShadow];
    
    if (shouldDrawSeparator) {
        [self.contentView addSubview:separatorLineView];
    } else {
        [separatorLineView removeFromSuperview];
    }
    
}

- (void) drawShadow
{
    self.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = .05;
    CGRect shadowFrame =  CGRectMake(self.layer.bounds.origin.x, self.layer.bounds.origin.y + self.layer.bounds.size.height, self.layer.bounds.size.width, 1);
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    [self.layer setShadowPath:shadowPath];

}

- (void)configureForItem:(FeedItem *)item
{
    NSAssert(NO, @"ConfigureForItem must be overwritten in a subclass.");
    
}

-(NSString *)propertyFormatter:(NSString *)property {
    if ([property length] > 26) {
        NSRange range = [property rangeOfComposedCharacterSequencesForRange:(NSRange){0, 26}];
        property = [property substringWithRange:range];
        property = [property stringByAppendingString:@"…"];
    }
    return property;
}

+ (NSAttributedString *) attributedBodyText:(NSString *)bodyText
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = .5;
    UIFont *font = [UIFont fontWithName:@"Avenir-Book" size:14.5];
    
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
    [bodyText boundingRectWithSize:CGSizeMake(280.0, CGFLOAT_MAX)
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
