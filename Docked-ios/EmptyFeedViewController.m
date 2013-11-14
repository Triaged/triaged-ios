//
//  EmptyFeedViewController.m
//  Triage-ios
//
//  Created by Charlie White on 11/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "EmptyFeedViewController.h"
#import "ConnectionWizardViewController.h"

@interface EmptyFeedViewController ()

@end

@implementation EmptyFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor clearColor];
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

- (IBAction)connectServices:(id)sender {
    ConnectionWizardViewController *connectionWizard = [[ConnectionWizardViewController alloc] init];
    [self.navigationController presentViewController:connectionWizard animated:YES completion:nil];
}
@end
