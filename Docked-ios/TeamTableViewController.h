//
//  TeamTableViewController.h
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

 @property (nonatomic, retain) NSArray *team;

@end
