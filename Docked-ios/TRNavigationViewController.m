//
//  TRNavigationViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/5/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TRNavigationViewController.h"
#import "UIProgressView+AFNetworking.h"

@interface TRNavigationViewController ()

@end

@implementation TRNavigationViewController

@synthesize progress;

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
	// Do any additional setup after loading the view.
    for (UIView *view in self.navigationBar.subviews) {
        for (UIView *view2 in view.subviews) {
            if ([view2 isKindOfClass:[UIImageView class]]) {
                [view2 removeFromSuperview];
            }
        }
    }
    
    //self.navigationBar.layer.opacity = 0.0;
    
    self.navigationBar.barTintColor = BAR_TINT_COLOR;
    self.navigationBar.translucent = NO;
    
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navbar.png"] forBarMetrics:UIBarMetricsDefault];

    
    progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];;
    [self.view addSubview:progress];
    UINavigationBar *navBar = [self navigationBar];
    
#if 1
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navBar]-0-[progress]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(progress, navBar)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[progress]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(progress)]];
#else
    NSLayoutConstraint *constraint;
    constraint = [NSLayoutConstraint constraintWithItem:progress attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:navBar attribute:NSLayoutAttributeBottom multiplier:1 constant:-0.5];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:progress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:navBar attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:progress attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:navBar attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
#endif
    [progress setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[progress setProgress:0.5 animated:NO];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
