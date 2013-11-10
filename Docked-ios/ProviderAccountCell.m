//
//  ProviderAccountCell.m
//  Triage-ios
//
//  Created by Charlie White on 10/31/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ProviderAccountCell.h"

@implementation ProviderAccountCell

@synthesize accountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
//        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
//        lineView.frame = CGRectMake(0, 0, 320, 1);
//        [self.contentView addSubview: lineView];
        
        accountLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 8, 200, 30)];
        [accountLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:17.0]];
        accountLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        [accountLabel setLineBreakMode: NSLineBreakByClipping];
        accountLabel.numberOfLines = 1;
        [self.contentView addSubview: accountLabel];
        
        UIImage *lineSeparator1 = [UIImage imageNamed:@"line.png"];
        UIImageView *lineView1 = [[UIImageView alloc] initWithImage:lineSeparator1];
        lineView1.frame = CGRectMake(0, 43, 320, 1);
        [self.contentView addSubview: lineView1];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
