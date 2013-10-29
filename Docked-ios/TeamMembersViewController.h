//
//  TeamMembersViewController.h
//  Triage-ios
//
//  Created by Charlie White on 10/28/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamMembersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *teamTableView;

@end
