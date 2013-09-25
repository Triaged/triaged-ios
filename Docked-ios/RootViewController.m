//
//  RootViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/19/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "RootViewController.h"
#import "FeedTableViewController.h"
#import "NotificationsViewController.h"
#import "CredentialStore.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "GithubSettingsViewController.h"
#import "StripeSettingsViewController.h"

@interface RootViewController () {
    LoginViewController *loginVC;
    SignupViewController *signupVC;
}

@end

@implementation RootViewController

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
    //[self setNavigationBarHidden:YES animated:NO];
   self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:204.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:1.0f];
    self.view.backgroundColor = [[UIColor alloc] initWithRed:204.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:1.0f];

    self.navigationController.navigationBar.translucent = NO; 
    self.revealController = [self revealViewController];
    
    
    [self setupViewControllers];
    [self addSettingsButton];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {

    // Check for authentication
    if (![[CredentialStore sharedClient] isLoggedIn]) {
        loginVC = [[LoginViewController alloc] init];
        signupVC = [[SignupViewController alloc] init];
        
        loginVC.rootVC = self;
        signupVC.rootVC = self;
        
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupViewControllers {
    FeedTableViewController *feedTableView = [[FeedTableViewController alloc] init];
//    feedTableView.view.frame = self.view.frame;
    feedTableView.view.frame = CGRectMake(6, self.view.frame.origin.y, self.view.frame.size.width - 12, self.view.frame.size.height);
    

    feedTableView.navController = self.navigationController;
    [self.view addGestureRecognizer:self.revealController.panGestureRecognizer];
    
    [self.view addSubview:feedTableView.view];
}

- (void)addSettingsButton {
    UIImage * buttonImage = [UIImage imageNamed:@"menu.png"];

    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:buttonImage style:UIBarButtonItemStyleDone target:self action:@selector(toggleSettingsMenu:)];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
//    // Left Button
//    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    settingsButton.frame = CGRectMake(20, 30, 36, 36);
//    [settingsButton addTarget:self action:@selector(toggleSettingsMenu:) forControlEvents:UIControlEventTouchUpInside];
//    UIImage * buttonImage = [UIImage imageNamed:@"settings.png"];
//    [settingsButton setImage:buttonImage forState:UIControlStateNormal];
//    
//    [self.view addSubview:settingsButton];
//    
//    
//    // Right Button
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(280, 30, 36, 36);
//    [rightButton addTarget:self.revealController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    UIImage * rightButtonImage = [UIImage imageNamed:@"settings.png"];
//    [rightButton setImage:rightButtonImage forState:UIControlStateNormal];
//    
//    [self.view addSubview:rightButton];
}

- (void)toggleSettingsMenu:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"heart"],
                        [UIImage imageNamed:@"chat"],
                        [UIImage imageNamed:@"chat"],
                        [UIImage imageNamed:@"chat"],
                        [UIImage imageNamed:@"chat"],
                        [UIImage imageNamed:@"chat"],
                        [UIImage imageNamed:@"chat"]
                        ];
    
    NSArray *colors = @[ [UIColor blueColor], [UIColor blueColor], [UIColor blueColor], [UIColor blueColor], [UIColor blueColor], [UIColor blueColor], [UIColor blueColor], [UIColor blueColor]];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc]
                                 initWithImages:images selectedIndices:indexSet borderColors:colors];
    callout.delegate = self;
    [callout show];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"tapped:");
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    if(index == 0) {
        FeedTableViewController *feedVC = [[FeedTableViewController alloc] init];
        [self.navigationController pushViewController:feedVC animated:NO];
    } else if (index == 1) {
        GithubSettingsViewController *ghsVC = [[GithubSettingsViewController alloc] init];
        [self.navigationController pushViewController:ghsVC animated:NO];
    } else if (index == 2) {
        StripeSettingsViewController *stripeVC = [[StripeSettingsViewController alloc] init];
        [self.navigationController pushViewController:stripeVC animated:NO];
    }
    
    [sidebar dismiss];
    
    
}

- (void) presentLoginView {
    [UIView transitionFromView:signupVC.view
                        toView:loginVC.view
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil];

}

- (void) presentSignupView {
    [UIView transitionFromView:loginVC.view
                        toView:signupVC.view
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
