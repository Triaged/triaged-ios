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

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 56, 0, 0);
//        UIImage *lineSeparator = [UIImage imageNamed:@"line.png"];
//        UIImageView *lineView = [[UIImageView alloc] initWithImage:lineSeparator];
//        lineView.frame = CGRectMake(56, 0, 250, 1);
//        [self.contentView addSubview: lineView];
        
        providerIconView = [[UIImageView alloc] init];
        providerIconView.frame = CGRectMake(14, 10, 28, 28);
        [self.contentView addSubview: providerIconView];
        
        
        providerLabel = [[UILabel alloc] initWithFrame: CGRectMake(56, 10, 160, 30)];
        [providerLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:17.0]];
        providerLabel.textColor = [[UIColor alloc] initWithRed:50.0f/255.0f green:57.0f/255.0f blue:61.0f/255.0f alpha:1.0f];

        [providerLabel setLineBreakMode: NSLineBreakByClipping];
        providerLabel.numberOfLines = 1;
        [self.contentView addSubview: providerLabel];
        
        connectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_connected.png"]];
        connectedView.frame = CGRectMake(288, 14, 24, 20);
        

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
    self.providerLabel.text = [provider.name humanize];
    
    bool connected = provider.follows;
    if (connected) {
     [self.contentView addSubview: connectedView];
    } else {
        [connectedView removeFromSuperview];
    }
}

- (void)configureForDict:(NSDictionary *)provider
{
    self.providerIconView.image = [UIImage imageNamed:[provider objectForKey:@"settings_icon"]];
    self.providerLabel.text = [[provider objectForKey:@"short_name"] humanize];
    
    Provider *providerObject = [[AppDelegate sharedDelegate].store.account providerWithName:[provider objectForKey:@"id"]];
    
//    if (providerObject.connected) {
//        self.providerLabel.text = [NSString stringWithFormat:@"%@ IS CONNECTED",
//                                   [[provider objectForKey:@"short_name"] uppercaseString] ];
//        self.providerLabel.textColor = [UIColor blackColor];
//        //[dataView addSubview:connectedView];
//    } else {
//        self.backgroundColor = [UIColor clearColor];
//        self.providerLabel.text = [NSString stringWithFormat:@"CONNECT TO %@",
//                                   [[provider objectForKey:@"short_name"] uppercaseString] ];
//        self.providerLabel.textColor = [UIColor whiteColor];
//        
//    }
}


@end
