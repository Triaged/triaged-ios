//
//  OAuthViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OAuthViewController : UIViewController <UIWebViewDelegate>

@property (strong, atomic) NSString *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (id)initWitURL:(NSString *)url;
- (IBAction)cancel:(id)sender;

@end
