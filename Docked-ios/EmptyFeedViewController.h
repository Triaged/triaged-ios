//
//  EmptyFeedViewController.h
//  Triage-ios
//
//  Created by Charlie White on 11/13/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyFeedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *connectServiceButton;

- (IBAction)connectServices:(id)sender;


@end
