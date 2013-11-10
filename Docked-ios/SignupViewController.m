//
//  SignupViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "SignupViewController.h"
#import "DockedAPIClient.h"
#import "SVProgressHUD.h"
#import "CredentialStore.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize welcomeVC, signupButton, logoLabel, triangleImage, divider1, divider2, divider3, nameTextField, emailTextField, passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame = [AppDelegate sharedDelegate].window.frame;
        
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
    signupButton.backgroundColor = [[UIColor alloc] initWithRed:140.0f/255.0f green:156.0f/255.0f blue:201.0f/255.0f alpha:1.0f];
    
    UIColor *color = [UIColor whiteColor];
    nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Work Email" attributes:@{NSForegroundColorAttributeName: color}];
    
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signup {
    [SVProgressHUD show];
    
    id params = @{ @"registration" : @{
      @"name": self.nameTextField.text,
      @"email": self.emailTextField.text,
      @"password": self.passwordTextField.text
      }};
    
    [[DockedAPIClient sharedClient] POST:@"/api/v1/users.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        // Set Auth Code
        NSString *authToken = [JSON valueForKeyPath:@"authentication_token"];
        [[CredentialStore sharedClient] setAuthToken:authToken];
        
        // Set current user
        NSValueTransformer *transformer;
        transformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:Account.class];
        [AppDelegate sharedDelegate].store.account = [transformer transformedValue:JSON];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
        
        [SVProgressHUD dismiss];
        [welcomeVC dismissAuthScreens:self];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error.userInfo objectForKey:@"JSONResponseSerializerWithDataKey"]);
        [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:@"JSONResponseSerializerWithDataKey"]];
//      if (operation.response.statusCode == 500) {
//        } else {
//            NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                options:0 error:nil];
//            NSString *errorMessage = [json objectForKey:@"error"];
//            [SVProgressHUD showErrorWithStatus:errorMessage];
//        }
    }];
}

- (IBAction)returnToWelcome:(id)sender
{
    [welcomeVC presentSelfFromVC:self];
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
        signupButton.frame = CGRectMake(signupButton.frame.origin.x, signupButton.frame.origin.y-keyboardEndFrame.size.height, signupButton.frame.size.width, signupButton.frame.size.height);
        
        // Logo
        CGRect logoFrame = logoLabel.frame;
        logoFrame.origin.y = 30;
        logoLabel.frame = logoFrame;
        
        //Subtext
        triangleImage.hidden = YES;
        if (!IS_IPHONE5) logoLabel.hidden = YES;
        
        CGRect usernameFrame = nameTextField.frame;
        CGRect emailTextFrame = emailTextField.frame;
        CGRect passwordFrame = passwordTextField.frame;
        CGRect divider1Frame = divider1.frame;
        CGRect divider2Frame = divider2.frame;
        CGRect divider3Frame = divider3.frame;

        if (IS_IPHONE5) {
            usernameFrame.origin.y = usernameFrame.origin.y - keyboardEndFrame.size.height;
            emailTextFrame.origin.y = emailTextFrame.origin.y - keyboardEndFrame.size.height;
            passwordFrame.origin.y = passwordFrame.origin.y - keyboardEndFrame.size.height;
            divider1Frame.origin.y = divider1Frame.origin.y - keyboardEndFrame.size.height;
            divider2Frame.origin.y = divider2Frame.origin.y - keyboardEndFrame.size.height;
            divider3Frame.origin.y = divider3Frame.origin.y - keyboardEndFrame.size.height;
        } else {
            usernameFrame.origin.y = usernameFrame.origin.y     - 200;
            emailTextFrame.origin.y = emailTextFrame.origin.y   - 200;
            passwordFrame.origin.y = passwordFrame.origin.y     - 200;
            divider1Frame.origin.y = divider1Frame.origin.y     - 200;
            divider2Frame.origin.y = divider2Frame.origin.y     - 200;
            divider3Frame.origin.y = divider3Frame.origin.y     - 200;
        }
        
        // Fields
        
        
        nameTextField.frame = usernameFrame;
        emailTextField.frame = emailTextFrame;
        passwordTextField.frame = passwordFrame;
        divider1.frame = divider1Frame;
        divider2.frame = divider2Frame;
        divider3.frame = divider3Frame;
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
