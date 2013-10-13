//
//  AccountViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


-(IBAction)logout:(id)sender;

@end
