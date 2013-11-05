//
//  ConnectionPageViewController.m
//  Triage-ios
//
//  Created by Charlie White on 10/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ConnectionPageViewController.h"
#import "ProviderWizardCell.h"
#import "BaseSettingsViewController.h"
#import "Provider.h"

@interface ConnectionPageViewController () {
    UILabel *headlineLabel;
    UILabel *workWarningLabel;
    UITableView *connectionsTable;
    NSArray *providers;

}

@end

@implementation ConnectionPageViewController

@synthesize index;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    headlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,40, 240, 80)];
    [headlineLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:27.0]];
    headlineLabel.textColor = [UIColor whiteColor];
    headlineLabel.numberOfLines = 2;
    headlineLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:headlineLabel];
    
    connectionsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, 320, 267)];
    connectionsTable.dataSource = self;
    connectionsTable.delegate = self;
    connectionsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    connectionsTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:connectionsTable];

    
    workWarningLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 380, 280, 40)];
    [workWarningLabel setFont: [UIFont fontWithName:@"Avenir-Light" size:12.0]];
    workWarningLabel.textColor = [UIColor whiteColor];
    workWarningLabel.text = @"Your colleagues at triaged.co share connections, so, please only connect work accounts.";
    workWarningLabel.numberOfLines = 2;
    workWarningLabel.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:workWarningLabel];

}

-(void)viewWillAppear:(BOOL)animated
{
    NSPredicate *predicate;
    
    if (index == 0){
        headlineLabel.text = @"Where do you host code?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@)",
                     @"id", @"github", @"id", @"kiln"];
    }
    if (index == 1){
        headlineLabel.text = @"How do you track exceptions?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@)",
                     @"id", @"sentry", @"id", @"airbrake"];
    } else if (index == 2) {
        headlineLabel.text = @"Where do you host your app?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@)",
                     @"id", @"heroku"];
    } else if (index == 3) {
        headlineLabel.text = @"How do you analyze your app?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@)",
                     @"id", @"google_analytics", @"id", @"new_relic"];
    } else if (index == 4) {
        headlineLabel.text = @"Do you accept payments online?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@)",
                     @"id", @"stripe"];
    }
    
    providers = [[Provider currentProviders] filteredArrayUsingPredicate:predicate];
    [connectionsTable reloadData];
    [connectionsTable setNeedsDisplay];
   [headlineLabel setNeedsDisplay];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return providers.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"ProviderCell";
    ProviderWizardCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ ProviderWizardCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    NSDictionary *provider = providers[indexPath.row];
    
    [cell configureForItem:provider];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *provider = providers[indexPath.row];
    Class providerSettingsClass = [provider objectForKey:@"settings_class"];
    
    BaseSettingsViewController *settingsVC = [[providerSettingsClass alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:settingsVC ];
    
    for (UIView *view in nav.navigationBar.subviews) {
        for (UIView *view2 in view.subviews) {
            if ([view2 isKindOfClass:[UIImageView class]]) {
                [view2 removeFromSuperview];
            }
        }
    }
    nav.navigationBar.barTintColor = [UIColor whiteColor];

    
    [self presentViewController:nav animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96;
}





@end
