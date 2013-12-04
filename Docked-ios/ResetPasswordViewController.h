//
//  ResetPasswordViewController.h
//  Triage-ios
//
//  Created by Charlie White on 12/2/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)cancel:(id)sender;
- (IBAction)sendReset:(id)sender;

@end
