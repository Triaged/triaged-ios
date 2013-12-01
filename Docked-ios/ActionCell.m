//
//  ActionCell.m
//  Triage-ios
//
//  Created by Charlie White on 11/4/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ActionCell.h"

@implementation ActionCell

@synthesize actionIconView, actionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
        lineView.frame = CGRectMake(0, 1, 304, 1);
        [self.contentView addSubview: lineView];
        
        actionIconView = [[UIImageView alloc] init];
        actionIconView.frame = CGRectMake(18, 14, 20, 20);
        [self.contentView addSubview: actionIconView];
        
        
        actionLabel = [[UILabel alloc] initWithFrame: CGRectMake(50, 10, 160, 30)];
        actionLabel.font = [UIFont fontWithName:@"Avenir-Book" size:16.0];
        actionLabel.textColor = TINT_COLOR;
        [actionLabel setLineBreakMode: NSLineBreakByClipping];
        actionLabel.numberOfLines = 1;
        [self.contentView addSubview: actionLabel];
        
    }
    return self;
}


- (void)configureForItem:(NSDictionary *)actionDict
{
    actionIconView.image = [UIImage imageNamed:[actionDict objectForKey:@"icon"]];
    actionLabel.text = [actionDict objectForKey:@"label"];
}


@end
