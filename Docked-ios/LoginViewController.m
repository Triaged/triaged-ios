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

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameTextField, passwordTextField, rootVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    [[DockedAPIClient sharedClient] POST:@"/api/v1/users/sign_in.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        NSString *authToken = [JSON valueForKeyPath:@"auth_token"];
        [[CredentialStore sharedClient] setAuthToken:authToken];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
        
        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];
        
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

- (IBAction)presentSignup {
    [rootVC presentSignupView];
}

@end
