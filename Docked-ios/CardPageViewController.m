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
    [headlineLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:19.0]];
    headlineLabel.textColor = [UIColor colorWithRed:105.0f/255.0f green:113.0f/255.0f blue:136.0f/255.0f alpha:1.0f];

    headlineLabel.textAlignment = NSTextAlignmentCenter;
    headlineLabel.numberOfLines = 3;
    [self.view addSubview:headlineLabel];
    
    
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (index == 0){
        headlineLabel.text = @"Everything that's happening at work, in one place.";
        
        UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,143, 320, 50)];
        [logoLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:40.0]];
        logoLabel.textColor = [UIColor colorWithRed:127.0f/255.0f green:147.0f/255.0f blue:212.0f/255.0f alpha:1.0f];
        logoLabel.text = @"Triage";
        logoLabel.textAlignment = NSTextAlignmentCenter;
        logoLabel.numberOfLines = 1;
        [self.view addSubview:logoLabel];
        
        
        cardImageView.image = [UIImage imageNamed:@"logo_triage.png"];
        cardImageView.frame = CGRectMake(110,47,100,100);
    }
    if (index == 1){
        headlineLabel.text = @"Triage monitors the services you already use,";

        cardImageView.image = [UIImage imageNamed:@"walkthrough_1.png"];
        cardImageView.frame = CGRectMake(7.5,34,305, 282);

    } else if (index == 2) {
        headlineLabel.text = @"and pulls every important event into one simple feed.";
        cardImageView.image = [UIImage imageNamed:@"walkthrough_2.png"];
        cardImageView.frame = CGRectMake(0,34,320, 282);

    } else if (index == 3) {
        headlineLabel.text = @"Intelligent alerts notify you when action is needed,";
        cardImageView.image = [UIImage imageNamed:@"walkthrough_3.png"];
        cardImageView.frame = CGRectMake(7.5,34,305, 282);

        
    } else if (index == 4) {
        cardImageView.image = [UIImage imageNamed:@"walkthrough_4.png"];
        cardImageView.frame = CGRectMake(7.5,34,305, 282);
        headlineLabel.text = @"helping you explore, chat, resolve and share, in a single tap.";
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
