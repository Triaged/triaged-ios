//
//  MoreMessagesCell.m
//  Docked-ios
//
//  Created by Charlie White on 10/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MoreMessagesCell.h"

@implementation MoreMessagesCell

@synthesize moreMessagesLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        lineView.frame = CGRectMake(6, 1, 296, 1);
        [self.contentView addSubview: lineView];
        
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
    
    [moreMessagesLabel setFrame:CGRectMake(250.0, 10.0, 50.0, 20.0)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) heightOfContent: (NSString *)bodyText {
    return 24;
}

@end
