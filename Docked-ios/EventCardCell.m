//
//  EventCardCell.m
//  Triage-ios
//
//  Created by Charlie White on 1/27/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "EventCardCell.h"
#import "UIImageView+AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImageUtility.h"

@implementation EventCardCell

@synthesize bodyLabel, footerLabel, imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = BG_COLOR;
        imageView.contentMode = UIViewContentModeCenter;
        
        bodyLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        bodyLabel.textColor = BODY_COLOR;
        //[[UIColor alloc] initWithRed:134.0f/255.0f green:139.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
        bodyLabel.numberOfLines = 0;
        [bodyLabel sizeToFit];
        [self.contentView addSubview: bodyLabel];
        
        footerLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        footerLabel.textColor = BODY_COLOR;
        //[[UIColor alloc] initWithRed:134.0f/255.0f green:139.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
        footerLabel.numberOfLines = 0;
        [footerLabel sizeToFit];
        [self.contentView addSubview: footerLabel];
        
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    imageView.frame = CGRectMake(0, 92, 320, 231);
    
    NSAttributedString *attributedBodyText = [EventCardCell attributedBodyText:bodyLabel.text];
    CGRect newFrame = CGRectMake(16, 92.0, 280, [EventCardCell heightOfBody:attributedBodyText]);
    [bodyLabel setFrame:newFrame];
    
//    NSAttributedString *attributedFooterText = [EventCardCell attributedBodyText:footerLabel.text];
//    CGRect footerFrame = CGRectMake(16, newFrame.origin.y + newFrame.size.height + 20, 280, [EventCardCell heightOfBody:attributedFooterText]);
//    [footerLabel setFrame:footerFrame];

    [self.timestampIcon setFrame:CGRectMake(16, newFrame.origin.y + newFrame.size.height + 31, 12.0, 12.0)];
    [self.timestampLabel setFrame:CGRectMake(36, newFrame.origin.y + newFrame.size.height + 30, 70.0, 16.0)];
}


- (void)configureForItem:(MTLFeedItem *)item
{
    EventCard *event = (EventCard *)item;
    
    NSURL *iconUrl = [NSURL URLWithString:event.provider.largeIcon];
    [self.avatarView setImageWithURL:iconUrl];
    
    self.titleLabel.text = [event.title capitalizedString];
    self.propertyLabel.text = [event.propertyName lowercaseString];
    
    if (event.imageUrl != nil) {
        [imageView setImageWithURL:[NSURL URLWithString:event.imageUrl]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    
                    [self.contentView addSubview:imageView];
        }];
    } else {
        [imageView removeFromSuperview];
    }
    
    self.bodyLabel.attributedText = [EventCardCell attributedBodyText:event.body];
    
    self.timestampLabel.text = [item.timestamp timeAgo];
}


+ (NSAttributedString *) attributedBodyText:(NSString *)bodyText
{
    
    if(bodyText == nil) {
        bodyText = @"";
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = .5;
    UIFont *font = [UIFont fontWithName:@"Avenir-Light" size:15];
    
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
    return 160;
}

+ (CGFloat) heightOfContent: (MTLFeedItem *)item {
    
    EventCard *event = (EventCard *)item;
    
    static NSCache* heightCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        heightCache = [NSCache new];
    });
    
    NSAssert(heightCache, @"Height cache must exist");
    
    NSString* key = event.ID; //Create a unique key here
    NSNumber* cachedValue = [heightCache objectForKey: key];
    
    if( cachedValue )
        return [cachedValue floatValue];
    else {
        NSAttributedString *attributedBodyText = [EventCardCell attributedBodyText:event.body];
        CGFloat bodyHeight = [EventCardCell heightOfBody:attributedBodyText];
        CGFloat height = (400 + bodyHeight);
        
        [heightCache setObject: [NSNumber numberWithFloat: height] forKey: key];
        return height;
    }
}

@end
