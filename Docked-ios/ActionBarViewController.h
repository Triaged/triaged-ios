//
//  ExternalLinkViewViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"
#import <MessageUI/MessageUI.h>

@interface ActionBarViewController : UIViewController <MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) FeedItem *feedItem;
@property (weak, nonatomic) IBOutlet UIButton *externalLinkButton;
@property (strong, nonatomic) UIImage *screenShot;

-(void) disableAllActions;
-(void) enableAllActions;

@end
