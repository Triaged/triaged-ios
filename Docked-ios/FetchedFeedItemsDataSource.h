//
//  FetchedFeedItemsDataSource.h
//  Triage-ios
//
//  Created by Charlie White on 3/5/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"
#import "ContainerViewCell.h"

@interface FetchedFeedItemsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (strong, nonatomic) UITableViewController *tableViewController;
@property (strong, nonatomic) DetailViewController *detail;

@property (strong, nonatomic) ContainerViewCell *viewToMove;
@property (strong, nonatomic) UITableViewCell *viewToMoveOriginalCell;
@property (nonatomic) CGRect viewToMoveOriginalFrame;
@property (strong, nonatomic) UIImageView *blurredBG;
@property (strong, nonatomic) UIButton *back;
@property BOOL showingDetail;

@end
