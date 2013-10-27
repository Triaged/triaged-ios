//
//  MessageToolbarViewController.h
//  Triage-ios
//
//  Created by Charlie White on 10/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "MLPAutoCompleteTextFieldDataSource.h"
#import "MLPAutoCompleteTextFieldDelegate.h"
#import "GGHashtagMentionController.h"

@class MLPAutoCompleteTextField;
@interface MessageToolbarViewController : UIViewController <MLPAutoCompleteTextFieldDataSource, MLPAutoCompleteTextFieldDelegate, UIGestureRecognizerDelegate, GGHashtagMentionDelegate>

@property (nonatomic, strong) DetailViewController*	detailView;
@property (nonatomic, strong) UIButton*		buttonSend;

- (void)handleTapGesture:(UIGestureRecognizer*)gesture;

@end
