//
//  ActionBarViewController.h
//  Triage-ios
//
//  Created by Charlie White on 1/29/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"

@interface ActionBarViewController : UIViewController

@property (strong, nonatomic) FeedItem *feedItem;
@property (weak, nonatomic) IBOutlet UIButton *exploreButton;
@property (weak, nonatomic) IBOutlet UIButton *niceJobButton;
@property (weak, nonatomic) IBOutlet UIButton *assignButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

- (IBAction)explore:(id)sender;
- (IBAction)assign:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)niceJob:(id)sender;

-(void)drawBottomBorder;

@end
