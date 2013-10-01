//
//  NewMessageViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "NewMessageViewController.h"
#import "DockedAPIClient.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"

@interface NewMessageViewController ()

@end

@implementation NewMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setFeedItem:(FeedItem *)newFeedItem
{
    if (_feedItem != newFeedItem) {
        _feedItem = newFeedItem;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage * backImage = [UIImage imageNamed:@"icn_back.png"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = backButton;
    // Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated {
    [_messageBodTextView becomeFirstResponder];
}

-(IBAction)sendMessage:(id)sender{
    
    [SVProgressHUD show];
    
    NSString *path = [NSString stringWithFormat:@"feed/%@/messages.json", _feedItem.externalID];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    id params = @{@"message" : @{
                          @"author_id": appDelegate.userAccount.userID,
                          @"body": _messageBodTextView.text
                          }};
    
    
    [[DockedAPIClient sharedClient] POST:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        
        [SVProgressHUD dismiss];
        _messageBodTextView.text = @"";
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
    }];
    
}

-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
