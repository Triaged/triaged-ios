//
//  MessageToolbarViewController.m
//  Triage-ios
//
//  Created by Charlie White on 10/23/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "MessageToolbarViewController.h"
#import "MLPAutoCompleteTextField.h"
#import "AtReplyMessageCell.h"
#import "AppDelegate.h"
#import "Store.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+BlurredSnapshot.h"

#define kInputHeight 40.0f
#define kLineHeight 30.0f
#define kButtonWidth 78.0f

@interface MessageToolbarViewController () <UITextViewDelegate>
@property (nonatomic, strong) UIView*	imageInput;
@property (nonatomic, strong) MLPAutoCompleteTextField*	textView;
@property (nonatomic, strong) UILabel*	placeholderLabel;
@property (nonatomic, strong) UIImageView*	imageInputBack;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;
@property (nonatomic, strong) UITextView*	tempTextView;
@property (nonatomic, assign) float			previousTextFieldHeight;
@property (nonatomic, assign) BOOL shouldSearchForUser;
@property (nonatomic, retain) GGHashtagMentionController *hmc;
@property (nonatomic) NSRange currentTokenRange;


@end

@implementation MessageToolbarViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleKeyboardWillShow:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleKeyboardWillHide:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [self.textView shouldShowAutoCompleteTable:NO];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupView
{
	// Input background
    CGRect inputFrame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, kInputHeight);
	self.imageInput = [[UIView alloc] init];
    self.imageInput.backgroundColor = [[UIColor alloc] initWithRed:247.0f/255.0f green:247.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
	[self.imageInput setFrame:inputFrame];
	[self.imageInput setUserInteractionEnabled:YES];
	[self.view addSubview:self.imageInput];
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];/// change size as you need.
    separatorLineView.backgroundColor = [[UIColor alloc] initWithRed:214.0f/255.0f green:216.0f/255.0f blue:226.0f/255.0f alpha:0.7f];
    [self.imageInput addSubview:separatorLineView];
	
	// Input field
	CGFloat width = self.imageInput.frame.size.width - kButtonWidth;
    
    self.textView = [[MLPAutoCompleteTextField alloc] initWithFrame:CGRectMake(10.0f, 3.0f, width, kLineHeight)];
    [self.textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.textView setScrollIndicatorInsets:UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f)];
    [self.textView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [self.textView setScrollsToTop:NO];
    [self.textView setUserInteractionEnabled:YES];
    self.textView.backgroundColor = [[UIColor alloc] initWithRed:247.0f/255.0f green:247.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.textView setFont:[UIFont fontWithName:@"Avenir-Roman" size:15.0]];
    [self.textView setTextColor: [[UIColor alloc] initWithRed:76.0f/255.0f green:76.0f/255.0f blue:76.0f/255.0f alpha:1.0f]];
    [self.textView setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [self.textView setKeyboardType:UIKeyboardTypeTwitter];
    [self.textView registerAutoCompleteCellClass:[AtReplyMessageCell class]
                                       forCellReuseIdentifier:@"AtReplyCellID"];
    self.textView.autoCompleteDataSource = self;
    self.textView.autoCompleteDelegate = self;
    
    [self.textView setDelegate:self];
    [self.imageInput addSubview:self.textView];
    self.hmc = [[GGHashtagMentionController alloc] initWithTextView:self.textView delegate:self];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 6.0f, width, kLineHeight)];
    self.placeholderLabel.text = @"Discuss...";
    [self.placeholderLabel setFont:[UIFont fontWithName:@"Avenir-Roman" size:15.0]];
    [self.placeholderLabel setTextColor:[[UIColor alloc] initWithRed:158.0f/255.0f green:158.0f/255.0f blue:158.0f/255.0f alpha:1.0f]];
    [self.imageInput addSubview:self.placeholderLabel];

    
    // This text view is used to get the content size
	self.tempTextView = [[UITextView alloc] init];
    self.tempTextView.font = self.textView.font;
    [self.tempTextView setFont:[UIFont fontWithName:@"Avenir-Roman" size:15.0]];
    [self.tempTextView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    self.tempTextView.text = @"";
    CGSize size = [self.tempTextView sizeThatFits:CGSizeMake(self.textView.frame.size.width - 10, FLT_MAX)];
    self.previousTextFieldHeight = size.height;
    
    // Send button
    self.buttonSend = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = NSLocalizedString(@"Send",);
    [self.buttonSend setTitle:title forState:UIControlStateNormal];
    self.buttonSend.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0];
    [self.buttonSend setTitleColor:[[UIColor alloc] initWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f] forState:UIControlStateDisabled];
    [self.buttonSend setTitleColor:[[UIColor alloc] initWithRed:122.0f/255.0f green:141.0f/255.0f blue:196.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [self.buttonSend setEnabled:NO];
    [self.buttonSend setFrame:CGRectMake(self.imageInput.frame.size.width - 65.0f, 8.0f, 59.0f, kLineHeight)];
    [self.buttonSend addTarget:self	action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInput addSubview:self.buttonSend];
    

}

#pragma mark - Keyboard Handlers
- (void)handleKeyboardWillShow:(NSNotification *)notification
{
    // detail view
    self.detailView.gestureRecognizer.enabled = YES;
    [self.detailView.actionBarVC disableAllActions];
    
    [self.placeholderLabel removeFromSuperview];
	[self resizeView:notification];
	[self scrollToBottomAnimated:YES];
    
    if ([@"Write a message..." isEqualToString:self.textView.text]) {
        self.textView.text = @"";
    }
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
	//detail view
    self.detailView.gestureRecognizer.enabled = NO;
    [self.detailView.actionBarVC enableAllActions];
    
    [self resizeView:notification];
    if (![@"" isEqualToString:self.textView.text]) {
        [self.placeholderLabel removeFromSuperview];
    } else {
        [self.imageInput addSubview:self.placeholderLabel];

    }
    
}

- (void)resizeView:(NSNotification*)notification
{
	CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	CGFloat viewHeight =  self.detailView.view.frame.size.height;
    CGFloat keyboardY = [self.detailView.view convertRect:keyboardRect fromView:nil].origin.y;
	CGFloat diff = keyboardY - viewHeight;
   	
	// Thanks to Raja Baz (@raja-baz) for the delay's animation fix.
	CGFloat delay = 0.0f;
	CGRect beginRect = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	diff = beginRect.origin.y - viewHeight;
	if (diff > 0) {
		double fraction = diff/beginRect.origin.y;
		delay = duration * fraction;
		duration -= delay;
	}
	
	void (^completition)(void) = ^{
		CGFloat inputViewFrameY = keyboardY - self.view.frame.size.height;
        
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     inputViewFrameY,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
       
        self.detailView.scrollView.frame = CGRectMake(self.detailView.scrollView.frame.origin.x,
                                                      self.detailView.scrollView.frame.origin.y,
                                                      self.detailView.scrollView.frame.size.width,
                                                       inputViewFrameY);
};
	
	
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:500.0f  
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:completition
                     completion:nil];
	
}

