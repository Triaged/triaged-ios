//
//  ProviderWizardCell.h
//  Triage-ios
//
//  Created by Charlie White on 10/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"

@interface ProviderWizardCell : UITableViewCell

@property (strong, nonatomic) UILabel *providerLabel;
@property (strong, nonatomic) UIImageView *providerIconView;
@property (strong, nonatomic) UIImageView *connectedView;

- (void)configureForItem:(NSDictionary *)provider;

@end
