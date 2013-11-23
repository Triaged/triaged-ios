//
//  ConnectionIntroViewController.h
//  Triage-ios
//
//  Created by Charlie White on 11/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ConnectionIntroViewController : UIViewController

@property (strong, nonatomic) RootViewController *rootController;
@property (weak, nonatomic) IBOutlet UIButton *getStartedButton;

- (IBAction)startWizard:(id)sender;

-(void)dismiss;

@end