- (void)resizeTextViewByHeight:(CGFloat)delta
{
	CGRect paragraphRect =
    [self.textView.attributedText boundingRectWithSize:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                           context:nil];
    
    int numLines = paragraphRect.size.height / self.textView.font.lineHeight;
    
	self.textView.contentInset = UIEdgeInsetsMake((numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f,
                                                  (numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f);
	
    //self.textView.scrollEnabled = (numLines >= 4);
}

- (void)handleTapGesture:(UIGestureRecognizer*)gesture
{
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self.buttonSend setEnabled:([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)];
    
	CGFloat maxHeight = self.textView.font.lineHeight * 6;
    CGFloat textViewContentHeight =  [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height;
	
	// Fixes the wrong content size computed by iOS7
    if (textView.text.UTF8String[textView.text.length-1] == '\n') {
        textViewContentHeight += textView.font.lineHeight;
    }
	
	
    if ([@"" isEqualToString:textView.text]) {
    	self.tempTextView = [[UITextView alloc] init];
    	self.tempTextView.font = self.textView.font;
    	self.tempTextView.text = self.textView.text;
		
    	CGSize size = [self.tempTextView sizeThatFits:CGSizeMake(self.textView.frame.size.width - 10, FLT_MAX)];
        textViewContentHeight  = size.height;
    }
    
	CGFloat delta = textViewContentHeight - self.previousTextFieldHeight;
	BOOL isShrinking = textViewContentHeight < self.previousTextFieldHeight;
    
	delta = (textViewContentHeight + delta >= maxHeight) ? 0.0f : delta;
	
	if(!isShrinking)
        [self resizeTextViewByHeight:delta];
    
    if(delta != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                            self.imageInput.frame = CGRectMake(0.0f,
                                                                self.imageInput.frame.origin.y - delta,
                                                                self.imageInput.frame.size.width,
                                                                self.imageInput.frame.size.height + delta);
                        
                             self.buttonSend.frame = CGRectMake(self.buttonSend.frame.origin.x,
                                                                self.buttonSend.frame.origin.y + delta,
                                                                self.buttonSend.frame.size.width,
                                                                self.buttonSend.frame.size.height);
                         }
                        completion:^(BOOL finished) {
                             if(isShrinking)
                                 [self resizeTextViewByHeight:delta];
                         }];
        
        self.previousTextFieldHeight = MIN(textViewContentHeight, maxHeight);
    }
	
	// This is a workaround for an iOS7 bug:
	// http://stackoverflow.com/questions/18070537/how-to-make-a-textview-scroll-while-editing
	
    if([textView.text hasSuffix:@"\n"]) {
        double delayInSeconds = 0.2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            CGPoint bottomOffset = CGPointMake(0, self.textView.contentSize.height - self.textView.bounds.size.height);
            [self.textView setContentOffset:bottomOffset animated:YES];
        });
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    [self.detailView scrollToBottomAnimated:animated];
}

