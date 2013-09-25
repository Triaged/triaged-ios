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

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize rootVC;

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
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signup {
    [SVProgressHUD show];
    
    id params = @{
      @"name": self.nameTextField.text,
      @"email": self.emailTextField.text,
      @"password": self.passwordTextField.text
    };
    
    [[DockedAPIClient sharedClient] POST:@"/api/v1/users.json" parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        NSString *authToken = [JSON valueForKeyPath:@"auth_token"];
        [[CredentialStore sharedClient] setAuthToken:authToken];
        
        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
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

- (IBAction)presentLogin {
    [rootVC presentLoginView];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField{
    [textField resignFirstResponder];
    return YES;
}

@end
