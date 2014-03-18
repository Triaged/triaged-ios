//
//  AvatarCellView.h
//  Triage-ios
//
//  Created by Charlie White on 3/18/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "Provider.h"
#import "User.h"

@interface AvatarCellView : UIView

@property (strong, nonatomic) UIImageView *largeIcon;
@property (strong, nonatomic) UIImageView *smallIcon;

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, assign) BOOL smallIconExists;

- (void)setProvider:(Provider *)provider andUser:(User *)user;

@end