#pragma mark - GGHMCDelegate

- (void) hashtagMentionController:(GGHashtagMentionController *)hashtagMentionController onMentionWithText:(NSString *)text range:(NSRange)range {
    
    if (!self.shouldSearchForUser) {
        //UIImage *blurred = [self.detailView.view blurredSnapshot];
        UIView *background = [[UIView alloc] initWithFrame:self.detailView.view.frame];
        background.backgroundColor = BG_COLOR;
        self.textView.blurredBackgroundView = background;
        self.detailView.scrollView.userInteractionEnabled = NO;
    }
    
    self.currentTokenRange = range;
    self.textView.autoCompleteQueryString = text;
    [self.textView shouldShowAutoCompleteTable:YES];
    self.shouldSearchForUser = YES;
}

- (void) hashtagMentionControllerDidFinishWord:(GGHashtagMentionController *)hashtagMentionController {
   self.detailView.scrollView.userInteractionEnabled = YES;
   [self.textView shouldShowAutoCompleteTable:NO];
    self.shouldSearchForUser = NO;
}


- (void)sendPressed:(id)sender
{
    [self.detailView didSendText:self.textView.text];
    [self.textView resignFirstResponder];
    [self.textView setText:@""];
	[self textViewDidChange:self.textView];
	[self resizeTextViewByHeight:self.textView.contentSize.height - self.previousTextFieldHeight];
    [self.buttonSend setEnabled:NO];
    [self.imageInput addSubview:self.placeholderLabel];
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Message Sent" properties:@{}];
	//[self scrollToBottomAnimated:YES];
    
}

#pragma mark - MLPAutoCompleteTextField DataSource


//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        NSArray *completions;
        completions = [AppDelegate sharedDelegate].store.account.team;
        
        handler(completions);
    });
}


#pragma mark - MLPAutoCompleteTextField Delegate

- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //This is your chance to customize an autocomplete tableview cell before it appears in the autocomplete tableview
    NSString *filename = [autocompleteString stringByAppendingString:@".png"];
    filename = [filename stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    filename = [filename stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    
    User *teammate = (User *)autocompleteObject;
    
    AtReplyMessageCell *messageCell = (AtReplyMessageCell *)cell;
    messageCell.nameLabel.text = teammate.name;
    NSURL *avatarUrl = [NSURL URLWithString:teammate.avatarUrl];
    [messageCell.avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Add the token to our text field
    NSMutableString *currentText = [NSMutableString stringWithString:self.textView.text];
    [currentText replaceCharactersInRange:self.currentTokenRange withString:@"@ "];
    [currentText insertString:[selectedObject autocompleteString] atIndex:(self.currentTokenRange.location + 1)];
    self.textView.text = currentText;
    
    // Add user interaction back in
    self.detailView.scrollView.userInteractionEnabled = YES;
    
//    if(selectedObject){
//        NSLog(@"selected object from autocomplete menu %@ with string %@", selectedObject, [selectedObject autocompleteString]);
//    } else {
//        NSLog(@"selected string '%@' from autocomplete menu", selectedString);
//    }
}


@end
