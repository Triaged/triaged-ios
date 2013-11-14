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
    [headlineLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:18.0]];
    headlineLabel.textColor = [UIColor colorWithRed:181.0f/255.0f green:187.0f/255.0f blue:202.0f/255.0f alpha:1.0f];

    headlineLabel.textAlignment = NSTextAlignmentCenter;
    headlineLabel.numberOfLines = 3;
    [self.view addSubview:headlineLabel];
    
    
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (index == 0){
        headlineLabel.text = @"Everything that's happening at work, in one place.";

        cardImageView.image = [UIImage imageNamed:@"triangle.png"];
        cardImageView.frame = CGRectMake(109.5,130,101,89);
    }
    if (index == 1){
        headlineLabel.text = @"Triage monitors the services you already use,";

        cardImageView.image = [UIImage imageNamed:@"card_ga.png"];
        cardImageView.frame = CGRectMake(7.5,34,305, 282);

    } else if (index == 2) {
        headlineLabel.text = @"and pulls every important event into one simple feed.";
        cardImageView.image = [UIImage imageNamed:@"card_stripe.png"];
        cardImageView.frame = CGRectMake(7.5,101.5,305, 153);

    } else if (index == 3) {
        headlineLabel.text = @"Intelligent alerts notify you when action is needed,";
        cardImageView.image = [UIImage imageNamed:@"card_sentry.png"];
        cardImageView.frame = CGRectMake(7.5,101.5,305, 153);

        
    } else if (index == 4) {
        cardImageView.image = [UIImage imageNamed:@"card_github.png"];
        cardImageView.frame = CGRectMake(7.5,48.5,305, 253);
        headlineLabel.text = @"letting you explore, chat, resolve and share, in a single tap.";
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
