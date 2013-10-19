//
//  StripeSettingsViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "StripeSettingsViewController.h"
#import "OAuthViewController.h"



@interface StripeSettingsViewController ()

@end

@implementation StripeSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.provider = [MTLJSONAdapter modelOfClass:Provider.class fromJSONDictionary:[[AppDelegate sharedDelegate].store.account.providers valueForKey:@"stripe"] error:nil];
        
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Charge succeeded", @NO], @[@"Charge refunded", @NO], @[@"Dispute created", @YES], @[@"Invoice failed", @YES], @[@"Subscription deleted", @YES], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.providerHeroImageView.image = [UIImage imageNamed:@"logo_stripe.png"];
    
    self.eventsViewController.view.frame = CGRectMake(0, 200, 240, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
}

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    [self.connectButton setBackgroundColor:[UIColor colorWithRed:87.0f/255.0f green:146.0f/255.0f blue:239.0f/255.0f alpha:1.0f]];
    [self.connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.connectButton setTitle:@"Connect to Stripe" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.connectButton];

}

- (void) setupConnectedState
{
    [super setupConnectedState];
    
    [self.scrollView addSubview:self.followButton];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (void)connect
{
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:@"http://www.triaged.co/services/authenticate_for/stripe_connect"];
    oAuthVC.delegate = self;
    [self.navigationController presentViewController:oAuthVC animated:YES completion:nil];
}

-(void) oAuthRequestDidSucceed
{
    [self.provider connect];
    [self setupConnectedState];
    
    // Set this automatically on succesful oAuth
    [self toggleFollow];
    
    //update our store account from the server
    [[AppDelegate sharedDelegate].store fetchRemoteUserAccount];
}

-(void) oAuthRequestDidFail
{
    [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
}

@end
