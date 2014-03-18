//
//  TeammateHeaderViewController.h
//  Triage-ios
//
//  Created by Charlie White on 3/3/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeammateHeaderViewController : UIViewController

@property (weak, nonatomic)  User *user;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarIcon;

@end
