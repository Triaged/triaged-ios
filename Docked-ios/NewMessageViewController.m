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
#import "Store.h"

@interface NewMessageViewController ()

@end

@implementation NewMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)];
        self.navigationItem.leftBarButtonItem = backButton;
        
        UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sendMessage:)];
        self.navigationItem.rightBarButtonItem = sendButton;
        
        
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
    
    _messageBodyTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 26, 320, 300)];
    _messageBodyTextView.tintColor   = [UIColor blackColor];
    _messageBodyTextView.delegate = self;
    _messageBodyTextView.text = @" Your Message";
    _messageBodyTextView.textColor = [UIColor lightGrayColor]; //optional
    [self.view addSubview:_messageBodyTextView];
}

-(void) viewDidAppear:(BOOL)animated {
    [_messageBodyTextView becomeFirstResponder];
}

-(IBAction)sendMessage:(id)sender{
    
    [SVProgressHUD show];
    
    NSString *path = [NSString stringWithFormat:@"feed/%@/messages.json", _feedItem.externalID];
    id params = @{@"message" : @{
                    @"author_id": [AppDelegate sharedDelegate].store.account.userID,
                    @"body": _messageBodyTextView.text
                }};
    
    [[DockedAPIClient sharedClient] POST:path parameters:params success:^(NSURLSessionDataTask *task, id JSON) {
        [SVProgressHUD dismiss];
        _messageBodyTextView.text = @"";

        // Update the feedItem with the new message
        NSError *error = nil;
        FeedItem *updatedFeedItem = [MTLJSONAdapter modelOfClass:FeedItem.class fromJSONDictionary:JSON error:&error];
        [_feedItem mergeValuesForKeysFromModel:updatedFeedItem];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"feedUpdated" object:self];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
    }];
    
}

-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self performSelector:@selector(setCursorToBeginning:) withObject:textView afterDelay:0.0];
}

- (void)setCursorToBeginning:(UITextView *)inView
{
    inView.selectedRange = NSMakeRange(0, 0);
}

- (void)textViewDidChange:(UITextView *)textView
{
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@" Your Message" withString:@""];
    textView.textColor = [UIColor blackColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @" Your Message";
        textView.textColor = [UIColor lightTextColor]; //optional
    }
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
