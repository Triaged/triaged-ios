//
//  MessageCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

@synthesize authorLabel, bodyLabel, moreMessagesLabel, moreMessagesIcon, shouldDrawShadow, shouldDrawMoreMessages;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Line Separator
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        lineView.frame = CGRectMake(6, 1, 296, 1);
        [self.contentView addSubview: lineView];
        
        // Chat image
        UIImage *chatIcon = [UIImage imageNamed:@"avatar.png"];
        UIImageView *chatIconView = [[UIImageView alloc] initWithImage:chatIcon];
        chatIconView.frame = CGRectMake(14, 14, 30, 30);
        [self.contentView addSubview: chatIconView];
        
        
        authorLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [authorLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
        authorLabel.textColor = [UIColor blackColor];
        [authorLabel setLineBreakMode: NSLineBreakByClipping];
        authorLabel.numberOfLines = 1;
        [self.contentView addSubview: authorLabel];
        
        
        bodyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [bodyLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:14.0]];
        bodyLabel.textColor = [[UIColor alloc] initWithRed:142.0f/255.0f green:142.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        [bodyLabel setLineBreakMode: NSLineBreakByWordWrapping];
        bodyLabel.numberOfLines = 0;
        [bodyLabel sizeToFit];
        [self.contentView addSubview: bodyLabel];
        
        // Chat image
        UIImage *bubblesIcon = [UIImage imageNamed:@"icn_bubbles.png"];
        moreMessagesIcon = [[UIImageView alloc] initWithImage:bubblesIcon];
        
        
        moreMessagesLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [moreMessagesLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:12.0]];
        moreMessagesLabel.textColor = [[UIColor alloc] initWithRed:100.0f/255.0f green:101.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
        [moreMessagesLabel setLineBreakMode: NSLineBreakByClipping];
        moreMessagesLabel.numberOfLines = 1;
        
        
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    [authorLabel setFrame:CGRectMake(58.0, 14.0, 260.0, 20.0)];

    NSAttributedString *attributedBodyText = [MessageCell attributedBodyText:bodyLabel.text];
    CGRect newFrame = CGRectMake(58.0, 36.0, 260, [MessageCell heightOfBody:attributedBodyText]);
    [bodyLabel setFrame:newFrame];
    
    if (shouldDrawShadow) [self drawShadow];
    if (shouldDrawMoreMessages) {
       [self layoutMoreMessages];
    } else {
        [self removeMoreMessages];
    }
}

-(void) layoutMoreMessages
{
    [moreMessagesIcon setFrame:CGRectMake(230, bodyLabel.frame.size.height+44, 14, 14)];
    [moreMessagesLabel setFrame:CGRectMake(250.0, bodyLabel.frame.size.height+40, 50.0, 20.0)];
    [self.contentView addSubview: moreMessagesIcon];
    [self.contentView addSubview: moreMessagesLabel];
}

-(void) removeMoreMessages
{
    [moreMessagesIcon removeFromSuperview];
    [moreMessagesLabel removeFromSuperview];
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
    
    UIFont *font = [UIFont fontWithName:@"Avenir-Light" size:13.0];
    
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

+ (CGFloat) heightOfContent: (Message *)message hasMultipleMessages:(BOOL)multiple;
{
    NSAttributedString *attributedBodyText = [MessageCell attributedBodyText:message.body];
    CGFloat bodyHeight = [MessageCell heightOfBody:attributedBodyText];
    if(multiple) {
        return (71 + bodyHeight);
    } else {
        return (51 + bodyHeight);
    }
    
}

@end
