//
//  ProviderAccountDetailsTableViewController.m
//  Triage-ios
//
//  Created by Charlie White on 10/31/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ProviderAccountDetailsTableViewController.h"
#import "ProviderAccountCell.h"

@interface ProviderAccountDetailsTableViewController ()

@end

@implementation ProviderAccountDetailsTableViewController

@synthesize accountDetails, accountDetailsTitle;

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
    
    self.navigationItem.title = accountDetailsTitle;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return accountDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"providerAccountCell";
    ProviderAccountCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ ProviderAccountCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    MTLProviderProperty *property = [accountDetails objectAtIndex:indexPath.row];
    
    cell.accountLabel.text = property.name;
    UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    switchview.tag = indexPath.row;
    [switchview addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = switchview;
    
    // Configure the cell...
    
    return cell;
}

- (void)updateSwitchAtIndexPath:(UISwitch *)aswitch{
    NSLog(@"%i",aswitch.tag);
}

@end
