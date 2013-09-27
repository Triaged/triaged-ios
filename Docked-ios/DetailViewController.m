//
//  DetailViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/26/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "DetailViewController.h"
#import "TextCardViewController.h"
#import "MessageTabViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(FeedItem *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc]
                                      initWithRed:204.0f/255.0f green:207.0f/255.0f blue:207.0f/255.0f alpha:1.0f];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    
    // Card View
    TextCardViewController *textCardVC = [[TextCardViewController alloc] init];
    [textCardVC setDetailItem:_detailItem];
    textCardVC.view.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 5);
    [self addChildViewController:textCardVC];
    [self.view addSubview:textCardVC.view];
    
    // Message Tab View
    MessageTabViewController *messageTabVC = [[MessageTabViewController alloc] init];
    //x, y, width, height
    NSLog(@"%f", self.view.frame.size.height);
    messageTabVC.view.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
    messageTabVC.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addChildViewController:messageTabVC];
    [self.view addSubview:messageTabVC.view];
    
    

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
