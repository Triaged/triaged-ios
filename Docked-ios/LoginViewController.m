//
//  LoginViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/21/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "LoginViewController.h"
#import "DockedAPIClient.h"
#import "SVProgressHUD.h"
#import "SignupViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameTextField, passwordTextField, welcomeVC, loginButton, triangeImage, logoLabel, divider1, divider2, backButton;

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
    loginButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login {
    [SVProgressHUD show];
    
    id params = @{@"user_login" : @{
                  @"email": self.usernameTextField.text,
                  @"password": self.passwordTextField.text
                  }};
    
    [[DockedAPIClient sharedClient] POST:@"users/sign_in.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        NSString *authToken = [JSON valueForKeyPath:@"auth_token"];
        [[CredentialStore sharedClient] setAuthToken:authToken];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
        
        [SVProgressHUD dismiss];
        [welcomeVC dismissAuthScreens:self];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
//        if (operation.response.statusCode == 500) {
//            [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
//        } else {
//            NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                 options:0
//                                                                   error:nil];
//            NSString *errorMessage = [json objectForKey:@"error"];
//            [SVProgressHUD showErrorWithStatus:errorMessage];
//        }
    }];
}

- (IBAction)returnToWelcome:(id)sender
{
    [welcomeVC presentFromVC:self];
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
        // Login Button
       loginButton.frame = CGRectMake(loginButton.frame.origin.x, loginButton.frame.origin.y-keyboardEndFrame.size.height, loginButton.frame.size.width, loginButton.frame.size.height);
        
        // Logo
        CGRect logoFrame = logoLabel.frame;
        logoFrame.origin.y = 30;
        logoLabel.frame = logoFrame;
        
        //Subtext
        triangeImage.hidden = YES;
        
        
        // Fields
        CGRect usernameFrame = usernameTextField.frame;
        usernameFrame.origin.y = usernameFrame.origin.y - 200;
        usernameTextField.frame = usernameFrame;
        
        CGRect passwordFrame = passwordTextField.frame;
        passwordFrame.origin.y = passwordFrame.origin.y - 200;
        passwordTextField.frame = passwordFrame;
        
        CGRect divider1Frame = divider1.frame;
        divider1Frame.origin.y = divider1Frame.origin.y - 200;
        divider1.frame = divider1Frame;
        
        CGRect divider2Frame = divider2.frame;
        divider2Frame.origin.y = divider2Frame.origin.y - 200;
        divider2.frame = divider2Frame;
    };
    
    
    //
    // Begin animation.
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:animations
                     completion:NULL];
    
}

@end
