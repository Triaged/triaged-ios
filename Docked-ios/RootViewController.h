//
//  RootViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface RootViewController : UIViewController <RNFrostedSidebarDelegate>

-(void)presentLoginView;
-(void)presentSignupView;

@end
