//
//  ConnectionIntroViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/22/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ConnectionIntroViewController.h"
#import "ConnectionWizardViewController.h"
#import "RootViewController.h"

@interface ConnectionIntroViewController () {
    int animationCount;
}

@property (nonatomic, strong) UIImageView *providersList;

@end

@implementation ConnectionIntroViewController

@synthesize getStartedButton, rootController, providersList;

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
    
    getStartedButton.backgroundColor = [[UIColor alloc] initWithRed:163.0f/255.0f green:177.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    // Do any additional setup after loading the view from its nib.
    
    
    
//    providersList = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"providers.png"]];
//    providersList.frame = CGRectMake(320, 360, 400, 30);
//    [self.view addSubview:providersList];
    
    UIImageView *stripe = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stripe.png"]];
    stripe.frame = CGRectMake(350, 400, 30, 30);
    stripe.tag = 10;
    [self.view addSubview:stripe];
    
    UIImageView *ga = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"google_analytics.png"]];
    ga.frame = CGRectMake(350, 400, 30, 30);
    ga.tag = 11;
    [self.view addSubview:ga];
    
    UIImageView *github = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"github.png"]];
    github.frame = CGRectMake(350, 400, 30, 30);
    github.tag = 12;
    [self.view addSubview:github];
    
    UIImageView *sentry = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sentry.png"]];
    sentry.frame = CGRectMake(350, 400, 30, 30);
    sentry.tag = 13;
    [self.view addSubview:sentry];
    
    UIImageView *airbrake = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"airbrake.png"]];
    airbrake.frame = CGRectMake(350, 400, 30, 30);
    airbrake.tag = 14;
    [self.view addSubview:airbrake];
    
    UIImageView *heroku = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heroku.png"]];
    heroku.frame = CGRectMake(350, 400, 30, 30);
    heroku.tag = 15;
    [self.view addSubview:heroku];
    
    UIImageView *kiln = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kiln.png"]];
    kiln.frame = CGRectMake(350, 400, 30, 30);
    kiln.tag = 16;
    [self.view addSubview:kiln];
    
    UIImageView *newRelic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_relic.png"]];
    newRelic.frame = CGRectMake(350, 400, 30, 30);
    newRelic.tag = 17;
    [self.view addSubview:newRelic];
    
    animationCount = 10;

}


-(void) viewDidAppear:(BOOL)animated {
    [self animateProvider:10];
}

- (void) animateProvider:(NSUInteger)index {
    if (animationCount == 18) return;
    UIView *Providerview = [self.view viewWithTag:index];
    
    [UIView animateWithDuration:0.8
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         if (IS_IPHONE5) {
             Providerview.frame = CGRectMake(130, 340, 60, 60);
         } else {
             Providerview.frame = CGRectMake(130, 320, 60, 60);
         }
         
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.6
                               delay:0.4
                             options: UIViewAnimationOptionCurveEaseIn
                          animations:^
          {
              Providerview.frame = CGRectMake(-60, 400, 30, 30);
          }
          completion:^(BOOL finished)
          {
              animationCount++;
              [self animateProvider:animationCount];
          }];
         
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWizard:(id)sender {
    
    ConnectionWizardViewController *connectionWizardVC = [[ConnectionWizardViewController alloc] init];
    connectionWizardVC.showingWelcomeTour = YES;
    connectionWizardVC.introController = self;
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.50;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    
    // NSLog(@"%s: controller.view.window=%@", _func_, controller.view.window);
    UIView *containerView = connectionWizardVC.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    
    
    [self presentViewController:connectionWizardVC animated:YES completion:nil];

}

-(void)dismiss {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
