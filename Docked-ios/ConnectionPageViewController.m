//
//  ConnectionPageViewController.m
//  Triage-ios
//
//  Created by Charlie White on 10/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ConnectionPageViewController.h"
#import "ProviderSettingCell.h"
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
    
    headlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,40, 300, 80)];
    [headlineLabel setFont: [UIFont fontWithName:@"Avenir-Book" size:21.0]];
    headlineLabel.textColor = TINT_COLOR;
    headlineLabel.numberOfLines = 2;
    headlineLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:headlineLabel];
    
    connectionsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, 320, 340) style:UITableViewStyleGrouped];
    
    connectionsTable.dataSource = self;
    connectionsTable.delegate = self;
    connectionsTable.separatorColor = BG_COLOR;
    connectionsTable.backgroundColor = [UIColor clearColor];
    connectionsTable.scrollEnabled = NO;
    [self.view addSubview:connectionsTable];

    }

-(void)viewWillAppear:(BOOL)animated
{
    NSPredicate *predicate;
    
    if (index == 0){
        headlineLabel.text = @"Where do you host code?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@ OR %K == %@)",
                     @"name", @"github", @"name", @"kiln", @"name", @"bitbucket"];
    }
    if (index == 1){
        headlineLabel.text = @"How do you track errors?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@ OR %K == %@)",
                     @"name", @"sentry", @"name", @"airbrake", @"name", @"crashlytics"];
    } else if (index == 2) {
        headlineLabel.text = @"How do you deploy your app?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@)",
                     @"name", @"heroku", @"name", @"beanstalk"];
    } else if (index == 3) {
        headlineLabel.text = @"Do you have a mobile app?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@)",
                     @"name", @"appfigures", @"name", @"hockey_app"];
    } else if (index == 4) {
        headlineLabel.text = @"How do you analyze your data?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@)",
                     @"name", @"google_analytics", @"name", @"new_relic"];
    } else if (index == 5) {
        headlineLabel.text = @"Do you accept payments online?";
        predicate = [NSPredicate predicateWithFormat:@"(%K == %@ OR %K == %@)",
                     @"name", @"stripe", @"name", @"braintree"];
    }
    
    providers = [[AppDelegate sharedDelegate].store.account.providers filteredArrayUsingPredicate:predicate];
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
    ProviderSettingCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ ProviderSettingCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    Provider *provider = providers[indexPath.row];
    
    [cell configureForSettings:provider];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *provider = providers[indexPath.row];
    Class providerSettingsClass = [provider objectForKey:@"settings_class"];
    
    BaseSettingsViewController *settingsVC = [[providerSettingsClass alloc] init];
    TRNavigationController *nav = [[TRNavigationController alloc] initWithRootViewController:settingsVC ];

    [self presentViewController:nav animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}





@end
