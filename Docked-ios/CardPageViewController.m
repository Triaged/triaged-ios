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
    
    
    cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8,48,304, 187)];
    [self.view addSubview:cardImageView];
    
    
    headlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,324, 280, 60)];
    [headlineLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:18.0]];
    headlineLabel.textColor = [UIColor whiteColor];
    headlineLabel.textAlignment = NSTextAlignmentCenter;
    headlineLabel.numberOfLines = 3;
    [self.view addSubview:headlineLabel];
    
    
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (index == 0){
        headlineLabel.text = @"Ever felt there was a lot\nhappening at work?";

        cardImageView.image = [UIImage imageNamed:@"triangle.png"];
        cardImageView.frame = CGRectMake(80,90,160,160);
    }
    if (index == 1){
        headlineLabel.text = @"Triage informs you of the things you care about.";

        cardImageView.image = [UIImage imageNamed:@"card_ga.png"];
        cardImageView.frame = CGRectMake(6,48,308, 257);

    } else if (index == 2) {
        headlineLabel.text = @"And intelligently notifies you when action is needed.";
        cardImageView.image = [UIImage imageNamed:@"card_stripe.png"];
        cardImageView.frame = CGRectMake(6,101.5,308, 140);

    } else if (index == 3) {
        headlineLabel.text = @"It monitors all the services you already use.";
        cardImageView.image = [UIImage imageNamed:@"card_sentry.png"];
        cardImageView.frame = CGRectMake(6,78,308, 187);

        
    } else if (index == 4) {
        cardImageView.image = [UIImage imageNamed:@"card_github.png"];
        cardImageView.frame = CGRectMake(6,69,308, 205);
        headlineLabel.text = @"Assign, share, & discuss events.\nIt's better with your team.";
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
