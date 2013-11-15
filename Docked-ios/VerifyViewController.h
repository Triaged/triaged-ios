//
//  VerifyViewController.h
//  Triage-ios
//
//  Created by Charlie White on 11/6/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (weak, nonatomic) IBOutlet UIImageView *lineView;

- (IBAction)resendEmail:(id)sender;


@end
