//
//  CardPageViewController.m
//  Docked-ios
//
//  Created by Charlie White on 10/17/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "CardPageViewController.h"

@interface CardPageViewController () {
    UIImageView *cardImageView;
    UIImageView *lineDivider;
    UILabel *headlineLabel;
}

@end

@implementation CardPageViewController

@synthesize index;

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
    
    headlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,10, 240, 40)];
    [headlineLabel setFont: [UIFont fontWithName:@"AvenirNext-UltraLight" size:27.0]];
    headlineLabel.textColor = [UIColor blackColor];
    //[self.view addSubview:headlineLabel];
    
    
    cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8,46,304, 187)];
    [self.view addSubview:cardImageView];
    
    UIImage *line = [UIImage imageNamed:@"line.png"];
    lineDivider = [[UIImageView alloc] initWithImage:line];
    [self.view addSubview:lineDivider];
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (index == 0){
        headlineLabel.text = @"";
        headlineLabel.frame = CGRectMake(30,10, 260, 40);
        cardImageView.image = [UIImage imageNamed:@"triangle.png"];
        cardImageView.frame = CGRectMake(80,90,160,160);
        lineDivider.frame = CGRectNull;
    }
    if (index == 1){
        headlineLabel.text = @"Instant Insight,";
        headlineLabel.frame = CGRectMake(74,10, 172, 40);
        cardImageView.image = [UIImage imageNamed:@"card_sentry.png"];
        cardImageView.frame = CGRectMake(6,92,308, 187);
        lineDivider.frame = CGRectMake(6, 279,308, 1);
    } else if (index == 2) {
        headlineLabel.text = @"At Your Fingertips.";
        headlineLabel.frame = CGRectMake(50,10, 220, 40);
        cardImageView.image = [UIImage imageNamed:@"card_stripe.png"];
        cardImageView.frame = CGRectMake(6,116,308, 140);
        lineDivider.frame = CGRectMake(6, 254,308, 1);
    } else if (index == 3) {
        headlineLabel.text = @"React, Discuss, Resolve,";
        headlineLabel.frame = CGRectMake(15,10, 290, 40);
        cardImageView.image = [UIImage imageNamed:@"card_github.png"];
        cardImageView.frame = CGRectMake(6,83,308, 205);
        lineDivider.frame = CGRectMake(6, 288,308, 1);
        
    } else if (index == 4) {
        headlineLabel.text = @"Move On.";
        headlineLabel.frame = CGRectMake(100,10, 120, 40);
        cardImageView.image = [UIImage imageNamed:@"card_ga.png"];
        cardImageView.frame = CGRectMake(6,53,308, 257);
        lineDivider.frame = CGRectMake(6,308,308, 1);
        
    }
    
    [headlineLabel setNeedsDisplay];
    [cardImageView setNeedsDisplay];
    [lineDivider setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
