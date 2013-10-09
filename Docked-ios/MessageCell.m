//
//  MessageCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

@synthesize authorLabel, bodyLabel, moreMessagesLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Line Separator
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        lineView.frame = CGRectMake(6, 1, 296, 1);
        [self.contentView addSubview: lineView];
        
        // Chat image
        UIImage *chatIcon = [UIImage imageNamed:@"icn_bubbles.png"];
        UIImageView *chatIconView = [[UIImageView alloc] initWithImage:chatIcon];
        chatIconView.frame = CGRectMake(15, 15, 16, 16);
        [self.contentView addSubview: chatIconView];
        
        
        authorLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [authorLabel setFont: [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]];
        authorLabel.textColor = [[UIColor alloc] initWithRed:100.0f/255.0f green:101.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
        //authorLabel.textColor = [UIColor blackColor];
        [authorLabel setLineBreakMode: NSLineBreakByClipping];
        authorLabel.numberOfLines = 1;
        [self.contentView addSubview: authorLabel];
        
        
        bodyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [bodyLabel setFont: [UIFont fontWithName:@"AvenirNext-Medium" size:13.0]];
        [bodyLabel setLineBreakMode: NSLineBreakByWordWrapping];
        bodyLabel.numberOfLines = 0;
        [bodyLabel sizeToFit];
        [self.contentView addSubview: bodyLabel];
        
        moreMessagesLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [moreMessagesLabel setFont: [UIFont fontWithName:@"AvenirNext-Medium" size:12.0]];
        moreMessagesLabel.textColor = [[UIColor alloc] initWithRed:100.0f/255.0f green:101.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
        [moreMessagesLabel setLineBreakMode: NSLineBreakByClipping];
        moreMessagesLabel.numberOfLines = 1;
        [self.contentView addSubview: moreMessagesLabel];

        
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    [authorLabel setFrame:CGRectMake(50.0, 13.0, 260.0, 20.0)];

    NSAttributedString *attributedBodyText = [MessageCell attributedBodyText:bodyLabel.text];
    CGRect newFrame = CGRectMake(50.0, 35.0, 260, [MessageCell heightOfBody:attributedBodyText]);
    [bodyLabel setFrame:newFrame];
    
    [moreMessagesLabel setFrame:CGRectMake(250.0, bodyLabel.frame.size.height+25, 50.0, 20.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSAttributedString *) attributedBodyText:(NSString *)bodyText
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Medium" size:13.0];
    
    NSAttributedString *attributedBodyText
    = [[NSAttributedString alloc] initWithString:bodyText
                                      attributes:[NSDictionary
                                                  dictionaryWithObjectsAndKeys:font,
                                                  NSFontAttributeName,
                                                  paragraphStyle, NSParagraphStyleAttributeName,nil]];
    return attributedBodyText;
    
}

+ (CGFloat) heightOfBody:(NSAttributedString *)bodyText
{
    // bodyLabel dynamic height
    
    CGRect paragraphRect =
    [bodyText boundingRectWithSize:CGSizeMake(260.0, CGFLOAT_MAX)
                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                           context:nil];
    return paragraphRect.size.height;
}

+ (CGFloat) heightOfContent: (Message *)message
{
    NSAttributedString *attributedBodyText = [MessageCell attributedBodyText:message.body];
    CGFloat bodyHeight = [MessageCell heightOfBody:attributedBodyText];
    return (48 + bodyHeight);
}

@end
