//
//  EventCell.m
//  Docked-ios
//
//  Created by Charlie White on 10/16/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

@synthesize eventLabel, pushNotificationSwitch, connectedView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.frame = CGRectMake(20, 0, 300, 1);
        [self.contentView addSubview: lineView];
        
        eventLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 7, 200, 30)];
        [eventLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:17.0]];
        eventLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];

        [eventLabel setLineBreakMode: NSLineBreakByClipping];
        eventLabel.numberOfLines = 1;
        [self.contentView addSubview: eventLabel];
        
//        pushNotificationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(250, 8, 49, 32)];
//        pushNotificationSwitch.enabled = NO;
//        [self.contentView addSubview:pushNotificationSwitch];
        connectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_connected.png"]];
        connectedView.frame = CGRectMake(288, 14, 24, 20);
        [self.contentView addSubview:connectedView];
    }
    return self;
}

@end
