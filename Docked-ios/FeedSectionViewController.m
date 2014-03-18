//
//  FeedSectionViewController.m
//  Triage-ios
//
//  Created by Charlie White on 1/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "FeedSectionViewController.h"

@interface FeedSectionViewController ()

@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSString* dateString;

@end

@implementation FeedSectionViewController

@synthesize date, dateString, dateLabel;

- (id)initWithDate:(NSDate *)currentDate
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        date = currentDate;
    }
    return self;
}

- (id)initWithDateString:(NSString *)currentDate
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        dateString = currentDate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //dateLabel.text = [[FeedSectionViewController dateFormatter] stringFromDate:date];
    dateLabel.text = dateString;
    dateLabel.backgroundColor = [UIColor colorWithRed:236.00f green:237.00f blue:238.00f alpha:0.9];
    
    self.view.backgroundColor = [UIColor colorWithRed:236.00f green:237.00f blue:238.00f alpha:0.9];
//    CALayer *bottomBorder = [CALayer layer];
//    
//    bottomBorder.frame = CGRectMake(0.0f, 41.5f, self.view.frame.size.width, 0.5f);
//    
//    UIColor *borderColor = BORDER_COLOR;
//    bottomBorder.backgroundColor = borderColor.CGColor;
//    
//    [self.view.layer addSublayer:bottomBorder];
    
    [self.view.layer setBorderWidth:0.5f];
    UIColor *borderColor = BORDER_COLOR;
    [self.view.layer setBorderColor:borderColor.CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return dateFormatter;
}



@end
