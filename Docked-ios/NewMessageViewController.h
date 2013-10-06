//
//  NewMessageViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"

@interface NewMessageViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) FeedItem *feedItem;
@property (strong, nonatomic) UITextView *messageBodyTextView;

-(IBAction)back:(id)sender;
-(IBAction)sendMessage:(id)sender;

@end
