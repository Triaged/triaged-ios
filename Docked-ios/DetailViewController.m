//
//  DetailViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/26/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "DetailViewController.h"
#import "MessageTabViewController.h"
#import "MessagesTableViewController.h"
#import "ExternalLinkViewViewController.h"
#import "NewMessageViewController.h"
#import "CardCell.h"

@interface DetailViewController () {
    NewMessageViewController *newMessageVC;
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        newMessageVC = [[NewMessageViewController alloc] init];
    }
    return self;
}

- (void)setDetailItem:(FeedItem *)newDetailItem
{
    if (_feedItem != newDetailItem) {
        _feedItem = newDetailItem;
    }
}

- (void)setContentView:(UIView *)contentView
{
    if (_contentView != contentView) {
        _contentView = contentView;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [[UIColor alloc]
                                 initWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0f];

    UIImage * shareImage = [UIImage imageNamed:@"icn_share.png"];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:shareImage style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = shareButton;

    // Card View
    NSString *content = @"blah blah";
    id<DataSourceItem> cellSource = (id<DataSourceItem>)_feedItem;
    Class cellClass = [ cellSource tableViewCellClass ] ;
    NSString * cellID = NSStringFromClass( cellClass ) ;
    CardCell *cell = [ [ cellClass alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] ;
    cell.frame = CGRectMake(6, 60, 308, [cellClass heightOfContent:content] );
    cell.backgroundColor = [UIColor whiteColor];
    [cell configureForItem:_feedItem];
    
    UIView *cardBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, cell.frame.size.height)];
    cardBackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cardBackground];
    [self.view addSubview:cell];
    

    
    // External Link View
    ExternalLinkViewViewController *externalVC = [[ExternalLinkViewViewController alloc] init];
    [externalVC setExternalLink:[_feedItem externalLinkUrl]];
    externalVC.view.frame = CGRectMake(0, 60 + cell.frame.size.height, 320, 40);
    [self addChildViewController:externalVC];
    [self.view addSubview:externalVC.view];

    // Message Tab View
    MessageTabViewController *messageTabVC = [[MessageTabViewController alloc] init];
    //x, y, width, height
    NSLog(@"%f", self.view.frame.size.height);
    messageTabVC.view.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
    messageTabVC.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addChildViewController:messageTabVC];
    [self.view addSubview:messageTabVC.view];
    
    MessagesTableViewController *messagesVC = [[MessagesTableViewController alloc] init];
    //commentsVC.delegate = self;
    messagesVC.messages = _feedItem.messages;
    NSLog(@"%d", messagesVC.messages.count);
    [self addChildViewController:messagesVC];
    CGRect frame = CGRectMake(0, externalVC.view.frame.origin.y + externalVC.view.frame.size.height + 10.0, 320.0, 200.0);
    messagesVC.view.frame = frame;
    [self.view addSubview:messagesVC.tableView];
    [messagesVC didMoveToParentViewController:self];
    
    
    // Do any additional setup after loading the view.
}

- (void)addMessagesTableView
{
    
}

-(void)presentNewMessageVC {
    [newMessageVC setFeedItem:_feedItem];
    [self.navigationController presentViewController:newMessageVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
