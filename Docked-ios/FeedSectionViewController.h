//
//  FeedSectionViewController.h
//  Triage-ios
//
//  Created by Charlie White on 1/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedSectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (id)initWithDate:(NSDate *)currentDate;
- (id)initWithDateString:(NSString *)currentDate;

@end
