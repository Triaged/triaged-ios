//
//  FeedBackgroundViewController.m
//  Triage-ios
//
//  Created by Charlie White on 12/3/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "FeedBackgroundViewController.h"
#import "FeedTableViewController.h"

@interface FeedBackgroundViewController ()
@end

@implementation FeedBackgroundViewController

@synthesize feedTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            feedTableView = [[FeedTableViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = BG_COLOR;
    

    feedTableView.view.frame = self.view.frame;
    [self addChildViewController:feedTableView];
    [self.view addSubview:feedTableView.view];
    [feedTableView didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
