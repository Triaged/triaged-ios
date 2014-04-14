//
//  MessagesTableViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MessagesTableViewController.h"
#import "MessageCell.h"
#import "FetchedMessagesDataSource.h"
#import "NiceJobViewController.h"

@interface MessagesTableViewController ()

@property (nonatomic, strong) FetchedMessagesDataSource *fetchedMessagesDataSource;
@property (nonatomic, strong) NSFetchedResultsController *_fetchedResultsController;

@end

@implementation MessagesTableViewController

@synthesize messages, _fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc]
                                 initWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    
    UIColor *borderColor = BORDER_COLOR;
    [self.tableView setSeparatorColor:borderColor];
    
    NiceJobViewController *niceJob = [[NiceJobViewController alloc] init];
    niceJob.view.backgroundColor = [UIColor whiteColor];
    //[niceJob.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [niceJob.view setNeedsLayout];
//    [niceJob.view layoutIfNeeded];
    //CGRect headerFrame = CGRectMake(0.0, 0.0, 310.0, 44.0);
    //niceJob.view.frame = headerFrame;
//
    //[niceJob.view autoSetDimension:ALDimensionHieght toSize:44];
    self.tableView.tableHeaderView = niceJob.view;
   // [niceJob.view autoSetDimension:ALDimensionHeight toSize:44.0];
    
    
//    
    [self setupFetchedResultsController];
}

- (void)sizeHeaderToFit
{
    UIView *header = self.tableView.tableHeaderView;
    
    [header setNeedsLayout];
    [header layoutIfNeeded];
    
    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = header.frame;
    
    frame.size.height = height;
    header.frame = frame;
    
    self.tableView.tableHeaderView = header;
}



- (void)setupFetchedResultsController
{
    self.fetchedMessagesDataSource = [[FetchedMessagesDataSource alloc] init];
    self.fetchedMessagesDataSource.fetchedResultsController = [self fetchedResultsController];

    self.tableView.dataSource = self.fetchedMessagesDataSource;
    self.tableView.delegate = self.fetchedMessagesDataSource;

}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(feedItem == %@)", self.feedItem];
        
        _fetchedResultsController = [Message MR_fetchAllSortedBy:@"timestamp"
                                                        ascending:YES
                                                    withPredicate:predicate
                                                          groupBy:nil
                                                         delegate:self.fetchedMessagesDataSource];
    }
    return _fetchedResultsController;
}

- (void)refreshDataSource {
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}



@end
