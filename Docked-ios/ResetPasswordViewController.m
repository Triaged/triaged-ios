//
//  ResetPasswordViewController.m
//  Triage-ios
//
//  Created by Charlie White on 12/2/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "DockedAPIClient.h"
#import "SVProgressHUD.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

@synthesize emailField, resetButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    resetButton.backgroundColor = [[UIColor alloc] initWithRed:121.0f/255.0f green:147.0f/255.0f blue:212.0f/255.0f alpha:1.0f];
    
    UIColor *color = [[UIColor alloc] initWithRed:105.0f/255.0f green:113.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
    ;
    emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Work Email" attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendReset:(id)sender {
    [SVProgressHUD show];
    
    id params = @{@"email": self.emailField.text};
    
    [[DockedAPIClient sharedClient] POST:@"account/reset_password.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        [resetButton setEnabled:NO];
        [resetButton setTitle:@"Check your email" forState:UIControlStateDisabled];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSHTTPURLResponse *response = [error.userInfo objectForKey:@"AFNetworkingOperationFailingURLResponseErrorKey"];
        if (response.statusCode == 500) {
            [SVProgressHUD showErrorWithStatus:@"Something went wrong. Please try again."];
        } else {
            NSString *errorMessage = [error.userInfo objectForKey:@"JSONResponseSerializerWithDataKey"];
            NSLog(@"%@", errorMessage);
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];

}

-(void)keyboardWillShow:(NSNotification*)notification  {
    
    NSDictionary *userInfo = notification.userInfo;
    
    //
    // Get keyboard size.
    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue fromView:nil];
    
    //
    // Get keyboard animation.
    
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    //
    // Create animation.
    void (^animations)() = ^() {
        if (IS_IPHONE5) {
        // Login Button
        resetButton.frame = CGRectMake(resetButton.frame.origin.x, resetButton.frame.origin.y-keyboardEndFrame.size.height, resetButton.frame.size.width, resetButton.frame.size.height);
        } else {
            // Login Button
            resetButton.frame = CGRectMake(resetButton.frame.origin.x, resetButton.frame.origin.y-150, resetButton.frame.size.width, resetButton.frame.size.height);
        }
    };
    
    
    //
    // Begin animation.
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:animations
                     completion:NULL];
    
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
}

@end
