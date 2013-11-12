//
//  VerifyViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/6/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "VerifyViewController.h"

@interface VerifyViewController ()

@end

@implementation VerifyViewController

@synthesize verifyButton, verifyCodeLabel, lineView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame = [AppDelegate sharedDelegate].window.frame;
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardWillShow:)
//                                                     name:UIKeyboardWillShowNotification
//                                                   object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    verifyButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    
    UIColor *color = [UIColor whiteColor];
    verifyCodeLabel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Verification Code" attributes:@{NSForegroundColorAttributeName: color}];
}

//-(void)keyboardWillShow:(NSNotification*)notification  {
//
//    NSDictionary *userInfo = notification.userInfo;
//
//    //
//    // Get keyboard size.
//    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue fromView:nil];
//
//    //
//    // Get keyboard animation.
//
//    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration = durationValue.doubleValue;
//
//    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
//    UIViewAnimationCurve animationCurve = curveValue.intValue;
//
//    //
//    // Create animation.
//    void (^animations)() = ^() {
//        // Login Button
//        verifyButton.frame = CGRectMake(verifyButton.frame.origin.x, verifyButton.frame.origin.y-keyboardEndFrame.size.height, verifyButton.frame.size.width, verifyButton.frame.size.height);
//
//
//        // Fields
//        CGRect verifyFrame = verifyCodeLabel.frame;
//        verifyFrame.origin.y = verifyFrame.origin.y - 140;
//        verifyCodeLabel.frame = verifyFrame;
//
//        CGRect lineFrame = lineView.frame;
//        lineFrame.origin.y = lineFrame.origin.y - 140;
//        lineView.frame = lineFrame;
//
//    };
//
//
//    //
//    // Begin animation.
//    [UIView animateWithDuration:animationDuration
//                          delay:0.0
//                        options:(animationCurve << 16)
//                     animations:animations
//                     completion:NULL];
//
//}



- (IBAction)verify:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
