//
//  OAuthViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "OAuthViewController.h"
#import "UIWebView+AFNetworking.h"
#import "CredentialStore.h"

@interface OAuthViewController ()

@end

@implementation OAuthViewController

@synthesize url, webView, titleLabel, cancelButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWitURL:(NSString *)newUrl
{
    self = [super init];
    if (self) {
        self.url = newUrl;
        self.view.frame = [AppDelegate sharedDelegate].window.frame;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    
    if ([request respondsToSelector:@selector(setValue:forHTTPHeaderField:)]) {
        CredentialStore *store = [[CredentialStore alloc] init];
        NSString *authToken = [store authToken];
        [request setValue:authToken forHTTPHeaderField:@"authorization"];
    }
    
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *completeUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/services/oauth_complete"];
    if ([[request.URL.absoluteString lowercaseString] isEqualToString:completeUrl]) {
        
        //update our store account from the server
//        [MTLAccount fetchRemoteUserAccountWithBlock:^(MTLAccount * account) {
//            [AppDelegate sharedDelegate].store.account = account;
//            [self dismissViewControllerAnimated:YES completion:nil];
//            [self.delegate oAuthRequestDidSucceed];
//            
//        }];
    } else {
        // @TODO: Check for success: false
        //[self dismissViewControllerAnimated:YES completion:nil];
        //[self.delegate oAuthRequestDidFail];
        
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@", [error localizedDescription]);
    [CSNotificationView showInViewController:self
                                       style:CSNotificationViewStyleError
                                     message:@"Request failed to load."];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
