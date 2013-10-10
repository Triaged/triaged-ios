//
//  ProviderSettingCell.m
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ProviderSettingCell.h"

@implementation ProviderSettingCell

@synthesize providerIconView, providerLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
        
        UIImage *lineSeparator = [UIImage imageNamed:@"list_line.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        lineView.frame = CGRectMake(60, 1, 160, 1);
        [self.contentView addSubview: lineView];
        
        // Chat image

        providerIconView = [[UIImageView alloc] init];
        providerIconView.frame = CGRectMake(15, 8, 36, 36);
        [self.contentView addSubview: providerIconView];
        
        
        providerLabel = [[UILabel alloc] initWithFrame: CGRectMake(60, 10, 160, 30)];
        [providerLabel setFont: [UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
        providerLabel.textColor = [UIColor colorWithRed:181.0f/255.0f green:181.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
        [providerLabel setLineBreakMode: NSLineBreakByClipping];
        providerLabel.numberOfLines = 1;
        [self.contentView addSubview: providerLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForItem:(NSString *)provider
{
    self.providerIconView.image = [UIImage imageNamed:provider];
    self.providerLabel.text = provider;
}


@end
