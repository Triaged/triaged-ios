//
//  SmokescreenViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface SmokescreenViewController : UIViewController

@property (strong, nonatomic) UIImageView *cardImageView;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) UINavigationController *navController;

- (void)setCardImageView:(UIImageView *)newCard;
- (void)setNavController:(UINavigationController *)navController;
- (void)setDetailViewController:(DetailViewController *)detailVC;
@end
