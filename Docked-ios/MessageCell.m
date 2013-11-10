//
//  MessageCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MessageCell.h"
#import "NSDate+TimeAgo.h"
#import "UIImageView+AFNetworking.h"

@implementation MessageCell

@synthesize authorLabel, bodyLabel, moreMessagesLabel, moreMessagesIcon, shouldDrawShadow, shouldDrawMoreMessages, shouldDrawSeparator, lineView, timestampLabel, avatarView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Line Separator
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
        lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        [self.contentView addSubview: lineView];
        
        // Avatar image
        avatarView = [[UIImageView alloc] init];
        avatarView.frame = CGRectMake(14, 14, 30, 30);
        [self.contentView addSubview: avatarView];
        
        
        authorLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [authorLabel setFont: [UIFont fontWithName:@"Avenir-Medium" size:15]];
        authorLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        [authorLabel setLineBreakMode: NSLineBreakByClipping];
        authorLabel.numberOfLines = 1;
        [self.contentView addSubview: authorLabel];
        
        timestampLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [timestampLabel setFont: [UIFont fontWithName:@"Avenir-Roman" size:11.0]];
        timestampLabel.textColor = [[UIColor alloc] initWithRed:191.0f/255.0f green:198.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
        [timestampLabel setLineBreakMode: NSLineBreakByClipping];
        timestampLabel.numberOfLines = 1;
        timestampLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview: timestampLabel];
        
        
        bodyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [bodyLabel setFont: [UIFont fontWithName:@"Avenir-Roman" size:14]];
        bodyLabel.textColor = [[UIColor alloc] initWithRed:134.0f/255.0f green:139.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
        [bodyLabel setLineBreakMode: NSLineBreakByWordWrapping];
        bodyLabel.numberOfLines = 0;
        [bodyLabel sizeToFit];
        [self.contentView addSubview: bodyLabel];
        
        // Chat image
        UIImage *bubblesIcon = [UIImage imageNamed:@"icn_bubbles.png"];
        moreMessagesIcon = [[UIImageView alloc] initWithImage:bubblesIcon];
        
        
        moreMessagesLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [moreMessagesLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:12.0]];
        moreMessagesLabel.textColor = [[UIColor alloc]initWithRed:122.0f/255.0f green:141.0f/255.0f blue:196.0f/255.0f alpha:1.0f];
        moreMessagesLabel.textAlignment = NSTextAlignmentRight;
        [moreMessagesLabel setLineBreakMode: NSLineBreakByClipping];
        moreMessagesLabel.numberOfLines = 1;
        
        
        //self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)configureForMessage:(Message *)message
{
    authorLabel.text = message.author.name;
    timestampLabel.text = [message.timestamp timeAgo];
    bodyLabel.text = message.body;
    
    NSURL *avatarUrl = [NSURL URLWithString:message.author.avatarUrl];
    [avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    
}



-(void) layoutSubviews {
    [super layoutSubviews];
    
    [authorLabel setFrame:CGRectMake(56.0, 14.0, 220.0, 18.0)];
    [timestampLabel setFrame:CGRectMake(220.0, 16.0, 75.0, 12.0)];

    NSAttributedString *attributedBodyText = [MessageCell attributedBodyText:bodyLabel.text];
    CGRect newFrame = CGRectMake(56.0, 34.0, 240, [MessageCell heightOfBody:attributedBodyText]);
    [bodyLabel setFrame:newFrame];
    
    if (shouldDrawSeparator) lineView.frame = CGRectMake(6, 1, 296, 1);
    if (shouldDrawShadow) [self drawShadow];
    
    if (shouldDrawMoreMessages) {
       [self layoutMoreMessages];
    } else {
        [self removeMoreMessages];
    }
}

-(void) layoutMoreMessages
{
    [moreMessagesIcon setFrame:CGRectMake(227, bodyLabel.frame.size.height+39, 14, 14)];
    [moreMessagesLabel setFrame:CGRectMake(240.0, bodyLabel.frame.size.height+36, 55.0, 20.0)];
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
    [self.layer setShadowPath:[[UIBezierPath
                                bezierPathWithRect:self.bounds] CGPath]];
}


+ (NSAttributedString *) attributedBodyText:(NSString *)bodyText
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    UIFont *font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    
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
    [bodyText boundingRectWithSize:CGSizeMake(240.0, CGFLOAT_MAX)
                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                           context:nil];
    return paragraphRect.size.height;
}



+ (CGFloat) heightOfContent: (Message *)message hasMultipleMessages:(BOOL)multiple;
{
//    static NSCache* heightCache = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        heightCache = [NSCache new];
//    });
//    
//    NSAssert(heightCache, @"Height cache must exist");
//    
//    NSString* key = message.externalID; //Create a unique key here
//    NSNumber* cachedValue = [heightCache objectForKey: key];
//    
//    if( cachedValue )
//        return [cachedValue floatValue];
//    else {
        NSAttributedString *attributedBodyText = [MessageCell attributedBodyText:message.body];
        CGFloat bodyHeight = [MessageCell heightOfBody:attributedBodyText];
        CGFloat height;
        if(multiple) {
            height =  (62 + bodyHeight);
        } else {
            height = (42 + bodyHeight);
        }
//        [heightCache setObject: [NSNumber numberWithFloat: height] forKey: key];
        return height;
//    }
}

@end
