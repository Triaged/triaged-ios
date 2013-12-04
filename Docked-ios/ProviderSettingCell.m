//
//  ProviderSettingCell.m
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ProviderSettingCell.h"
#import "Provider.h"
#import "AppDelegate.h"
#import "Store.h"
#import "NSString+Inflections.h"

@implementation ProviderSettingCell

@synthesize providerIconView, providerLabel, connectedView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 56, 0, 0);

        providerIconView = [[UIImageView alloc] init];
        providerIconView.frame = CGRectMake(14, 10, 28, 28);
        [self.contentView addSubview: providerIconView];
        
        providerLabel = [[UILabel alloc] initWithFrame: CGRectMake(56, 10, 200, 30)];
        [providerLabel setFont: [UIFont fontWithName:@"Avenir-Roman" size:17.0]];
        providerLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];

        [providerLabel setLineBreakMode: NSLineBreakByClipping];
        providerLabel.numberOfLines = 1;
        [self.contentView addSubview: providerLabel];
        
        connectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_connected.png"]];
        connectedView.frame = CGRectMake(270, 12, 25, 25);
        

    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 6.0f;
    frame.size.width = 308.0f;
    [super setFrame:frame];
}

- (void)configureForItem:(Provider *)provider
{
    self.providerIconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", provider.name]];
    self.providerLabel.text = [provider.name titleize];
    
    connectedView.frame = CGRectMake(240, 14, 24, 20);
    
//    bool connected = provider.follows;
//    if (connected) {
//     [self.contentView addSubview: connectedView];
//    } else {
//        [connectedView removeFromSuperview];
//    }
}

- (void)configureForDict:(NSDictionary *)provider
{
    self.providerIconView.image = [UIImage imageNamed:[provider objectForKey:@"settings_icon"]];
    self.providerLabel.text = [[provider objectForKey:@"name"] titleize];
    
    Provider *providerObject = [[AppDelegate sharedDelegate].store.account providerWithName:[provider objectForKey:@"id"]];
    
    if (providerObject.connected) {
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
