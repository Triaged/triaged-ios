//
//  TeammateCell.h
//  Docked-ios
//
//  Created by Charlie White on 10/16/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface TeammateCell : UITableViewCell

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *nameLabel;
@property  BOOL cellIsForInvite;

- (void)configureForItem:(User *)user;
- (void)configureForAddTeamMember;


@end
