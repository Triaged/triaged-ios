//
//  TeamTableViewController.h
//  Triage-ios
//
//  Created by Charlie White on 1/23/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,
                                                                                NSFetchedResultsControllerDelegate>

    @property (nonatomic, retain) NSMutableArray *team;
    @property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
    @property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
