//
//  ProviderSettingCell.h
//  Docked-ios
//
//  Created by Charlie White on 10/9/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"
#import "User.h"

@interface ListCell : UITableViewCell

@property (strong, nonatomic) UILabel *providerLabel;
@property (strong, nonatomic) UIImageView *providerIconView;
@property (strong, nonatomic) UIImageView *connectedView;

- (void)configureForProvider:(Provider *)provider;
- (void)configureForUser:(User *)user;
- (void)configureForSettings:(Provider *)provider;
- (void)configureForAddService;

@end
