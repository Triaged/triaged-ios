//
//  ContainerViewCell.h
//  Triage-ios
//
//  Created by Charlie White on 3/17/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@class DetailViewController;

@interface ContainerViewCell : UIView

@property (strong, nonatomic) DetailViewController *detailVC;
@property (strong, nonatomic) UITableViewController *tableViewController;

- (void)setBottomCornersStraight;
- (void)setAllCornersRounded;

@end
