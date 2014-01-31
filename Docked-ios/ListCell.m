//
//  ProviderSettingCell.m
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ListCell.h"
#import "Provider.h"
#import "AppDelegate.h"
#import "Store.h"
#import "NSString+Inflections.h"
#import "UIImageView+AFNetworking.h"

@implementation ListCell

@synthesize providerIconView, providerLabel, connectedView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 65, 0, 0);

        providerIconView = [[UIImageView alloc] init];
        providerIconView.frame = CGRectMake(12, 3.5, 40, 40);
        [self.contentView addSubview: providerIconView];
        
        providerLabel = [[UILabel alloc] initWithFrame: CGRectMake(65, 10, 200, 30)];
        [providerLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:17.0]];
        providerLabel.textColor = [[UIColor alloc] initWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];

        [providerLabel setLineBreakMode: NSLineBreakByClipping];
        providerLabel.numberOfLines = 1;
        [self.contentView addSubview: providerLabel];
        
        connectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_connected.png"]];
        connectedView.frame = CGRectMake(270, 12, 25, 25);
        

    }
    return self;
}

- (void)configureForProvider:(Provider *)provider
{
    self.providerLabel.text = provider.title;
    
    NSURL *iconUrl = [NSURL URLWithString:provider.largeIcon];
    [self.providerIconView setImageWithURL:iconUrl];
}

- (void)configureForUser:(User *)user {
    self.providerLabel.text = user.name;
    
    NSURL *avatarUrl = [NSURL URLWithString:user.avatarUrl];
    [self.providerIconView  setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
}

- (void)configureForSettings:(Provider *)provider
{
    self.providerIconView.image = [UIImage imageNamed:provider.settingsIcon];
    self.providerLabel.text = provider.title;
    
    
    if (provider.connected) {
        [self.contentView addSubview: connectedView];
    } else {
        [connectedView removeFromSuperview];
    }
}

- (void)configureForAddService {
    
    self.providerLabel.text = @"Connect New Service";
    self.providerLabel.textColor = TINT_COLOR;
    [self.providerIconView setImage:[UIImage imageNamed:@"icn_connect.png"]];
    
}


@end
