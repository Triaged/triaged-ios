//
//  EventCell.h
//  Docked-ios
//
//  Created by Charlie White on 10/16/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (strong, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UISwitch *pushNotificationSwitch;
@property (strong, nonatomic) UIImageView *connectedView;

@end
