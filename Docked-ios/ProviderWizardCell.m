//
//  ProviderWizardCell.m
//  Triage-ios
//
//  Created by Charlie White on 10/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ProviderWizardCell.h"
#import "AppDelegate.h"
#import "Store.h"

@implementation ProviderWizardCell {
    UIView* dataView;
}

@synthesize providerIconView, providerLabel, connectedView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];/// change size as you need.
        separatorLineView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:separatorLineView];
        
        dataView = [[UIView alloc] initWithFrame:CGRectMake(15, 30, 290, 45)];/// change size as you need.
        dataView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:dataView];
        
        
        

        
        providerIconView = [[UIImageView alloc] init];
        providerIconView.frame = CGRectMake(20, 8, 28, 28);
        [dataView addSubview: providerIconView];
        
        
        providerLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 8, 290, 30)];
        [providerLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:13.0]];
        providerLabel.textColor = [UIColor blackColor];
        providerLabel.textAlignment = NSTextAlignmentCenter;
        providerLabel.numberOfLines = 1;
        [dataView addSubview: providerLabel];
        
        connectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_connected.png"]];
        connectedView.frame = CGRectMake(254, 12, 24, 20);
        
        [dataView.layer setCornerRadius:20.0f];
        [dataView.layer setMasksToBounds:YES];
        [dataView.layer setBorderWidth:1.0f];
        dataView.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureForItem:(NSDictionary *)provider
{
    Provider *providerObject = [MTLJSONAdapter modelOfClass:Provider.class
                                         fromJSONDictionary:[[AppDelegate sharedDelegate].store.account.providers
                                                             valueForKey:[provider objectForKey:@"id"]] error:nil];
    self.providerIconView.image = [UIImage imageNamed:[provider objectForKey:@"settings_icon"]];

    if (providerObject.connected) {
        dataView.backgroundColor = [UIColor whiteColor];
        self.providerLabel.text = [NSString stringWithFormat:@"%@ IS CONNECTED",
                                   [[provider objectForKey:@"short_name"] uppercaseString] ];
        self.providerLabel.textColor = [UIColor blackColor];
        [dataView addSubview:connectedView];
    } else {
        self.backgroundColor = [UIColor clearColor];
        self.providerLabel.text = [NSString stringWithFormat:@"CONNECT TO %@",
                                   [[provider objectForKey:@"short_name"] uppercaseString] ];
        self.providerLabel.textColor = [UIColor whiteColor];
        
    }
}

@end
