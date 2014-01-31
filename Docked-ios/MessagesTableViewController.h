//
//  MessagesTableViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MTLFeedItem.h"

@interface MessagesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) MTLFeedItem *feedItem;

-(void)refreshTableView;


@end
