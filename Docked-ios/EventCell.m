//
//  EventCell.m
//  Docked-ios
//
//  Created by Charlie White on 10/16/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

@synthesize eventLabel, pushNotificationSwitch;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        lineView.frame = CGRectMake(20, 0, 300, 1);
        [self.contentView addSubview: lineView];
        
        eventLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 8, 200, 30)];
        [eventLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:17.0]];
        eventLabel.textColor = [UIColor blackColor];
        [eventLabel setLineBreakMode: NSLineBreakByClipping];
        eventLabel.numberOfLines = 1;
        [self.contentView addSubview: eventLabel];
        
        pushNotificationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(250, 8, 49, 32)];
        pushNotificationSwitch.enabled = NO;
        [self.contentView addSubview:pushNotificationSwitch];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
