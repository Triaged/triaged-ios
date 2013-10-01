//
//  CardCell.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

@synthesize titleLabel, bodyLabel, iconView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.layer.shadowOffset = CGSizeMake(0, 4);
//        self.layer.shadowColor = [[[UIColor alloc] initWithRed:190.0f/255.0f green:190.0f/255.0f blue:190.0f/255.0f alpha:1.0f] CGColor];
//        
//        self.layer.shadowRadius = 4;
//        self.layer.shadowOpacity = 0.75f;
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 3)];/// change size as you need.
        separatorLineView.backgroundColor = [[UIColor alloc] initWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:separatorLineView];
        
        
        CGRect shadowFrame = self.layer.bounds;
        CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
        self.layer.shadowPath = shadowPath;

        iconView = [[UIImageView alloc] initWithFrame: CGRectZero];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: iconView];
        
        titleLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        [titleLabel setFont: [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]];
        [titleLabel setLineBreakMode: NSLineBreakByClipping];
        titleLabel.numberOfLines = 1;
        [self.contentView addSubview: titleLabel];
        
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

-(void) layoutSubviews {
    [super layoutSubviews];
    
    [iconView setFrame:CGRectMake(10, 20.0, 30.0, 30.0)];
    [titleLabel setFrame:CGRectMake(54, 24.0, 200.0, 20.0)];

    // bodyLabel dynamic height
    CGRect paragraphRect =
    [self.bodyLabel.attributedText boundingRectWithSize:CGSizeMake(200.0, CGFLOAT_MAX)
                                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                context:nil];
    CGRect newFrame = CGRectMake(54, 56.0, paragraphRect.size.width, paragraphRect.size.height);
    [bodyLabel setFrame:newFrame];

    
    
}

+ (CGFloat) estimatedHeightOfContent {
    return 88;
}

+ (CGFloat) heightOfContent: (NSString *)content {
    return 140;
}




@end
