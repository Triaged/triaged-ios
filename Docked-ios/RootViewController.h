//
//  RootViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"


@interface RootViewController : UIViewController <SWRevealViewControllerDelegate>

-(void)presentLoginView;
-(void)presentSignupView;

@end
