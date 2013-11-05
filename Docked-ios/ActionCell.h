//
//  ActionCell.h
//  Triage-ios
//
//  Created by Charlie White on 11/4/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionCell : UITableViewCell

@property (strong, nonatomic) UILabel *actionLabel;
@property (strong, nonatomic) UIImageView *actionIconView;

- (void)configureForItem:(NSDictionary *)actionDict;

@end
