//
//  ActionBarViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "ActionBarViewController.h"
#import "EventCard.h"
#import "Thumbsup.h"

@interface ActionBarViewController ()

@end

@implementation ActionBarViewController

@synthesize feedItem;

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

-(void)drawBottomBorder {
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, self.view.frame.origin.y + self.view.frame.size.height - 0.5, self.view.frame.size.width, 0.5);
    UIColor *borderColor = BORDER_COLOR;
    
    bottomBorder.backgroundColor = borderColor.CGColor;
    [self.view.layer addSublayer:bottomBorder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)explore:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[(EventCard *)feedItem url]]];
}

- (IBAction)assign:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Assign"
                                                      message:@"Still Working on this :)"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

- (IBAction)share:(id)sender {
    
}

- (IBAction)niceJob:(id)sender {
    Thumbsup *thumbsup = [Thumbsup MR_createEntity];
    
    thumbsup.feedItem    = feedItem;
    thumbsup.user      = [AppDelegate sharedDelegate].store.currentAccount.currentUser;
    
    [thumbsup toggleThumbsUpWithCompletionHandler:^(Thumbsup *thumbsup, NSError *error) {
    }];
}

@end
