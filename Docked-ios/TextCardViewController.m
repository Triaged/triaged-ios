//
//  TextCardViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/24/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TextCardViewController.h"

@interface TextCardViewController ()

@end

@implementation TextCardViewController

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
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.titleLabel.text = _detailItem.titleLabel;
        self.bodyLabel.text = _detailItem.bodyLabel;
        self.iconView.image = _detailItem.icon;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
